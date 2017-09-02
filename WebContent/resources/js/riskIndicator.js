/*
 * Copyright (c) Siemens AG 2016 ALL RIGHTS RESERVED.
 * v2.0
 */

/*globals d3*/
/*exported RiskIndicator*/

var RiskIndicator = function(){
	'use strict';
	const version = 'v2.0';
	let riskIndicator = {};
	let svg;
	let topText, bottomText,bottomTextNormal;
	const color12 = 'rgb(255,255,255)';
	const color08 = 'rgb(232,232,236)';
	const color02 = 'rgb(48,48,64)';
	var height = Number.NaN;
	var width = Number.NaN;
	let findingBarConfig = [
		{
			topMessage: 'URGENT',
			colorIndicator: 'rgb(255,0,0)',
			bottomMessage: 'issues'
		},
		{
			topMessage: 'IMMEDIATE',
			colorIndicator: 'rgb(255,194,12)',
			bottomMessage: 'issues'
		},
		{
			topMessage: 'ASAP',
			colorIndicator: 'rgb(160,215,44)',
			bottomMessage: 'issues'
		}
	];
	let findingBarValues = [Number.NaN, Number.NaN, Number.NaN];
	let innerChart;
	let isDisabled = false;
	let margin = {
		top: 5,
		bottom: 5,
		right: 5,
		left: 5
	};
	function drawSvg(innerWidth, innerHeight) {
		//cleanup existing svg 
        d3.selectAll('svg').remove();
		//draw svg
		svg = d3.select('#js_chart').append('svg')
			.attr('id', 'rInSvg')
			.attr('width', innerWidth + margin.left + margin.right)
			.attr('height', innerHeight + margin.top + margin.bottom)
			.append('g')
			.attr('transform', 'translate(' + margin.left + ',' + margin.top + ')');
	}

	function drawLine(x1, y1, x2, y2, color, width) {
		svg.append('line')
			.attr('x1', x1)
			.attr('y1', y1)
			.attr('x2', x2)
			.attr('y2', y2)
			.style('stroke', color)
			.style('stroke-width', width);
	}

	function drawFindingBar(yPos, screenWidth, barHeight) {
		const _textLineMargin = 2;
		const _rectStrokeWidth = 1;
		let _findingBarCols = svg.selectAll('.rInFindingBarCols')
			.data(findingBarConfig).enter().append('g')
			.classed('rInFindingBarCols', true);
		// Draw colored rect
		_findingBarCols.append('rect')
			.attr('x', function (d, i) {
				return i * screenWidth / findingBarConfig.length;
			})
			.attr('y', yPos)
			.attr('width', screenWidth / findingBarConfig.length)
			.attr('height', barHeight)
			.style('stroke', color12)
			.style('stroke-width', _rectStrokeWidth)
			.style('fill', color08);
		// Draw top text
		_findingBarCols.append('text')
			.classed('diagramLabel', true)
			.attr('y', yPos + _textLineMargin + _rectStrokeWidth / 2).attr('dy', '.71em')
			.attr('x', function (d, i) {
				return (i * screenWidth / findingBarConfig.length) + _textLineMargin + _rectStrokeWidth / 2;
			})
			.text(function (d) { return d.topMessage; });
		// Draw color line
		_findingBarCols.append('line')
			.attr('x1', function (d, i) {
				return i * screenWidth / findingBarConfig.length + _rectStrokeWidth / 2;
			})
			.attr('y1', barHeight + yPos).attr('x2', function (d, i) {
				return i * screenWidth / findingBarConfig.length + screenWidth / findingBarConfig.length - _rectStrokeWidth / 2;
			}).attr('y2', barHeight + yPos).style('stroke', function (d) { return d.colorIndicator; })
			.style('stroke-width', 3);
		//Draw bottom message text
		let _bMsgVals = _findingBarCols.append('text')
			.classed('diagramValue1', true)
			.style('text-anchor', 'end').text(function (d) { return d.bottomMessage; })
			.attr('y', barHeight + yPos - 2 * _textLineMargin).attr('x', function (d, i) {
				return i * screenWidth / findingBarConfig.length + screenWidth / findingBarConfig.length - _textLineMargin - _rectStrokeWidth / 2;
			});
		// Draw bottom bold value text
		_findingBarCols.append('text')
			.classed('diagramValue2', true)
			.style('text-anchor', 'end').text(function (d, i) {
				if (isNaN(findingBarValues[i]))
					{
					return '';
					}
				return findingBarValues[i];
			})
			.attr('y', barHeight + yPos - 2 * _textLineMargin).attr('x', function (d, i) {
				return i * screenWidth / findingBarConfig.length + screenWidth / findingBarConfig.length - _textLineMargin - _rectStrokeWidth / 2 - d3.select(_bMsgVals.nodes()[i]).node().getBBox().width - 4;
			});
	}

	function writeTopText() {
		const _yPos = 27;
		const _leftMargin = 2;
		svg.append('text')
			.text(topText).attr('id', 'rInTopText')
			.classed('diagramValue1', true)
			.attr('x', _leftMargin).attr('y', _yPos);
	}

	function writeBottomText(wt, ht) {
		const _rightMargin = 2;
		const _bottomMargin = 18;
		svg.append('text')
			.text(bottomText).attr('id', 'rInBottomText')
			.style('text-anchor', 'end').classed('diagramValue2', true)
			.attr('x', wt - _rightMargin).attr('y', ht - _bottomMargin);
	}
	function writeBottomTextNormal(wt, ht) {
		const _rightMargin = 2;
		const _bottomMargin = 18;
		svg.append('text')
			.text(bottomTextNormal).attr('id', 'rInBottomText')
			.style('text-anchor', 'end').classed('diagramValue1', true)
			.attr('x', wt - _rightMargin).attr('y', ht - _bottomMargin);
	}

	riskIndicator.setMargin = function (tp, bt, rt, lt) {
		margin.top = tp;
		margin.bottom = bt;
		margin.right = rt;
		margin.left = lt;
	};

	riskIndicator.renderChart = function (chart) {
		innerChart = chart;
		console.log('riskIndicator.js version: ' + version);
		let _innerWidth = Number.isNaN(height) ? window.innerWidth - margin.left - margin.right : height - margin.left - margin.right;
		let _innerHeight = Number.isNaN(width) ?window.innerHeight - margin.top - margin.bottom : width - margin.top - margin.bottom;
		const _topBorder = 33;
		const _bottomBorder = 33;
		let _findingBarHt = _innerHeight * 0.15;

		drawSvg(_innerWidth, _innerHeight);
		// Draw top hori. line
		drawLine(0, _topBorder, _innerWidth, _topBorder, color02, 1);
		// Draw bottom hori. line
		drawLine(0, _innerHeight - _bottomBorder, _innerWidth, _innerHeight - _bottomBorder, color02, 1);

		drawFindingBar(_topBorder + 1, _innerWidth, _findingBarHt);
		writeTopText();
		writeBottomText(_innerWidth - 265, _innerHeight);
		writeBottomTextNormal(_innerWidth, _innerHeight);

		// Create placeholder for inner chart
		svg.append('g')
			.attr('id', 'chartArea')
			.attr('transform', 'translate(' + 0 + ',' + (_findingBarHt + _topBorder) + ')');
		// Draw inner chart
		if (innerChart !== null && innerChart !== undefined) {
			innerChart.setDimension(_innerHeight - (_findingBarHt + _bottomBorder + _topBorder), _innerWidth);
			innerChart.draw('#chartArea');
		}
		if (isDisabled)
			{
			svg.style('opacity', '0.6');
			}
	};

	riskIndicator.setTopText = function (tText) {
		topText = tText;
	};

	riskIndicator.setBottomText = function (bText) {
		bottomText = bText;
	};
	riskIndicator.setBottomTextNormal = function (bText) {
		bottomTextNormal = bText;
	};
	riskIndicator.setFindingBarConfiguration = function (findingBarCon) {
		findingBarConfig = findingBarCon;
	};

	riskIndicator.setFindingBarValues = function (findingBarVal) {
		findingBarValues = findingBarVal;
	};

	riskIndicator.setDisabled = function (flag) {
		isDisabled = flag;
	};
	
	riskIndicator.setDimension = function (ht, wt) {
		height = ht;
		width = wt;
	};

	window.onresize = function () {
		d3.selectAll('svg').remove();
		riskIndicator.renderChart(innerChart);
	};

	return riskIndicator;

};
/*
 * Copyright (c) Siemens AG 2016 ALL RIGHTS RESERVED.
 */