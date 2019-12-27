// generic functions
function elementHide(element)
{
    var elem = findElement(element);
    elem.style.display = 'none'
}
function elementShow(element)
{
    var elem = findElement(element);
    elem.style.display = 'block'
}


// demos
function exampleExpandContract(exampleTitle, contract, expand)
{
    elementShow(exampleTitle+expand)
    elementHide(exampleTitle+contract)
}

function exampleExpand(exampleTitle)
{
    exampleExpandContract(exampleTitle,'Short','Full');
}

function exampleContract(exampleTitle)
{
    exampleExpandContract(exampleTitle,'Full','Short');
}


// sections and nav bar
function showSection(chosensection )
{
	var sections = new Array("ContentsSection","InstallationSection","ExamplesSection","ShellSection","ToolsSection","UtilitiesSection","DocumentationSection","ContactSection");
	var i;
	for (i=0;i<8;i++)
	{
		hideLayer(sections[i]);
		lowlight(sections[i]);
	}
	showLayer(chosensection);
	highlight(chosensection);
}

function highlight(which)
{
	var vis;
	vis = findElement(which + 'Button').style;
	vis.display = 'none';

	vis = findElement(which + 'Active').style;
	vis.display ='inline-block';
}

function lowlight(which)
{
	var vis;
	vis = findElement(which + 'Button').style;
	vis.display = 'inline-block';

	vis = findElement(which + 'Active').style;
	vis.display = 'none';

}

function printVersion()
{
	var sections = new Array("ContentsSection","InstallationSection","ExamplesSection","ShellSection","ToolsSection","UtilitiesSection","DocumentationSection","ContactSection");
	var i=0;
	for (i=0;i<8;i++)
	{
		showLayer(sections[i]);
		lowlight(sections[i]);
	}
    // TODO: open all collapsed demos, training courses, utilities etc.
}

// helpers
function findElement(elementName)
{
    var elem;
    if( document.getElementById ) // this is the way the standards work
	elem = document.getElementById( elementName );
    else if( document.all ) // this is the way old msie versions work
    	elem = document.all[elementName];
    else if( document.layers ) // this is the way nn4 works
	elem = document.layers[elementName];
    return elem;
}

function toggleLayer( whichLayer )
{
  var elem, vis;
  elem = findElement(whichLayer);

  vis = elem.style;
  // if the style.display value is blank we try to figure it out here
  if(vis.display==''&&elem.offsetWidth!=undefined&&elem.offsetHeight!=undefined)
	vis.display = (elem.offsetWidth!=0&&elem.offsetHeight!=0)?'block':'none';
  vis.display = (vis.display==''||vis.display=='block')?'none':'block';
}

function showLayer( whichLayer )
{
  var elem, vis;
  elem = findElement(whichLayer);

  vis = elem.style;
  vis.display = 'block';
}

function hideLayer( whichLayer )
{
  var elem, vis;
  elem = findElement(whichLayer);

  vis = elem.style;
  vis.display = 'none';
}