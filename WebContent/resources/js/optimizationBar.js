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
	let leftText = '';
	let rightText = '';
	let hTextWidth = 0;
	let hImageWidth = 0;
	let sliderPosition = Number.NaN;
	let rectYMultiplier = 0.38;
	let rectHtMultiplier = 0.24;
	const color06 = 'rgb(0,0,255)';
	const color02 = 'rgb(48,48,64)';
	const color12 = 'rgb(255,255,255)';
	let markers = [];
	let sliderText;
	let optimizationValue=[];
	let showImage=false;
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

	function drawBarImages(wt, ht) {
		const _barTextMargin = 4;
		let _lImage = optimizationBarV4.svg.append('image')
		.attr("xlink:href", "data:image/png;base64,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")
		.attr("width", 50)
	    .attr("height", 50)
		.attr('id', 'oBarLeftImage')
		.attr('dy', '.35em').classed('diagramLabel', true);
		let _rImage = optimizationBarV4.svg.append('image')
		.attr("xlink:href", "data:image/svg+xml;base64,PD94bWwgdmVyc2lvbj0iMS4wIiBzdGFuZGFsb25lPSJubyI/PjwhRE9DVFlQRSBzdmc+PHN2ZyB2ZXJzaW9uPSIxLjEiIGJhc2VQcm9maWxlPSJmdWxsIiB4bWxuczpldj0iaHR0cDovL3d3dy53My5vcmcvMjAwMS94bWwtZXZlbnRzIiB4bWxuczp4bGluaz0iaHR0cDovL3d3dy53My5vcmcvMTk5OS94bGluayIgeG1sbnM9Imh0dHA6Ly93d3cudzMub3JnLzIwMDAvc3ZnIiBwcmVzZXJ2ZUFzcGVjdFJhdGlvPSJ4TWlkWU1pZCBtZWV0IiB6b29tQW5kUGFuPSJtYWduaWZ5IiAgIGlkPSJUZXN0IEZpbGUiICAgdmlld0JveD0iLTIxIC0yMSA0MiA0MiIgICB3aWR0aD0iODAwIiAgIGhlaWdodD0iODAwIj48ZGVmcz48cmFkaWFsR3JhZGllbnQgaWQ9InNoaW5lIiAgICAgIGN4PSIuMiIgY3k9Ii4yIiByPSIuNSIgZng9Ii4yIiBmeT0iLjIiPiAgPHN0b3Agb2Zmc2V0PSIwIiBzdG9wLWNvbG9yPSJ3aGl0ZSIgc3RvcC1vcGFjaXR5PSIuNyIvPiAgPHN0b3Agb2Zmc2V0PSIxIiBzdG9wLWNvbG9yPSJ3aGl0ZSIgc3RvcC1vcGFjaXR5PSIwIi8+PC9yYWRpYWxHcmFkaWVudD48cmFkaWFsR3JhZGllbnQgaWQ9ImdyYWQiICAgICAgY3g9Ii41IiBjeT0iLjUiIHI9Ii41IiA+ICA8c3RvcCBvZmZzZXQ9IjAiIHN0b3AtY29sb3I9InllbGxvdyIvPiAgPHN0b3Agb2Zmc2V0PSIuNzUiIHN0b3AtY29sb3I9InllbGxvdyIvPiAgPHN0b3Agb2Zmc2V0PSIuOTUiIHN0b3AtY29sb3I9IiNlZTAiLz4gIDxzdG9wIG9mZnNldD0iMSIgc3RvcC1jb2xvcj0iI2U4ZTgwMCIvPjwvcmFkaWFsR3JhZGllbnQ+ICA8L2RlZnM+PGNpcmNsZSByPSIyMCIgc3Ryb2tlPSJibGFjayIgc3Ryb2tlLXdpZHRoPSIuMTUiIGZpbGw9InVybCgjZ3JhZCkiLz48Y2lyY2xlIHI9IjIwIiBmaWxsPSJ1cmwoI3NoaW5lKSIvPjxnIGlkPSJyaWdodCI+ICA8ZWxsaXBzZSByeD0iMi41IiByeT0iNCIgY3g9Ii02IiBjeT0iLTciIGZpbGw9ImJsYWNrIi8+ICA8cGF0aCBmaWxsPSJub25lIiBzdHJva2U9ImJsYWNrIiBzdHJva2Utd2lkdGg9Ii41IiBzdHJva2UtbGluZWNhcD0icm91bmQiIGQ9Ik0gMTAuNiwyLjcgYSA0LDQsMCAwLDAgNCwzIi8+PC9nPjx1c2UgeGxpbms6aHJlZj0iI3JpZ2h0IiB0cmFuc2Zvcm09InNjYWxlKC0xLDEpIi8+PHBhdGggZmlsbD0ibm9uZSIgc3Ryb2tlPSJibGFjayIgc3Ryb2tlLXdpZHRoPSIuNzUiIGQ9Ik0gLTEyLDUgQSAxMy41LDEzLjUsMCAwLDAgMTIsNSBBIDEzLDEzLDAgMCwxIC0xMiw1Ii8+PC9zdmc+")
		.attr("width", 50)
	    .attr("height", 50)
		.attr('id', 'oBarRightImage')
		.attr('dy', '.35em').classed('diagramLabel', true);
		hTextWidth = Math.max(_lImage.node().getBBox().width, _rImage.node().getBBox().width) + _barTextMargin;
		_lImage.attr('x', 0).attr('y', (ht * rectYMultiplier/1.25));
		_rImage.attr('x', wt - hTextWidth + _barTextMargin).attr('y', (ht * rectYMultiplier/1.25));
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
	
	optimizationBarV4.setShowImage = function(showImage){
		showImage = showImage;
	};

	optimizationBarV4.setSliderType = function(type){
		sliderType = type;
	};

	optimizationBarV4.setOptimizationValues = function(values){
		optimizationValue=values;
	};

	optimizationBarV4.draw = function (idSelector,showImage) {
		console.log('optimizationBarV4.js version: ' + version);
		let _innerWidth = width - margin.left - margin.right;
		let _innerHeight = height - margin.top - margin.bottom;
		if (idSelector === null || idSelector === undefined)
			idSelector = '#js_chart';
		drawSvg(idSelector, _innerWidth, _innerHeight,showImage);
		defineGradient();
		console.log(showImage);
		if(showImage === true)
			drawBarImages(_innerWidth, _innerHeight);
		if(showImage === false)
			drawBarLabels(_innerWidth, _innerHeight);
		let _xScale = getXScale(hTextWidth, (_innerWidth - hTextWidth));		
		drawRectBar(_innerWidth, _innerHeight);
		drawMarkers(_xScale, _innerHeight);
		drawOptimizationMarkers(_xScale,_innerHeight);
		drawSlider(_xScale, _innerHeight, _innerWidth);
	};
	return optimizationBarV4;
};
