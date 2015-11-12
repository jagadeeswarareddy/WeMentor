function checkForm(formName,field)
{
	key=field.value;
	if(key!="" && key!=null)
	{		
		document.getElementById(formName).submit();
	}
}

function toggleclick(ele,t)
{
  var checkedStatus=t.checked;
  if(checkedStatus==true)
  {
    var s=document.getElementsByName(ele);
    for (var i = 0; i < s.length; i++) {
      s[i].checked = false;
    }
    t.checked=true;
  }
}