//<meta http-equiv="Content-Type" content="text/html; charset=windows-874" />

function clearList(idname, sign) {	
	if (id(idname).value == "") {
		return;
	}
	var tmp = id(idname).value.split(sign);
	id(idname).value = "";
	for (var i=0; i < tmp.length - 1; i++) {
		if (i > 0) {
			id(idname).value += sign;
		}
		id(idname).value += tmp[i];
	}
}

function addList9() {
	var num = '9';
	var idname = 'inc_002_004';
	var sign = ',\r\n';
	
	var hasBlank = false;
	hasBlank = chkBlank('xnam'+num, 'กรุณากรอกชื่อ', hasBlank);
	hasBlank = chkBlank('xamt'+num, 'กรุณากรอกจำนวนเงิน', hasBlank);
	if (!hasBlank) {
		if (id(idname).value != "" && trimx(id('xnam'+num).value) != "") {
			id(idname).value += sign;
		}
		id(idname).value += trimx(id('xnam'+num).value)+'='+trimx(id('xamt'+num).value);
		id('xnam'+num).value = "";
		id('xamt'+num).value = "";
	}
	id('xnam'+num).focus();
}

function addList10() {
	var num = '10';
	var idname = 'inc_002_005';
	var sign = ',\r\n';
	
	var hasBlank = false;
	hasBlank = chkBlank('xnam'+num, 'กรุณากรอกชื่อ', hasBlank);
	hasBlank = chkBlank('xamt'+num, 'กรุณากรอกจำนวนเงิน', hasBlank);
	if (!hasBlank) {
		if (id(idname).value != "" && trimx(id('xnam'+num).value) != "") {
			id(idname).value += sign;
		}
		id(idname).value += trimx(id('xnam'+num).value)+'='+trimx(id('xamt'+num).value);
		id('xnam'+num).value = "";
		id('xamt'+num).value = "";
	}
	id('xnam'+num).focus();
}

function addList8() {
	var num = '8';
	var idname = 'inc_002_001';
	var sign = ',\r\n';
	
	var hasBlank = false;
	hasBlank = chkBlank('xnam'+num, 'กรุณากรอกชื่อ', hasBlank);
	hasBlank = chkBlank('xamt'+num, 'กรุณากรอกจำนวนเงิน', hasBlank);
	if (!hasBlank) {
		if (id(idname).value != "" && trimx(id('xnam'+num).value) != "") {
			id(idname).value += sign;
		}
		id(idname).value += trimx(id('xnam'+num).value)+'='+trimx(id('xamt'+num).value);
		id('xnam'+num).value = "";
		id('xamt'+num).value = "";
	}
	id('xnam'+num).focus();
}

function addList1() {
	var num = '';
	var idname = 'inc_002_002';
	var sign = ',\r\n';
	
	var hasBlank = false;
	hasBlank = chkBlank('xnam'+num, 'กรุณากรอกชื่อ', hasBlank);
	hasBlank = chkBlank('xamt'+num, 'กรุณากรอกจำนวนเงิน', hasBlank);
	if (!hasBlank) {
		if (id(idname).value != "" && trimx(id('xnam'+num).value) != "") {
			id(idname).value += sign;
		}
		id(idname).value += trimx(id('xnam'+num).value)+'='+trimx(id('xamt'+num).value);
		id('xnam'+num).value = "";
		id('xamt'+num).value = "";
	}
	id('xnam'+num).focus();
}

function addList2() {
	var num = '2';
	var idname = 'inc_002_003';
	var sign = ',\r\n';
	
	var hasBlank = false;
	hasBlank = chkBlank('xnam'+num, 'กรุณากรอกชื่อ', hasBlank);
	hasBlank = chkBlank('xamt'+num, 'กรุณากรอกจำนวนเงิน', hasBlank);
	if (!hasBlank) {
		if (id(idname).value != "" && trimx(id('xnam'+num).value) != "") {
			id(idname).value += sign;
		}
		id(idname).value += trimx(id('xnam'+num).value)+'='+trimx(id('xamt'+num).value);
		id('xnam'+num).value = "";
		id('xamt'+num).value = "";
	}
	id('xnam'+num).focus();
}

function addList3() {
	var num = '3';
	var idname = 'assbjidbdegreestr';
	var sign = ',\r\n';
	
	var hasBlank = false;
	hasBlank = chkBlank('xnam'+num, 'กรุณากรอกรหัสวิชา', hasBlank);
	if (!hasBlank) {
		var str = id('xnam'+num).value.split(",");
		for (var i=0; i <str.length; i++) {
			if (id(idname).value != "" && trimx(str[i]) != "") {
				id(idname).value += sign;
			}
			id(idname).value += trimx(str[i]);
		}
		id('xnam'+num).value = "";
	}
	id('xnam'+num).focus();
}

function addList4() {
	var num = '4';
	var idname = 'assbjidmdegreestr';
	var sign = ',\r\n';
	
	var hasBlank = false;
	hasBlank = chkBlank('xnam'+num, 'กรุณากรอกรหัสวิชา', hasBlank);
	if (!hasBlank) {
		var str = id('xnam'+num).value.split(",");
		for (var i=0; i <str.length; i++) {
			if (id(idname).value != "" && trimx(str[i]) != "") {
				id(idname).value += sign;
			}
			id(idname).value += trimx(str[i]);
		}
		id('xnam'+num).value = "";
	}
	id('xnam'+num).focus();
}

function addList5() {
	var num = '5';
	var idname = 'teaown';
	var sign = ';\r\n';
	
	var hasBlank = false;
	hasBlank = chkBlank('xnam'+num, 'กรุณากรอกรหัสอาจารย์', hasBlank);
	if (!hasBlank) {
		var str = id('xnam'+num).value.split(",");
		for (var i=0; i <str.length; i++) {
			if (id(idname).value != "" && trimx(str[i]) != "") {
				id(idname).value += sign;
			}
			id(idname).value += trimx(str[i]);
		}
		id('xnam'+num).value = "";
	}
	id('xnam'+num).focus();
}



function addList6() {
	var num = '6';
	var idname = 'teahelp';
	var sign = ';\r\n';
	
	var hasBlank = false;
	hasBlank = chkBlank('xnam'+num, 'กรุณากรอกรหัสอาจารย์', hasBlank);
	if (!hasBlank) {
		var str = id('xnam'+num).value.split(",");
		for (var i=0; i <str.length; i++) {
			if (id(idname).value != "" && trimx(str[i]) != "") {
				id(idname).value += sign;
			}
			id(idname).value += trimx(str[i]);
		}
		id('xnam'+num).value = "";
	}
	id('xnam'+num).focus();
}

function addList7() {
	var num = '7';
	var idname = 'assrcstr';
	var sign = ',\r\n';
	
	var hasBlank = false;
	hasBlank = chkBlank('xnam'+num, 'กรุณากรอกชื่อแหล่ง', hasBlank);
	if (!hasBlank) {
		var str = id('xnam'+num).value.split(",");
		for (var i=0; i <str.length; i++) {
			if (id(idname).value != "" && trimx(str[i]) != "") {
				id(idname).value += sign;
			}
			id(idname).value += trimx(str[i]);
		}
		id('xnam'+num).value = "";
	}
	id('xnam'+num).focus();
}

/*function clearInc() {
	if (confirm('แน่ใจหรือไม่ที่จะล้างข้อความในหัวข้อรายรับทั้งหมด ?')) {
		id('inc_001_001').value = "";
		id('inc_001_002').value = "";
		id('inc_001_003').value = "";
		id('inc_002_001').value = "";
		id('inc_002_002').value = "";
		id('inc_002_003').value = "";
		id('xnam').value = "";
		id('xamt').value = "";
		id('xnam2').value = "";
		id('xamt2').value = "";
	}
}*/

function projpSbmChk1() {
	var hasBlank = false;
	var run = 0;
	var sum = 0;
	hasBlank = chkBlank('pjpnam', 'กรุณากรอกชื่อโครงการ', hasBlank);
	hasBlank = chkBlank('pjpownname', 'กรุณากรอกผู้รับผิดชอบโครงการ', hasBlank);
	hasBlank = chkBlank('pjpactby', 'กรุณากรอกผู้ดำเนินการ', hasBlank);
	if (hasBlank) {
		return !hasBlank
	} else {
		//alert(outcount);
		for (run = 1; run <= outcount; run++) {
			sum += id('out'+run).value;
		}
		if (sum == 0) {
			alert("กรุณากรอกรายจ่าย");
			id("out1").focus();
			return false;
		}
	}
	
	if ((id('pjpstu1goal').value 
		+ id('pjpstu2goal').value
		+ id('pjpstu3goal').value
		+ id('pjpstu4goal').value
		+ id('pjpstu5goal').value
		+ id('pjpteagoal').value
		+ id('pjpxgoal').value) == 0) {
		alert("กรุณาจำนวนเป้าหมาย");
		id("pjpstu1goal").focus();
		return false;
	}
}

function projpRejChk1() {
	var hasBlank = false;
	hasBlank = chkBlank('xrsn', 'กรุณากรอกเหตุผลการปฏิเสธโครงการ', hasBlank);
	return !hasBlank
}

function submitChk2() {
	var hasBlank = false;
	hasBlank = chkBlank('pjpfile', 'กรุณาเลือกไฟล์แนบ', hasBlank);
	return !hasBlank
}

function submitChk3() {
	var hasBlank = false;
	hasBlank = chkBlank('psjsbj', 'กรุณาเลือกรายวิชา', hasBlank);
	return !hasBlank
}

function submitChk4() {
	var hasBlank = false;
	hasBlank = chkBlank('pjcfile', 'กรุณาเลือกไฟล์แนบ', hasBlank);
	return !hasBlank
}

function submitChk5() {
	var hasBlank = false;
	hasBlank = chkBlank('rsnam', 'กรุณากรอกชื่อเรื่องวิจัย', hasBlank);
	return !hasBlank
}

function submitChk6() {
	var hasBlank = false;
	hasBlank = chkBlank('tsjsbj', 'กรุณาเลือกรายวิชา', hasBlank);
	if (hasBlank == false && id('tsjdegree1').checked == false && id('tsjdegree2').checked == false) {
		alert("กรุณาทำเครื่องหมายในหัวข้อ ระดับด้วย");
		hasBlank = true;
	}
	return !hasBlank
}

function submitChk7() {
	var hasBlank = false;
	hasBlank = chkBlank('thsnam', 'กรุณากรอกชื่อเรื่องงานนิพนธ์', hasBlank);
	hasBlank = chkBlank('thsown', 'กรุณากรอกชื่อผู้แต่ง', hasBlank);
	return !hasBlank
}

function submitChk8() {
	var hasBlank = false;
	hasBlank = chkBlank('awnam', 'กรุณากรอกชื่อเรื่อง', hasBlank);
	return !hasBlank
}


function submitChk10() {
	var hasBlank = false;
	hasBlank = chkBlank('tcid', 'กรุณากรอกรหัสอาจารย์', hasBlank);
	return !hasBlank
}

function submitChk11() {
	var hasBlank = false;
	hasBlank = chkBlank('bkddesc', 'กรุณากรอกสิ่งที่ต้องการ', hasBlank);
	hasBlank = chkBlank('bkdqty', 'กรุณากรอกจำนวน', hasBlank);
	return !hasBlank
}

function submitChk12() {
	var hasBlank = false;
	hasBlank = chkBlank('tldtool', 'กรุณากรอกครุภัณฑ์', hasBlank);
	hasBlank = chkBlank('tldunit1', 'กรุณากรอกจำนวน', hasBlank);
	return !hasBlank
}

function submitChk13() {
	var hasBlank = false;
	hasBlank = chkBlank('teaid', 'กรุณากรอกรหัสอาจารย์', hasBlank);
	hasBlank = chkBlank('year', 'กรุณากรอกปีการศึกษา', hasBlank);
	return !hasBlank
}

function submitChk14() {
	var hasBlank = false;
	hasBlank = chkBlank('czddesc', 'กรุณากรอกเนื้อหา', hasBlank);
	return !hasBlank
}

function submitChk15(idname) {
	var hasBlank = false;
	hasBlank = chkBlank(idname, 'กรุณากรอกปี', hasBlank);
	return !hasBlank
}

function submitChk16() {
	var hasBlank = false;
	hasBlank = chkBlank('tnnam', 'กรุณากรอกชื่อเรื่อง', hasBlank);
	hasBlank = chkBlank('tnplace', 'กรุณากรอกสถานที่', hasBlank);
	hasBlank = chkBlank('getdate3', 'กรุณากรอกวันที่', hasBlank);
	hasBlank = chkBlank('getdate4', 'กรุณากรอกวันที่', hasBlank);
	hasBlank = chkBlank('tnyr', 'กรุณากรอกปี', hasBlank);
	return !hasBlank
}

function submitChk17() {
	var hasBlank = false;
	hasBlank = chkBlank('year1', 'กรุณากรอกปี', hasBlank);
	hasBlank = chkBlank('year2', 'กรุณากรอกปี', hasBlank);
	hasBlank = chkBlank('sbj', 'กรุณากรอกรายวิชา', hasBlank);
	return !hasBlank
}

function submitChk18() {
	var hasBlank = false;
	hasBlank = chkBlank('year', 'กรุณากรอกปี', hasBlank);
	hasBlank = chkBlank('sbj', 'กรุณากรอกรายวิชา', hasBlank);
	return !hasBlank
}

function submitChk19(idname) {
	var hasBlank = false;
	hasBlank = chkBlank(idname, 'กรุณากรอกวันที่', hasBlank);
	return !hasBlank
}

function submitChk20() {
	var hasBlank = false;
	hasBlank = chkBlank('teaid', 'กรุณากรอกรหัสอาจารย์', hasBlank);
	return !hasBlank
}

function insertSbjExpress() {
	window.open('sbj_insert1.php?closeWindow=yes', 'CtrlWindow', 'width=600,height=350,top=100,left=200,toolbar=no,menubar=no,location=no,scrollbars=yes,resizable=no,status=yes');
}