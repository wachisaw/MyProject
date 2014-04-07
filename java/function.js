//<meta http-equiv="Content-Type" content="text/html; charset=windows-874" />

function promptTeacher(fieldName, multiSelect) {
	window.open('teacher_prompt.php?returnField='+fieldName+'&multiSelect='+multiSelect, 'CtrlWindow', 'width=960,height=600,top=100,left=200,toolbar=no,menubar=no,location=no,scrollbars=yes,resizable=no,status=yes');
}
function promptSubject(fieldName, multiSelect) {
	window.open('subject_prompt.php?returnField='+fieldName+'&multiSelect='+multiSelect, 'CtrlWindow', 'width=600,height=600,top=100,left=200,toolbar=no,menubar=no,location=no,scrollbars=yes,resizable=no,status=yes');
}
function promptUser(fieldName, multiSelect) {
	window.open('usr_prompt.php?returnField='+fieldName+'&multiSelect='+multiSelect, 'CtrlWindow', 'width=500,height=600,top=100,left=200,toolbar=no,menubar=no,location=no,scrollbars=yes,resizable=no,status=yes');
}
function promptTrain(fieldName, multiSelect) {
	window.open('train_prompt.php?returnField='+fieldName+'&multiSelect='+multiSelect, 'CtrlWindow', 'width=960,height=600,top=100,left=200,toolbar=no,menubar=no,location=no,scrollbars=yes,resizable=no,status=yes');
}

function check_number() {
	e_k=event.keyCode;
	if (e_k != 46 && e_k != 45) {
		if (e_k != 13 && (e_k < 48) || (e_k > 57)) {
			event.returnValue = false;
			alert("��سҡ�͡�繵���Ţ��ҹ��");
		}
	}
}

function check_comma2() {
	e_k=event.keyCode;
	/*if (e_k == 44) {
		event.returnValue = false;
		alert("������͡����ͧ���� , (Comma)");
	}*/
	if (e_k == 59) {
		event.returnValue = false;
		alert("������͡����ͧ���� ; (Semicolon)");
	}
	if (e_k == 61) {
		event.returnValue = false;
		alert("������͡����ͧ���� = (Equal)");
	}
	if (e_k == 124) {
		event.returnValue = false;
		alert("������͡����ͧ���� | ");
	}
}

function check_blank() {
	if (e_k == 32) {
		event.returnValue = false;
		alert("������͡��ͧ��ҧ (space)");
	}
}

function check_comma() {
	e_k=event.keyCode;
	if (e_k == 44) {
		event.returnValue = false;
		alert("������͡����ͧ���� , (Comma)");
	}
	if (e_k == 59) {
		event.returnValue = false;
		alert("������͡����ͧ���� ; (Semicolon)");
	}
	if (e_k == 61) {
		event.returnValue = false;
		alert("������͡����ͧ���� = (Equal)");
	}
}

function check_comma3() {
	e_k=event.keyCode;
	if (e_k == 44) {
		event.returnValue = false;
		alert("������͡����ͧ���� , (Comma)");
	}
	if (e_k == 59) {
		event.returnValue = false;
		alert("������͡����ͧ���� ; (Semicolon)");
	}
	if (e_k == 61) {
		event.returnValue = false;
		alert("������͡����ͧ���� = (Equal)");
	}
	if (e_k == 124) {
		event.returnValue = false;
		alert("������͡����ͧ���� | ");
	}
}

function check_donotkey() {
	alert("���͹حҵ����͡��ͧ������ Keyboard");
	event.returnValue = false;
}


function id(name) {
	return document.getElementById(name);
}

function addRecord2(idname, idname2) {	//tableId, //hiddenInputId	¡��ԡ�����Ѿവ�Ѻ���ҧ���� IE ����ͧ�Ѻ�ѹ�� Runtime error
	var tmp = id(idname).innerHTML.split("</tbody>");
	nowRecordNo = parseInt(id(idname2).value) + 1;
	id(idname).innerHTML = tmp[0] + addText(nowRecordNo) + '</tbody>';
	id(idname2).value = nowRecordNo;
}

function addRecord(idname, idname2) {	//tableId, //hiddenInputId
	nowRecordNo = parseInt(id(idname2).value) + 1;
	id(idname).innerHTML += addText(nowRecordNo);
	id(idname2).value = nowRecordNo;
}

function viewInc1() {
	window.open('tool_viewinc1.php', 'CtrlWindow', 'width=550,height=300,top=100,left=200,toolbar=no,menubar=no,location=no,scrollbars=yes,resizable=no,status=yes');
}

function chkBlank(idname, text, hasBlank) {
	if (hasBlank == false) {
		if (id(idname).value == "") {
			alert(text);
			id(idname).focus();
			return true;
		} else {
			return false;
		}
	}
	return hasBlank;
}

function focusCursor() {
	if (event.srcElement.createTextRange) {
		event.srcElement.caretPos = document.selection.createRange().duplicate();
	}
}

function insertTab(idname) {
	if (!id(idname).onselect) {
		setTab(id(idname));
	}
	var sign = '\t';
	var t = id(idname);
	if (t.createTextRange && t.caretPos) {
		var caretPos = t.caretPos;
		caretPos.text = sign;
		t.focus();
	} else {
		t.value += sign;
		t.focus();
	}
}

function setTab(obj) {
	obj.onselect = focusCursor;
	obj.onclick = focusCursor;
	obj.onkeyup = focusCursor;
	obj.onchange = focusCursor;
}


function trim(stringToTrim) {
	return stringToTrim.replace(/^\s+|\s+$/g,"");
}

function trimx(stringToTrim) {
	var tmp = stringToTrim.replace(/^\s+|\s+$/g,"");
	tmp = tmp.replace(",", "");
	tmp = tmp.replace(";", "");
	tmp = tmp.replace("=", "");
	return tmp;
}


var beforevalue = 0;
var aftervalue = 0;
function savebefore(idname) {
	beforevalue = parseFloat(id(idname).value);
}

function chkafter(idname, idhidden) {
	aftervalue = parseFloat(id(idname).value);
	if (beforevalue != aftervalue) {
		id(idhidden).value = "1";
	}
}

function clrval(idname) {
	id(idname).value = "";
}

function klist_reoutput(group) {
	if (id(group+"hidden").value == "") {
		id(group+"output").innerHTML = "<br/> * ��سҡ�͡�����Ŵ�ҹ�����ǡ����� '���������ʵ�'<br/><br/>";
		return false;
	}
	output = "";
	seq = 0;
	rows = id(group+"hidden").value.split("|");
	labels = id(group+"label").value.split(";");
	for (i=0; i<rows.length; i++) {
		seq++;
		//output += "<br/>";
		output += "<strong>"+seq+".</strong> ";
		row = rows[i].split(";");
		for (j=0; j<row.length; j++) {
			output += "<strong>"+labels[j]+": </strong><u>"+row[j]+"</u> ";
		}
		dellink = "";
		uplink = "";
		downlink = "";
		dellink = "<a href=\"#\" onclick=\"klist_remove('"+group+"','"+i+"'); return false;\">ź</a>";
		if (i != 0) {
			uplink = " | <a href=\"#\" onclick=\"klist_moveup('"+group+"','"+i+"'); return false;\">����͹���</a>";
		}
		if (i+1 != rows.length) {
			downlink = " | <a href=\"#\" onclick=\"klist_movedown('"+group+"','"+i+"'); return false;\">����͹ŧ</a>";
		}
		output += "<span style='white-space:nowrap'>["+dellink+uplink+downlink+"]</span>";
		output += "<hr/>";
	}
	id(group+"output").innerHTML = "<br/>"+output+"<br/>";
}

function klist_remove(group, removeindex) {
	newvalue = "";
	rows = id(group+"hidden").value.split("|");
	for (i=0; i<rows.length; i++) {
		if (i == removeindex) {
			
		} else {
			if (newvalue != "") {
				newvalue += "|";
			}
			newvalue += rows[i];
		}
	}
	id(group+"hidden").value = newvalue;
	klist_reoutput(group);
}

function klist_add(group) {
	varnames = id(group+"varname").value.split(";");
	reqchks = id(group+"varchk").value.split(";");
	labels = id(group+"label").value.split(";");
	row = "";
	for (i=0; i<varnames.length; i++) {
		value = id(group+varnames[i]).value;
		if (reqchks[i] == "B") {
			if (value == "") {
				alert("��سҡ�͡"+labels[i]);
				id(group+varnames[i]).focus();
				return false;
			}
		}
		if (row != "") {
			row += ";";
		}
		row += id(group+varnames[i]).value;
	}
	
	if (id(group+"candup").value != "Y") {
		chks = id(group+"hidden").value.split("|");
		for (xx=0; xx<chks.length; xx++) {
			if (chks[xx] == row) {
				alert("������͡�����ū�ӡѺ��������� (�ӴѺ��� "+(xx+1)+")");
				id(group+varnames[0]).focus();
				return false;
			}
		}
	}
	
	if (id(group+"hidden").value != "") {
		row = "|"+row;
	}
	id(group+"hidden").value += row;
	klist_reoutput(group);
	
	for (i=0; i<varnames.length; i++) {
		id(group+varnames[i]).value = "";
	}
}

function klist_moveup(group, moveindex) {
	moveindex = parseInt(moveindex);
	newvalue = "";
	rows = id(group+"hidden").value.split("|");
	for (i=0; i<rows.length; i++) {
		if (i == moveindex-1) {
			if (newvalue != "") {
				newvalue += "|";
			}
			newvalue += rows[moveindex];
			newvalue += "|"+rows[moveindex-1];
			i++;
		} else {
			if (newvalue != "") {
				newvalue += "|";
			}
			newvalue += rows[i];
		}
	}
	id(group+"hidden").value = newvalue;
	klist_reoutput(group);
}

function klist_movedown(group, moveindex) {
	moveindex = parseInt(moveindex);
	newvalue = "";
	rows = id(group+"hidden").value.split("|");
	for (i=0; i<rows.length; i++) {
		if (i == moveindex) {
			if (newvalue != "") {
				newvalue += "|";
			}
			newvalue += rows[moveindex+1];
			newvalue += "|"+rows[moveindex];
			i++;
		} else {
			if (newvalue != "") {
				newvalue += "|";
			}
			newvalue += rows[i];
		}
	}
	id(group+"hidden").value = newvalue;
	klist_reoutput(group);
}