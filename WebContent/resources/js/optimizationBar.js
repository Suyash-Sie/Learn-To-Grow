/*globals d3*/
/*exported OptimizationBar*/

var OptimizationBar = function() {
	'use strict';
	const version = 'v2.0';
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
			max: 1
	};
	let svgX = 0;
	let svgY = 0;
	let height = window.innerHeight;
	let width = window.innerWidth;
	let colors = ['rgb(255,0,0)', 'rgb(255,194,12)', 'rgb(160,215,44)'];
	/*let leftText = 'HIGH RISK';
	let rightText = 'LOW RISK';*/
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
		/*if(leftText === null && rightText === null)
		{	hTextWidth = 0;
		return; // returning to avoid .node().getBBox().width
		}*/
		const _barTextMargin = 4;
		let _lText = optimizationBarV4.svg.append('image')
		.attr("xlink:href", "data:image/png;base64,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")
		.attr("width", 50)
	    .attr("height", 50)
		.attr('id', 'oBarLeftText')
		.attr('dy', '.35em').classed('diagramLabel', true)
		let _rText = optimizationBarV4.svg.append('image')
		.attr("xlink:href", "data:image/svg+xml;base64,PD94bWwgdmVyc2lvbj0iMS4wIiBzdGFuZGFsb25lPSJubyI/PjwhRE9DVFlQRSBzdmc+PHN2ZyB2ZXJzaW9uPSIxLjEiIGJhc2VQcm9maWxlPSJmdWxsIiB4bWxuczpldj0iaHR0cDovL3d3dy53My5vcmcvMjAwMS94bWwtZXZlbnRzIiB4bWxuczp4bGluaz0iaHR0cDovL3d3dy53My5vcmcvMTk5OS94bGluayIgeG1sbnM9Imh0dHA6Ly93d3cudzMub3JnLzIwMDAvc3ZnIiBwcmVzZXJ2ZUFzcGVjdFJhdGlvPSJ4TWlkWU1pZCBtZWV0IiB6b29tQW5kUGFuPSJtYWduaWZ5IiAgIGlkPSJUZXN0IEZpbGUiICAgdmlld0JveD0iLTIxIC0yMSA0MiA0MiIgICB3aWR0aD0iODAwIiAgIGhlaWdodD0iODAwIj48ZGVmcz48cmFkaWFsR3JhZGllbnQgaWQ9InNoaW5lIiAgICAgIGN4PSIuMiIgY3k9Ii4yIiByPSIuNSIgZng9Ii4yIiBmeT0iLjIiPiAgPHN0b3Agb2Zmc2V0PSIwIiBzdG9wLWNvbG9yPSJ3aGl0ZSIgc3RvcC1vcGFjaXR5PSIuNyIvPiAgPHN0b3Agb2Zmc2V0PSIxIiBzdG9wLWNvbG9yPSJ3aGl0ZSIgc3RvcC1vcGFjaXR5PSIwIi8+PC9yYWRpYWxHcmFkaWVudD48cmFkaWFsR3JhZGllbnQgaWQ9ImdyYWQiICAgICAgY3g9Ii41IiBjeT0iLjUiIHI9Ii41IiA+ICA8c3RvcCBvZmZzZXQ9IjAiIHN0b3AtY29sb3I9InllbGxvdyIvPiAgPHN0b3Agb2Zmc2V0PSIuNzUiIHN0b3AtY29sb3I9InllbGxvdyIvPiAgPHN0b3Agb2Zmc2V0PSIuOTUiIHN0b3AtY29sb3I9IiNlZTAiLz4gIDxzdG9wIG9mZnNldD0iMSIgc3RvcC1jb2xvcj0iI2U4ZTgwMCIvPjwvcmFkaWFsR3JhZGllbnQ+ICA8L2RlZnM+PGNpcmNsZSByPSIyMCIgc3Ryb2tlPSJibGFjayIgc3Ryb2tlLXdpZHRoPSIuMTUiIGZpbGw9InVybCgjZ3JhZCkiLz48Y2lyY2xlIHI9IjIwIiBmaWxsPSJ1cmwoI3NoaW5lKSIvPjxnIGlkPSJyaWdodCI+ICA8ZWxsaXBzZSByeD0iMi41IiByeT0iNCIgY3g9Ii02IiBjeT0iLTciIGZpbGw9ImJsYWNrIi8+ICA8cGF0aCBmaWxsPSJub25lIiBzdHJva2U9ImJsYWNrIiBzdHJva2Utd2lkdGg9Ii41IiBzdHJva2UtbGluZWNhcD0icm91bmQiIGQ9Ik0gMTAuNiwyLjcgYSA0LDQsMCAwLDAgNCwzIi8+PC9nPjx1c2UgeGxpbms6aHJlZj0iI3JpZ2h0IiB0cmFuc2Zvcm09InNjYWxlKC0xLDEpIi8+PHBhdGggZmlsbD0ibm9uZSIgc3Ryb2tlPSJibGFjayIgc3Ryb2tlLXdpZHRoPSIuNzUiIGQ9Ik0gLTEyLDUgQSAxMy41LDEzLjUsMCAwLDAgMTIsNSBBIDEzLDEzLDAgMCwxIC0xMiw1Ii8+PC9zdmc+")
		.attr("width", 50)
	    .attr("height", 50)
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
};
