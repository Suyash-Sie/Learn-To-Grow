/*globals d3*/
/*exported OptimizationBar*/

(function (window) {
	'use strict';
	function defineOptimizationBarV4() {
		const version = 'v1.3';
		let optimizationBarV4 = {};
		let sliderType = 'normal';
		let margin = {
			top: 2,
			bottom: 2,
			right: 2,
			left: 2
		};
		let domain = {
			min: 0,
			max: 100
		};
		let svgX = 0;
		let svgY = 0;
		let height = window.innerHeight;
		let width = window.innerWidth;
		let colors = ['rgb(255,0,0)', 'rgb(255,194,12)', 'rgb(160,215,44)'];
		let leftText = 'HIGH RISK';
		let rightText = 'LOW RISK';
		let hTextWidth = 0;
		let sliderPosition = Number.NaN;
		let rectYMultiplier = 0.38;
		let rectHtMultiplier = 0.24;
		const color06 = 'rgb(0,0,255)';
		const color02 = 'rgb(48,48,64)';
		const color12 = 'rgb(255,255,255)';
		let markers = [];
		let sliderText;
		let optimizationValue=[];
		function drawRectBar(wt, ht) {
			optimizationBarV4.svg.append('rect')
				.attr('x', hTextWidth)
				.attr('y', ht * rectYMultiplier)
				.attr('id', 'oBarRect')
				.attr('width', wt - hTextWidth - hTextWidth)
				.attr('height', ht * rectHtMultiplier)
				.style('fill', 'url(#linear-gradient)');
		}

		function drawSvg(idSelector, wt, ht) {
			// Remove existing SVG
			d3.select(idSelector+' #oBarSvg').remove();
			// Draw SVG
			optimizationBarV4.svg = d3.select(idSelector).append('svg')
				.attr('width', wt + margin.left + margin.right)
				.attr('height', ht + margin.top + margin.bottom)
				.attr('x', svgX)
				.attr('y', svgY)
				.attr('id', 'oBarSvg')
				.append('g')
				.attr('transform', 'translate(' + margin.left + ',' + margin.top + ')');
		}

		function getColorScale() {
			return d3.scaleLinear()
				.domain([domain.min, domain.max])
				.range(colors);
		}

		function getXScale(x0, x1) {
			return d3.scaleLinear()
				.domain([domain.min, domain.max])
				.range([x0, x1]).clamp(true);
		}

		function defineGradient() {
			let _colorScale = getColorScale();
			let _gradient = optimizationBarV4.svg.append('defs')
				.append('linearGradient')
				.attr('id', 'linear-gradient')
				.attr('x1', '0%')
				.attr('y1', '0%')
				.attr('x2', '100%')
				.attr('y2', '0%')
				.attr('spreadMethod', 'pad');

			_gradient.selectAll('stop')
				.data(_colorScale.range())
				.enter().append('stop')
				.attr('offset', function (d, i) { return i / (_colorScale.range().length - 1); })
				.attr('stop-color', function (d) { return d; });
		}

		function drawBarLabels(wt, ht) {
			if(leftText === null && rightText === null)
			{	hTextWidth = 0;
				return; // returning to avoid .node().getBBox().width
			}
			const _barTextMargin = 4;
			let _lText = optimizationBarV4.svg.append('text')
				.attr('id', 'oBarLeftText')
				.attr('dy', '.35em').classed('diagramLabel', true).text(leftText);
			let _rText = optimizationBarV4.svg.append('text')
				.attr('id', 'oBarRightText')
				.attr('dy', '.35em').classed('diagramLabel', true).text(rightText);
			hTextWidth = Math.max(_lText.node().getBBox().width, _rText.node().getBBox().width) + _barTextMargin;
			_lText.attr('x', 0).attr('y', (ht * rectYMultiplier) + (ht * rectHtMultiplier / 2));
			_rText.attr('x', wt - hTextWidth + _barTextMargin).attr('y', (ht * rectYMultiplier) + (ht * rectHtMultiplier / 2));
		}

		function drawStrokeLine(x1, y1, x2, y2, color, wt, id) {
			optimizationBarV4.svg.append('line')
				.attr('x1', x1)
				.attr('y1', y1)
				.attr('x2', x2)
				.attr('y2', y2)
				.attr('id', id)
				.style('stroke', color)
				.style('stroke-width', wt);
		}

		function drawSlider(xScale, ht, wt) {
			if (!isNaN(sliderPosition)) {
				const _sliderTextMargin = 2;
				const _bottomTriangleMargin = 1;
				let _triangleHtMultiplier = rectHtMultiplier / 3;
				let _xPos = xScale(sliderPosition);
				let trianglePoints;
				const _delta = 7.5;
				let _triangleColor = color06;
				if(sliderType === 'normal')
				{
					drawStrokeLine(_xPos, ht * rectYMultiplier, _xPos, ht - _bottomTriangleMargin, color06, 1, 'oBarSliderLine');
					trianglePoints = _xPos + ', ' + (ht - ht * _triangleHtMultiplier) + ' ' +
						(_xPos - ht * _triangleHtMultiplier) + ', ' + (ht - _bottomTriangleMargin) + ' ' +
						(_xPos + ht * _triangleHtMultiplier) + ', ' + (ht - _bottomTriangleMargin);

					let _sliderText = optimizationBarV4.svg.append('text')
						.attr('id', 'oBarSliderText')
						.attr('x', _xPos + ht * _triangleHtMultiplier + _sliderTextMargin)
						.attr('y', ht - _bottomTriangleMargin - _sliderTextMargin)
						.classed('diagramValue2', true).text(sliderText);
					let _textWidth = _sliderText.node().getBBox().width;
					if(_textWidth + _xPos + ht * _triangleHtMultiplier > wt)
					{
						_sliderText.attr('x', _xPos - _sliderTextMargin - ht * _triangleHtMultiplier)
						.attr('text-anchor', 'end');
					}
				}
				else
				{
					trianglePoints = _xPos - _delta + ', ' + ht * rectYMultiplier + ' ' +
					(_xPos + _delta) + ', ' + ht * rectYMultiplier + ' ' +
					_xPos + ', ' + (ht*rectYMultiplier+ht * rectHtMultiplier); 
					_triangleColor = color12;
				}
				optimizationBarV4.svg.append('polyline')
				.attr('points', trianglePoints)
				.attr('stroke', _triangleColor)
				.style('fill', _triangleColor);					
			}
		}
		
		function drawOptimizationMarkers(xScale,ht){			
			let _barHt = ht*rectHtMultiplier;
			for (let i=0;i<optimizationValue.length;i++){
				let _xPos= xScale(optimizationValue[i]);
				drawStrokeLine(_xPos, (_barHt + (ht*rectYMultiplier)) , _xPos, ((_barHt + (ht*rectYMultiplier)) - (_barHt/2)), color02, 1, 'oBarOptMarkers'+i);
			}
		}
		
		function drawMarkers(xScale, ht) {
			const _topLineMargin = 9;
			const _strokeLineMargin = 2;
			const _strokeBarMargin = 1;
			markers.sort(function (a, b) { return xScale(a.value) - xScale(b.value); });
			let _markers = optimizationBarV4.svg.selectAll('.oBarMarkers')
				.data(markers).enter().append('g')
				.classed('oBarMarkers', true);
			// Draw marker line
			_markers.append('line')
				.attr('x1', function (d) {
					return xScale(d.value);
				})
				.attr('y1', _topLineMargin)
				.attr('x2', function (d) {
					return xScale(d.value);
				})
				.attr('y2', (ht * rectYMultiplier) - _strokeBarMargin)
				.style('stroke', color02)
				.style('stroke-width', 1);
			// Draw marker label
			_markers.append('text')
				.attr('x', function (d, i) {
					if (i % 2 === 0)
						{
						return xScale(d.value) - _strokeLineMargin;
						}
					else
						{
						return xScale(d.value) + _strokeLineMargin;
						}
				})
				.attr('y', _topLineMargin).attr('dy', '.71em')
				.classed('diagramLabel', true)
				.attr('text-anchor', function (d, i) {
					if (i % 2 === 0)
						{
						return 'end';
						}
					else
						{
						return 'start';
						}
				})
				.text(function (d) {
					return d.label;
				});
			// Draw marker value
			_markers.append('text')
				.attr('x', function (d, i) {
					if (i % 2 === 0)
						{
						return xScale(d.value) - _strokeLineMargin;
						}
					else
						{
						return xScale(d.value) + _strokeLineMargin;
						}
				})
				.attr('y', _topLineMargin + 14).attr('dy', '.71em')
				.classed('diagramValue1', true).text(function (d) {
					return d.valueText;
				}).attr('text-anchor', function (d, i) {
					if (i % 2 === 0)
						{
						return 'end';
						}
					else
						{
						return 'start';
						}
				});
		}

		optimizationBarV4.setDimension = function (ht, wt) {
			height = ht;
			width = wt;
		};

		optimizationBarV4.setMargin = function (tp, bt, rt, lt) {
			margin.top = tp;
			margin.bottom = bt;
			margin.right = rt;
			margin.left = lt;
		};

		optimizationBarV4.setDomain = function (mi, ma) {
			domain.min = mi;
			domain.max = ma;
		};

		optimizationBarV4.setLeftLabel = function (lt) {
			leftText = lt;
		};

		optimizationBarV4.setRightLabel = function (rt) {
			rightText = rt;
		};

		optimizationBarV4.setMarkers = function (barMarkers) {
			markers = barMarkers;
		};

		optimizationBarV4.setColors = function (cl) {
			colors = cl;
		};

		optimizationBarV4.setSliderPosition = function (pos) {
			sliderPosition = pos;
		};

		optimizationBarV4.setSvgCoordinates = function (x, y) {
			svgX = x;
			svgY = y;
		};

		optimizationBarV4.setChartMultipliers = function (yMultiplier, htMultipler) {
			rectYMultiplier = yMultiplier;
			rectHtMultiplier = htMultipler;
		};
		
		optimizationBarV4.setSliderText = function(text){
			sliderText = text;
		};

		optimizationBarV4.setSliderType = function(type){
			sliderType = type;
		};
		
		optimizationBarV4.setOptimizationValues = function(values){
			optimizationValue=values;
		};
		
		optimizationBarV4.draw = function (idSelector) {
			console.log('optimizationBarV4.js version: ' + version);
			let _innerWidth = width - margin.left - margin.right;
			let _innerHeight = height - margin.top - margin.bottom;
			if (idSelector === null || idSelector === undefined)
				idSelector = '#js_chart';
			drawSvg(idSelector, _innerWidth, _innerHeight);
			defineGradient();
			drawBarLabels(_innerWidth, _innerHeight);
			let _xScale = getXScale(hTextWidth, (_innerWidth - hTextWidth));
			drawRectBar(_innerWidth, _innerHeight);
			drawMarkers(_xScale, _innerHeight);
			drawOptimizationMarkers(_xScale,_innerHeight);
			drawSlider(_xScale, _innerHeight, _innerWidth);
		};
		return optimizationBarV4;
	}

	//Introduced in order to create new object
	window.OptimizationBarV4 = function(){
		return defineOptimizationBarV4();
	};
	//define globally if it doesn't already exist
	if (typeof (optimizationBarV4) === 'undefined') {
		window.optimizationBarV4 = defineOptimizationBarV4();
	}
	else {
		console.log('optimizationBarV4 already defined.');
	}
})(window);
