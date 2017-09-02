/*
 * Copyright (c) Siemens AG 2016 ALL RIGHTS RESERVED.
 * IDA-DLS
 * v1.0
 */

/*globals d3*/
/*exported  Benchmark*/

var benchMark = function() {
	'use strict';
	const version = 'v1.0';
	let benchmark = {};
	let svg;
	let topText, bottomText, enggUnit;
	const color02 = 'rgb(48,48,64)';
	let innerChart;
	let height = Number.NaN;
	let width = Number.NaN;
	let isDisabled = false;
	let margin = {
		top: 5,
		bottom: 5,
		right: 5,
		left: 5
	};
	function drawSvg(innerWidth, innerHeight,idSelector) {
		//cleanup existing svg 
        d3.selectAll(idSelector+' svg').remove();
		//draw svg
		svg = d3.select('#'+idSelector).append('svg')
			.attr('id', 'bmSvg')
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

	function writeTopText() {
		const _yPos = 27;
		const _leftMargin = 2;
		svg.append('text')
			.text(topText).attr('id', 'bmTopText')
			.classed('diagramValue1', true)
			.attr('x', _leftMargin).attr('y', _yPos);
	}

	function writeBottomText(wt, ht) {
		const _rightMargin = 2;
		const _bottomMargin = 18;
        let _xCoordinate = wt - _rightMargin - 5;
        let _enggUnitXCoordinate = svg.select('#bmEnggUnit').node().getBBox().x;
        if(_enggUnitXCoordinate > 0)
        	{
			_xCoordinate = _enggUnitXCoordinate;
        	}
		svg.append('text')
			.text(bottomText).attr('id', 'bmBottomText')
			.style('text-anchor', 'end').classed('diagramValue2', true)
			.attr('x', _xCoordinate).attr('y', ht - _bottomMargin);
	}

    function writeEnggUnit(wt, ht) {
		const _rightMargin = 2;
		const _bottomMargin = 18;
		svg.append('text')
			.text(enggUnit).attr('id', 'bmEnggUnit')
			.style('text-anchor', 'end').classed('diagramLabel', true)
			.attr('x', wt - _rightMargin).attr('y', ht - _bottomMargin);
	}

	benchmark.setMargin = function (tp, bt, rt, lt) {
		margin.top = tp;
		margin.bottom = bt;
		margin.right = rt;
		margin.left = lt;
	};

	benchmark.renderChart = function (chart,idSelector) {
		innerChart = chart;
		console.log('benchmark.js version: ' + version);
		/*let _innerWidth = window.innerWidth - margin.left - margin.right;
		let _innerHeight = window.innerHeight - margin.top - margin.bottom;*/
		let _innerWidth = document.getElementById(idSelector).offsetWidth;
		let _innerHeight = document.getElementById(idSelector).offsetHeight;
		const _topBorder = 33;
		const _bottomBorder = 33;

		drawSvg(_innerWidth, _innerHeight,idSelector);
		// Draw top hori. line
		drawLine(0, _topBorder, _innerWidth, _topBorder, color02, 1);
		// Draw bottom hori. line
		drawLine(0, _innerHeight - _bottomBorder, _innerWidth, _innerHeight - _bottomBorder, color02, 1);

		writeTopText();
        // Write Engg unit
        writeEnggUnit(_innerWidth, _innerHeight);
        // Write bottom text
		writeBottomText(_innerWidth, _innerHeight);
		// Create placeholder for inner chart
		svg.append('g')
			.attr('id', 'obs_chartArea')
			.attr('transform', 'translate(' + 0 + ',' + _topBorder + ')');
		// Draw inner chart
		if (innerChart !== null && innerChart !== undefined) {
			innerChart.setDimension(_innerHeight - (_bottomBorder + _topBorder), _innerWidth);
			innerChart.draw('#obs_chartArea');
		}
		if (isDisabled)
			{
			svg.style('opacity', '0.6');
			}
	};

	benchmark.setTopText = function (tText) {
		topText = tText;
	};

	benchmark.setBottomText = function (bText) {
		bottomText = bText;
	};

    benchmark.setEnggUnit = function (eUnit) {
		enggUnit = eUnit;
	};

	benchmark.setDisabled = function (flag) {
		isDisabled = flag;
	};

	/*window.onresize = function () {
		d3.selectAll('#obs_chart_riskind svg').remove();
		benchmark.renderChart(innerChart);
	};*/

	return benchmark;
};

/*
 * Copyright (c) Siemens AG 2016 ALL RIGHTS RESERVED.
 * IDA-DLS
 */