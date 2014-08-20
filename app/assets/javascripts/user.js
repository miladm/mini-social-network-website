// **********************************************
// ** Draw Tag Boxes to Generate Tags (CLASS) **
function Tagger(pic_id, box_id) {
    this.isMouseDown = false;
    this.element = document.getElementById(pic_id.id);
    this.element2 = document.getElementById(box_id.id);
    var picId = pic_id.id;
    var obj = this;
    // this.oldUpHandler = document.onmouseup;
    this.element.addEventListener ('mousedown', function (event) {
    	    obj.mouseclick (event, picId);
    	}
    );
}

Tagger.prototype.mouseclick = function (event, picId) {
  	var obj2 = this.element2;
  	var fixOffset = 1;
    obj2.style.left = event.pageX - fixOffset + "px";
    obj2.style.top  = event.pageY - fixOffset+ "px";
    obj2.style.width = fixOffset + "px";
    obj2.style.height = fixOffset + "px";
    obj2.className = "tagBoxViz";
    var TagLeft = event.pageX - fixOffset;
    var TagTop  = event.pageY - fixOffset;
    var TagWidth = event.pageX - TagLeft;
    var TagHeight  = event.pageY - TagTop;

    this.oldMoveHandler = document.onmousemove;
    document.onmousemove = function (event) {
	    obj2.style.width  = (event.pageX - TagLeft) + "px";
    	obj2.style.height = (event.pageY - TagTop) + "px";
		TagWidth = event.pageX - TagLeft;
		TagHeight  = event.pageY - TagTop;
    }
    document.onmouseup = function (event) {
        document.onmousemove = this.oldMoveHandler;
        // PASS TAG COORDINATES TO FORM
        document.getElementById(picId+'_tagTop').value = TagTop;
        document.getElementById(picId+'_tagLeft').value = TagLeft;
        document.getElementById(picId+'_tagHeight').value = TagHeight;
        document.getElementById(picId+'_tagWidth').value = TagWidth;
    }
}

// **********************************************
// ** Draw Styled Names on Tag Boxes (CLASS) **
function Drawer(tag_id) {
    this.isMouseDown = false;
    this.element = document.getElementById(tag_id.id);
    var obj = this;
    this.oldUpHandler = document.onmouseup;
	this.element.addEventListener ('mousemove', function (event) {
    	    obj.TagStyler (event);
    	}
    );
}

Drawer.prototype.TagStyler = function (event) {
    var obj = this.element;
    obj.style.border = "1px solid white";
    obj.style.color = "black";
    obj.style.fontWeight = "bold";
    obj.style.textAlign = "center";
    obj.style.background = "white";
    obj.style.opacity = "0.4";
}

// **********************************************
// ** Search the database for thumbnail images **
function doSearch (value) {
	var uri_value = encodeURIComponent(value);
	var myXHR = new XMLHttpRequest();
	myXHR.onreadystatechange = xhrHandler;
	myXHR.open("GET", "/users/search?qry="+uri_value, true);
	myXHR.send();

	function xhrHandler() {
		if (myXHR.readyState != 4) {
			return;
		}
		if (myXHR.status != 200) {
			return;
		}
		var queryResponse = JSON.parse(myXHR.responseText);
		var output = document.getElementById("image_search_result");
		output.innerHTML = ""
		for (indx = 0; indx < queryResponse.length; indx++) {
			var imag = "<a href=/users/"
			imag += queryResponse[indx].user_id;
			imag += "><img src=/assets/";
			imag += queryResponse[indx].file_name;
			imag += "#p2 height=120></a>";
			imag += "<br/>";
			output.innerHTML += imag;
			console.log(queryResponse[indx])
			console.log(imag)
		}
	}
}