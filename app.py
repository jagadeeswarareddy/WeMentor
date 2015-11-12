# import the Flask class from the flask module
from flask import Flask, render_template, request, url_for, redirect, session,make_response
from flaskext.mysql import MySQL
import MySQLdb
from dbconnect import testdb
from httplib import HTTPResponse
from flask.ext.bootstrap import Bootstrap
from flask.ext.moment import Moment
from flask.ext.sqlalchemy import SQLAlchemy
from flask.ext.moment import Moment
#from flask_mysqldb import MySQL
import propertiesparser
import os
from flask import Flask, request
from flask.ext.sqlalchemy import SQLAlchemy
from sqlalchemy.engine import result
from flask.ext.wtf import Form
from wtforms import StringField, BooleanField
from wtforms.validators import DataRequired
from flask import render_template, flash, redirect


# create the application object
app = Flask(__name__)
#VARIABLE REQUIRED FOR ADMINISTRATOR MODULE
PAGE_LIMIT=10;


## set up connection to the database

mysql = MySQL()
db = SQLAlchemy(app)
app.config['SQLALCHEMY_DATABASE_URI'] = propertiesparser.getDatabaseSQLAlchemy()

app.secret_key = 'F12Zr47j\3yX R~X@H!jmM]Lwf/,?KT'
app.config['MYSQL_DATABASE_USER'] = propertiesparser.getDatabaseUserName();
app.config['MYSQL_DATABASE_PASSWORD'] = propertiesparser.getDatabasePassword();
app.config['MYSQL_DATABASE_DB'] = propertiesparser.getDatabaseName();
app.config['MYSQL_DATABASE_HOST'] = propertiesparser.getDatabaseHost();
mysql.init_app(app)
bootstrap = Bootstrap(app)
moment=Moment(app)
role = ''

## section for the login and registration modules
@app.route('/login')
def login():
	session.pop('username', None)
	return render_template('/login/login.html',title="ENABLE INDIA - LOGIN")
	
@app.route("/logout")
def Logout():
	session.pop('username', None)
	return render_template('/login/login.html',title="ENABLE INDIA - LOGIN")
		
@app.route('/validatelogin',methods=['GET'])
def validatelogin():
        logincredentials = request.args.get('name')
        username = logincredentials.split('|')[0]
        pwd = logincredentials.split('|')[1]
        #print username
        #print pwd
        connection = mysql.connect();
        connection.autocommit(True);
        #connection = MySQLdb.connect("127.0.0.1","root","root","ffg")
        cursor = connection.cursor()
        mysqlselectstatement = "SELECT Password,Role FROM accountinfo WHERE EMail = '"+username+"';"

        #print mysqlselectstatement
        cursor.execute(mysqlselectstatement)
        data = cursor.fetchone()
        print data
        global role

        if pwd == data[0]:
            #print "login success"
            session['username'] = username
            session['role'] = data[1]
            role = data[1]
            #print 'session variable set'
            #print session['username']
            return "success"
        else:
            #print "login failure"
            return "fail"

@app.route('/registration')
def registration():
    return render_template('/registration/registration.html',title="ENABLE INDIA - REGISTER")

@app.route('/addnewuser',methods=['POST'])
def addnewuser():
	#print "inside add new user"
	#connection = MySQLdb.connect("127.0.0.1","root","root","ffg")
	connection = mysql.connect();
	connection.autocommit(True);
	cursor = connection.cursor()
	#print "opened connection"
	username=request.form.get('username')
	#print username
	password=request.form.get('password')
	role=request.form.get('Role')
	mysqlselectstatement = "insert into accountinfo(EMail, Password, Role) values('"+username+"', '"+password+"','"+role+"');"
	#print mysqlselectstatement
	cursor.execute(mysqlselectstatement)
	if role == 'Mentor':
		mentor_insert = "insert into mentor(name,status) values('"+username+"','no');"
		cursor.execute(mentor_insert)
	connection.commit()
	return render_template('/registration/registration.html')

## section to render the base template based on the type of user role	

@app.route('/homepage')
def renderHomePage():
	if 'username' in session:
		username = request.args.get('name')
		#print username
		if session['role']=='Admin':
			return listMentee();
		if session['role']=='Mentee':
			return render_template('/application/blank.html',title="ENABLE INDIA",username=session['username'])
		if session['role']=='Mentor':
			return render_template('/application/blank.html',title="ENABLE INDIA",username=session['username'])
		if session['role']=='Moderator':
			return redirect(url_for('ModeratorLanding'))
	else : 
		return render_template('/errorpages/invalidLogin.html')
		
## section for the forum 
		
@app.route('/insertIntoForum',methods=['POST'])
def insertIntoForum():
	if 'username' in session:
		connection = mysql.connect();
		connection.autocommit(True);
		#connection = MySQLdb.connect("127.0.0.1","root","root","ffg")
		cursor = connection.cursor()
		topic_name=request.form['topic_name']
		topic_desc=request.form['topic_desc']
		mysqlselectstatement = "insert into forum_question(topic_name, topic_desc,user_name,topic_status) values('"+topic_name+"', '"+topic_desc+"','"+session['username']+"','Y');"
		cursor.execute(mysqlselectstatement)
		connection.commit()
		mysqlselectstatement = "SELECT * FROM forum_question"
		cursor.execute(mysqlselectstatement)
		data = cursor.fetchall()
		#print data
		return render_template('/forum/forum.html',data=data)
	else : 
		return render_template('/errorpages/invalidLogin.html')

@app.route("/forum",methods=['GET','POST'])
def forum():
	if 'username' in session:
		username = request.args.get('username')
		connection = mysql.connect();
		connection.autocommit(True);
		#connection = MySQLdb.connect("127.0.0.1","root","root","ffg")
		cursor = connection.cursor()
		mysqlselectstatement = "SELECT * FROM forum_question"
		cursor.execute(mysqlselectstatement)
		data = cursor.fetchall()
		return render_template('/forum/forum.html',data=data,title="ENABLE INDIA - FORUM",username=session['username'])
	else :
		return render_template('/errorpages/invalidLogin.html')

@app.route("/forumselect",methods=['GET'])
def forumselect():
	if 'username' in session:
		topicid = request.args.get('name')
		session['currentForumTopicId']=topicid
		#print topicid
		connection = mysql.connect();
		connection.autocommit(True);
		#connection = MySQLdb.connect("127.0.0.1","root","root","ffg")
		cursor = connection.cursor()
		mysqlselectstatement = "SELECT * FROM forum_answer WHERE question_id LIKE '"+topicid+"';"
		cursor.execute(mysqlselectstatement)
		data = cursor.fetchall()
		#print data
		mysqlselectstatement = "SELECT topic_status FROM forum_question WHERE topic_id LIKE '"+topicid+"';"
		cursor.execute(mysqlselectstatement)
		topicstatus = cursor.fetchone()
		#print "topic status"
		#print topicstatus
		mysqlselectstatement = "SELECT user_name FROM forum_question WHERE topic_id LIKE '"+topicid+"';"
		cursor.execute(mysqlselectstatement)
		topiccreator = cursor.fetchone()
		topiccreator = topiccreator[0]
		#print "topic creator"
		#print topiccreator
		if topiccreator==session['username']:
			creator = 'true'
		else: 
			creator = 'false'
		#print "creator"
		#print creator
		if "Y" in topicstatus:
			return render_template('/forum/forumanswer.html',data=data,topicstatus="true",username=session['username'],creator=creator)
		else:
			return render_template('/forum/forumanswer.html',data=data,topicstatus="false",username=session['username'])
	else :
		return render_template('/errorpages/invalidLogin.html')

@app.route("/closetopic",methods=['GET'])
def closetopic(): 
	topicid = request.args.get('name')
	#print 'topic id of the topic to be closed'
	#print session['currentForumTopicId']
	connection = mysql.connect();
	connection.autocommit(True);
	#connection = MySQLdb.connect("127.0.0.1","root","root","ffg")
	cursor = connection.cursor()
	mysqlselectstatement = "UPDATE forum_question SET topic_status = 'N' WHERE topic_id='"+session['currentForumTopicId']+"'"
	cursor.execute(mysqlselectstatement)
	connection.commit()
	return redirect(url_for('forum'))
	
		
@app.route("/forumquestion",methods=['GET','POST'])
def forumquestion():
	if 'username' in session:
		return render_template('/forum/forumquestion.html',title="ENABLE INDIA - CREATE TOPIC",username=session['username'])
	else :
		return render_template('/errorpages/invalidLogin.html')

@app.route("/insertResponse",methods=['GET'])
def insertresponse():
	if 'username' in session:
		topicanswer=request.args.get('forumQuestionTextArea')
		#print 'topicanswer'
		#print topicanswer
		topicid =session['currentForumTopicId']
		#print topicid
		username=session['username']
		#print username
		connection = mysql.connect();
		connection.autocommit(True);
		#connection = MySQLdb.connect("127.0.0.1","root","root","ffg")
		cursor = connection.cursor()
		mysqlselectstatement = "INSERT INTO forum_answer(question_id,answer_user_email,answer_content) values('"+topicid+"','"+username+"','"+topicanswer+"')"
		cursor.execute(mysqlselectstatement)
		connection.commit()
		return redirect(url_for('forum'))
	else :
		return render_template('/errorpages/invalidLogin.html')


##  section for the moderator module 

@app.route("/ModeratorLanding")
def ModeratorLanding():
	if 'username' in session:
		dashboard=[]
		no_of_mentor_req=Select("SELECT count(*) from mentor where status='no'","one")
		dashboard.append(no_of_mentor_req[0])
		no_of_matching_reqs=Select("select count(*) from matching where matchingid IS NULL;","one")
		dashboard.append(no_of_matching_reqs[0])
		no_of_mentors=9
		dashboard.append(no_of_mentors)
		no_of_mentees=64
		dashboard.append(no_of_mentees)
		ratio=no_of_mentees/no_of_mentors
		dashboard.append(str(ratio)+" : 1")
		return render_template('/moderator/moderator-landing.html',data=dashboard)
	return redirect(url_for('login'))
	

@app.route("/MentorApprovalLanding")
def MentorApprovalLanding():
	if 'username' in session:
		data = Select("SELECT * from mentor where status = 'no'","all")
		return render_template('/moderator/mentor-approval.html',data=data)
	return redirect(url_for('login'))
 
 
@app.route("/ApproveMentor",methods=['POST'])
def ApproveMentor():
	if 'username' in session:
		db = mysql.connect()
		db.autocommit(True);
		cursor = db.cursor()
		for name in request.form.getlist('approve'):
			query = "UPDATE mentor set status='yes' where name='" + name +"'"
			cursor.execute(query)
		cursor.close();
		db.close();
		
		return redirect(url_for('MentorApprovalLanding'))
	return redirect(url_for('login'))
	
	
@app.route("/UserDetails",methods=['GET'])
def UserDetails():
	##print "Entered"
	from1=request.args.get('from')
	#print from1
	return render_template('/moderator/user-details.html',frm=from1)

@app.route("/DeleteMentor",methods=['POST'])
def DeleteMentor():
	if 'username' in session:
		db = mysql.connect()
		db.autocommit(True);
		cursor = db.cursor()
		reqlist=request.form.getlist('cancel')
		
		for name in reqlist:
			query = "DELETE FROM mentor where name='" + name +"'"
			cursor.execute(query)
			
		cursor.close();
		db.close();
		return redirect(url_for('MentorApprovalLanding'))
	return redirect(url_for('login'))
	
	
@app.route("/MatchingRequestsLanding")
def MatchingRequestsLanding():
	if 'username' in session:
		data = Select("SELECT * from matching where matchingid IS NULL","all")
		return render_template('/moderator/matching-requests.html',data=data)
	return redirect(url_for('login'))
	
	
@app.route("/ApproveMatching",methods=['POST'])
def ApproveMatching():
	if 'username' in session:
		db = mysql.connect()
		db.autocommit(True);
		cursor = db.cursor()
		countTup=Select("select count(matchingid) from matching","one")
		count=countTup[0]
		
		for mentee in request.form.getlist('approvematch'):
			count=count+1
			mentor = request.form.get(mentee)
			matchid="enmat"+str(count)
			query = "UPDATE matching set selment='"+mentor+"', matchingid='"+matchid+"' where mentee='" + mentee+"'"
			cursor.execute(query)
			
		cursor.close();
		db.close();
		return redirect(url_for("MatchingRequestsLanding"))
	return redirect(url_for('login'))
	
	
@app.route("/ProgressLanding")
def ProgressLand():
	if 'username' in session:
		data = Select("SELECT * from progress","all")
		return render_template('/moderator/progress-landing.html',data=data)	
	return redirect(url_for('login'))
	
@app.route("/ChangePasswordMod")
def ChangePasswordMod():
	if 'username' in session:
		return render_template('/moderator/password-change.html',status="neutral")	
	return redirect(url_for('login'))
	
@app.route("/ChangePwdMod",methods=['POST'])
def ChangePwdMod():
	if 'username' in session:
		db = mysql.connect()
		db.autocommit(True);
		cursor = db.cursor()
		oldPassword = request.form['oldpwd']
		newPassword =request.form['newpwd']
		name = session['username']
		query ="UPDATE moderator set pwd ='" + newPassword +"' where name = '"+name+"' and pwd ='"+oldPassword+"'"
		cursor.execute(query)
		if cursor.rowcount <= 0:
			return render_template('/moderator/password-change.html',status="fail")
		else:
			session.pop('username', None)
			return render_template('/moderator/password-change.html',status="success")
	return redirect(url_for('login'))
	
def Select(query,type):
	result=0
	#db = MySQLdb.connect("127.0.0.1","root","root","ffg")
	db = mysql.connect();
	db.autocommit(True);
	cursor = db.cursor();
	cursor.execute(query)
	if type =="one":
		result = cursor.fetchone();
	elif type =="all":
		result=cursor.fetchall()
	cursor.close();
	db.close();
	return result;		
	
######################################
#ADMINISTRATOR MODULE FUNCTIONS STARTS#
######################################

@app.route("/listmentee")
def listMentee():
    #CHECK SESSION VARIABLE FOR TYPE OF USER
 if 'username' in session and session['role']=='Admin':
    length=0;
    page=0;
    data=[];
    display_list=[];
    display_list=testdb.listMentee();
    length=len(display_list)-1;
    page=request.args.get('page');
    
    if page is not None:
        page=int(page);
        if page > 0:
            l=int(page)-1;
        else:
            l=0;
            page=1;
    else:
        l=0;page=1;
    print page, l;
    lower=l*PAGE_LIMIT;
    upper=(int(page)*PAGE_LIMIT);
    if lower >=length:
        lower=(l-1)*PAGE_LIMIT;
        upper=length;
        page=page-1;
    elif upper >=length:
        upper=length;
    print upper;
    display_list=display_list[lower:upper];
    print "FETCHED";
    #return display_list;
    #session['type']="mentee";
    return render_template('/admin/admin_module.html',data=display_list, type="mentee", page=int(page));
 else:
	return render_template('/errorpages/invalidLogin.html');

@app.route("/listmentor")
def listMentor():
    #CHECK SESSION VARIABLE FOR TYPE OF USER
 if 'username' in session and session['role']=='Admin':
    data=[];
    display_list=[];
    display_list=testdb.listMentor();
    length=len(display_list)-1;
    page=request.args.get('page');
    
    if page is not None:
        page=int(page);
        if page > 0:
            l=int(page)-1;
        else:
            l=0;
            page=1;
    else:
        l=0;page=1;
    print page, l;
    lower=l*PAGE_LIMIT;
    upper=(int(page)*PAGE_LIMIT);
    if lower >=length:
        lower=(l-1)*PAGE_LIMIT;
        upper=length;
        page=page-1;
    elif upper >=length:
        upper=length;
    print upper;
    display_list=display_list[lower:upper];
    #return display_list;
    #session['type']="mentor";
    return render_template('/admin/admin_module.html',data=display_list, type="mentor", page=int(page))
 else:
	return render_template('/errorpages/invalidLogin.html');

@app.route("/listmoderator")
def listModerator():
    #CHECK SESSION VARIABLE FOR TYPE OF USER
 if 'username' in session and session['role']=='Admin':
    data=[];
    display_list=[];
    display_list=testdb.listModerator();
    length=len(display_list)-1;
    page=request.args.get('page');
    if page is not None:
        page=int(page);
        if page > 0:
            l=int(page)-1;
        else:
            l=0;
            page=1;
    else:
        l=0;page=1;
    print page, l;
    lower=l*PAGE_LIMIT;
    upper=(int(page)*PAGE_LIMIT);
    if lower >=length:
        lower=(l-1)*PAGE_LIMIT;
        upper=length;
        page=page-1;
    elif upper >=length:
        upper=length;
    print upper;
    display_list=display_list[lower:upper];
    #session['type']="moderator";
    return render_template('/admin/admin_module.html',data=display_list, type="moderator", page=int(page))
 else:
	return render_template('/errorpages/invalidLogin.html');

@app.route("/viewapproval")
def viewApprovals():
    #CHECK SESSION VARIABLE FOR TYPE OF USER
 if 'username' in session and session['role']=='Admin':
    data=testdb.fetchPendingModerator();
    #session['type']="mentee";
    return render_template('/admin/admin_module.html',data=data,option="approval",type="moderator",listall="listall")
 else:
	return render_template('/errorpages/invalidLogin.html');

@app.route("/viewmentee")
def viewMentee():
    #CHECK SESSION VARIABLE FOR TYPE OF USER
 if 'username' in session and session['role']=='Admin':
    page=0;
    id=request.args.get('id');
    data=testdb.viewMentee(id);
    #session['type']="mentee";
    return render_template('/admin/admin_module.html',data=data,option="view",listall="listall", type="mentee")
 else:
	return render_template('/errorpages/invalidLogin.html');

@app.route("/viewmentor")
def viewMentor():
    #CHECK SESSION VARIABLE FOR TYPE OF USER
 if 'username' in session and session['role']=='Admin':
    id=request.args.get('id');
    data=testdb.viewMentor(id);
    #session['type']="mentee";
    return render_template('/admin/admin_module.html',data=data,option="view",listall="listall", type="mentor")
 else:
	return render_template('/errorpages/invalidLogin.html');

@app.route("/viewmoderator")
def viewModerator():
    #CHECK SESSION VARIABLE FOR TYPE OF USER
 if 'username' in session and session['role']=='Admin':
    id=request.args.get('id');
    data=testdb.viewModerator(id);
    #session['type']="mentee";
    return render_template('/admin/admin_module.html',data=data,id=id,option="view",listall="listall", type="moderator")
 else:
	return render_template('/errorpages/invalidLogin.html');


@app.route("/search",methods=['POST'])
def search():
    #CHECK SESSION VARIABLE FOR TYPE OF USER
 if 'username' in session and session['role']=='Admin':
    key=request.form['searchkey'];
    display_list=[];
    display_list=testdb.search(key);
    print "FETCHED"
    #ession['type']="mentee";
    return render_template('/admin/dmin_module.html',data=display_list,listall="listall")
 else:
	return render_template('/errorpages/invalidLogin.html');

@app.route("/searchmentee",methods=['POST'])
def searchMentee():
    #CHECK SESSION VARIABLE FOR TYPE OF USER
 if 'username' in session and session['role']=='Admin':
    key=request.form['menteesearchkey'];
    display_list=[];
    display_list=testdb.searchMentee(key);
    print "FETCHED"
    #session['type']="mentee";
    return render_template('/admin/admin_module.html',data=display_list,listall="listall", option="search", type="mentee")
 else:
	return render_template('/errorpages/invalidLogin.html');

@app.route("/searchmentor",methods=['POST'])
def searchMentor():
    #CHECK SESSION VARIABLE FOR TYPE OF USER
 if 'username' in session and session['role']=='Admin':
    key=request.form['mentorsearchkey'];
    display_list=[];
    display_list=testdb.searchMentor(key);
    print "FETCHED"
    #session['type']="mentee";
    return render_template('/admin/admin_module.html',data=display_list,listall="listall", option="search", type="mentor")
 else:
	return render_template('/errorpages/invalidLogin.html');

@app.route("/searchmoderator",methods=['POST'])
def searchModerator():
    #CHECK SESSION VARIABLE FOR TYPE OF USER
 if 'username' in session and session['role']=='Admin':
    key=request.form['moderatorsearchkey'];
    display_list=[];
    display_list=testdb.searchModerator(key);
    print "FETCHED"
    #session['type']="mentee";
    return render_template('/admin/admin_module.html',data=display_list,listall="listall", option="search", type="moderator")
 else:
	return render_template('/errorpages/invalidLogin.html');

@app.route("/submitapprovals",methods=['GET','POST'])
def submitApprovals():
    #CHECK SESSION VARIABLE FOR TYPE OF USER
 if 'username' in session and session['role']=='Admin':
    temp_list=[];
    temp_list=testdb.fetchPendingModerator();
    
    for  temprow in temp_list:
        
        if temprow:
            temp=();
            temp=temprow;
            a='status_'+str(temp[0]);
            key=request.form.get(a);
            if key:
                val=testdb.updateModeratorStatus(str(temp[0]),key);

    data=[];
    data=testdb.fetchPendingModerator();
    #session['type']="mentee";
    return render_template('/admin/dmin_module.html',data=data,option="approval",type="moderator",listall="listall");
 else:
	return render_template('/errorpages/invalidLogin.html');


@app.route("/reporting")
def reporting():
    return "TO BE ADDED";

####################################
#ADMINISTRATOR MODULE FUNCTIONS ENDS#
####################################

#################################
#REPORTING MODULE FUNCTIONS START
#################################



@app.errorhandler(404)
def page_not_found(e):
    return render_template('/report/404.html'), 404


@app.errorhandler(500)
def internal_server_error(e):
    return render_template('/report/500.html'), 500


@app.route('/orgDetails', methods=['GET', 'POST'])
def index():
    cursor=mysql.connect().cursor()
    cursor.execute("select count(*) from Registration ")
    total=cursor.fetchone()
    cursor.execute("select count(*) from Registration where Type= 'Mentee' ")
    No_Mentee=cursor.fetchone()
    cursor.execute("select count(*) from Registration where Type= 'Mentor' ")
    No_Mentor=cursor.fetchone()
    cursor.execute("select count(*) from Registration where Type= 'Moderator'")
    No_Moderator=cursor.fetchone()
    cursor.execute("select count(*) from Registration where Type= 'Administrator'")
    No_Administrator=cursor.fetchone()
    cursor.execute("Select count(*) from Mentor_MenteeMatching where ApprovalType='Accepted'")
    No_Accepted=cursor.fetchone()
    cursor.execute("Select count(*) from Mentor_MenteeMatching where ApprovalType='Rejected'")
    No_Rejected=cursor.fetchone()
    
    return render_template('/report/OrgInfo.html',total=total,No_Mentee=No_Mentee,No_Mentor=No_Mentor,No_Moderator=No_Moderator,No_Administrator=No_Administrator,No_Accepted=No_Accepted,No_Rejected=No_Rejected)

@app.route('/report')

def reports():
   
    id=request.args.get('id');	
    cursor=mysql.connect().cursor()
    cursor.execute("select * from Registration where ID="+id)
    register=cursor.fetchone()
    #cursor.execute("select MatchId from Mentor_MenteeMatching where MentorID="+id+"OR MenteeID="+id)
    #MatchId=cursor.fetchone()
    cursor.execute("select count(Test_description),avg(Score) from Test where MatchID=1")
    test=cursor.fetchone()
    cursor.execute("select * from Milestone")
    milestone=cursor.fetchone()
    return render_template('/report/user.html',user=register,Test=test,Milestone=milestone)

@app.route('/report/orgReport/Downloads', methods=['GET', 'POST'])
def OrgDownload():
    cursor=mysql.connect().cursor()
    cursor.execute("select count(*) from Registration ")
    total=cursor.fetchone()
    cursor.execute("select count(*) from Registration where Type= 'Mentee' ")
    No_Mentee=cursor.fetchone()
    cursor.execute("select count(*) from Registration where Type= 'Mentor' ")
    No_Mentor=cursor.fetchone()
    cursor.execute("select count(*) from Registration where Type= 'Moderator'")
    No_Moderator=cursor.fetchone()
    cursor.execute("select count(*) from Registration where Type= 'Administrator'")
    No_Administrator=cursor.fetchone()
    cursor.execute("Select count(*) from Mentor_MenteeMatching where ApprovalType='Accepted'")
    No_Accepted=cursor.fetchone()
    cursor.execute("Select count(*) from Mentor_MenteeMatching where ApprovalType='Rejected'")
    No_Rejected=cursor.fetchone()
    csv=render_template('/report/OrgInfoDownload.html',total=total,No_Mentee=No_Mentee,No_Mentor=No_Mentor,No_Moderator=No_Moderator,No_Administrator=No_Administrator,No_Accepted=No_Accepted,No_Rejected=No_Rejected)
    response = make_response(csv)
    response.headers["Content-Disposition"] = "attachment; filename=books.doc"
    return response


@app.route('/download')
def downloads():
    id=request.args.get('id')
    cursor=mysql.connect().cursor()
    cursor.execute("select * from Registration where ID="+id)
    register=cursor.fetchone()
    #cursor.execute("select MatchId from Mentor_MenteeMatching where MentorID="+id+"OR MenteeID="+id)
    #MatchId=Cursor.fetchone()
    cursor.execute("select count(Test_description),avg(Score) from Test where MatchID=1")
    test=cursor.fetchone()
    cursor.execute("select * from Milestone")
    milestone=cursor.fetchone()
    csv=render_template('/report/download.html',user=register,Test=test,Milestone=milestone)
    
    # We need to modify the response, so the first thing we 
    # need to do is create a response out of the CSV string
    response = make_response(csv)
    # This is the key: Set the right header for the response
    # to be downloaded, instead of just printed on the browser
    response.headers["Content-Disposition"] = "attachment; filename=books.doc"
    return response

#########################
#REPORTING FUNCTION ENDS
##########################

#########################
#MENTORSHIP PROGRAM FUNCTIONALITY
##########################


# app = Flask(__name__)
# dbmodel.py
# This is supposed to be in the DB Model class.
# Will be moved later


class DefaultAttributes():

    default_progress_percentage = 15
    preinput_match_id = 1
    # session_id.mentor_mentee_match_id = 2

class Mentors(db.Model):
  __tablename__ = 'Mentors'
  mentor_id = db.Column(db.Integer, primary_key = True)
  mentor_name = db.Column(db.String(100))

  def __init__(self, mentor_id,mentor_name):
    self.mentor_id= mentor_id
    self.mentor_name=mentor_name
    return None

class Mentees(db.Model):
  __tablename__ = 'Mentees'
  mentee_id = db.Column(db.Integer, primary_key = True)
  mentee_name = db.Column(db.String(100))

  def __init__(self, mentee_id,mentee_name):
    self.mentee_id= mentee_id
    self.mentee_name=mentee_name
    return None

class MENTOR_MENTEE_MATCH(db.Model):
  __tablename__ = 'MENTOR_MENTEE_MATCH'
  match_id = db.Column(db.Integer, primary_key = True)
  mentor_id = db.Column(db.Integer)
  mentee_id = db.Column(db.Integer)

  def __init__(self, match_id,mentee_id,mentor_id):
    self.match_id = match_id
    self.mentee_id= mentee_id
    self.mentor_id =mentor_id
    return None

class PROGRESS(db.Model):
  __tablename__ = 'PROGRESS'
  match_id = db.Column(db.Integer)
  task_id = db.Column(db.Integer, primary_key = True)
  task_name = db.Column(db.String(200))
  task_description = db.Column(db.String(10000))
  task_status = db.Column(db.String(50))
  task_percentage = db.Column(db.Integer)

  def __init__(self, match_id,task_name,task_description,task_status,task_percentage):
    self.match_id = match_id
    self.task_name = task_name
    self.task_status = task_status
    self.task_description = task_description
    self.task_percentage = task_percentage
    return None

class conversations(db.Model):
  __tablename__ = 'conversations'
  match_id = db.Column(db.Integer)
  message_id = db.Column(db.Integer,primary_key=True)
  role = db.Column(db.String(100))
  message = db.Column(db.String(10000))
  title = db.Column(db.String(1000))

  def __init__(self, match_id,role,message,title):
    self.match_id = match_id
    self.role = role
    self.message = message
    self.title = title
    return None

class mentor_details(db.Model):
  __tablename__ = 'mentor_details'
  mentor_id = db.Column(db.Integer, primary_key = True)
  mentor_name = db.Column(db.String(100))
  mentor_phone = db.Column(db.String(20))
  mentor_email = db.Column(db.String(100))
  mentor_company =  db.Column(db.String(50))

  def __init__(self, mentor_id,mentor_name,mentor_phone,mentor_email,mentor_company ):
    self.mentor_id = mentor_id
    self.mentor_name = mentor_name
    self.mentor_phone = mentor_phone
    self.mentor_email = mentor_email
    self.mentor_company = mentor_company
    return None

class mentee_details(db.Model):
  __tablename__ = 'mentee_details'
  mentee_id = db.Column(db.Integer, primary_key = True)
  mentee_name = db.Column(db.String(100))
  mentee_phone = db.Column(db.String(20))
  mentee_email = db.Column(db.String(100))
  mentee_company =  db.Column(db.String(50))

  def __init__(self, mentee_id,mentee_name,mentee_phone,mentee_email,mentee_company ):
    self.mentee_id = mentee_id
    self.mentee_name = mentee_name
    self.mentee_phone = mentee_phone
    self.mentee_email = mentee_email
    self.mentee_company = mentee_company
    return None


# forms.py
# This is supposed to be an independent forum class
# Will be moved later
class MentorDetail(Form):
    mentor_name = StringField('mentor_name')
    mentee_name = StringField('mentee_name')
    # openid = StringField('openid', validators=[DataRequired()])
    # remember_me = BooleanField('remember_me', default=False)

@app.route('/')
def EntryPoint():
    # for result in Mentors.query.order_by(Mentors.mentor_id.desc()).all():
    #     print result.__dict__

    #Mentors.query.filter_by(mentor_id=1).delete()
    #db.session.commit()
    return render_template('index.html')

@app.route('/viewDetails',methods=['GET','POST'])
def viewDetails():
    # form = MentorDetail()
    # flash('Requested for the following="%s"' %
    #           (Mentors.mentor_name) )
    # return render_template('viewDetails.html',
    #                        title='Mentorship Details',
    #                        form=form)
    session_id.mentor_mentee_match_id
    return render_template('viewDetails.html')


@app.route('/returnDetails', methods=['POST'])
def hello():
    name=request.form['mentor_name']
    id=request.form['mentor_id']
    u = Mentors(mentor_id=id, mentor_name=name)
    db.session.add(u)
    db.session.commit()
    return render_template('form_action.html', name=name, email=id)


@app.route('/viewProfile',methods=['GET','POST'])
def viewProfile():
	if 'username' in session:
	    match_query = MENTOR_MENTEE_MATCH.query.filter_by(match_id='1').first()
	    print match_query
	    mentor_id_selected = match_query.mentor_id
	    mentor_details_query = mentor_details.query.filter_by(mentor_id=mentor_id_selected).first()
	    mentor_name_select = mentor_details_query.mentor_name
	    mentor_details_values =  mentor_details_query.__dict__.values()
	    mentor_details_values.pop(0)

	    mentee_id_selected = match_query.mentee_id
	    mentee_details_query = mentee_details.query.filter_by(mentee_id=mentee_id_selected).first()
	    mentee_details_values = mentee_details_query.__dict__.values()
	    mentee_details_values.pop(0)
	    return render_template('program/profile.html',match_id='1',mentor_details=mentor_details_values,mentee_details=mentee_details_values)
	else : 
		return render_template('/errorpages/invalidLogin.html')

@app.route('/viewProgress', methods=['POST'])
def returnProgress():
	if 'username' in session:
	    feed_task_name=request.form['task_name']
	    feed_task_status=request.form['task_status']
	    feed_task_description=request.form['task_description']
	    print feed_task_description
	    u = PROGRESS(task_name=feed_task_name,
	                 task_status=feed_task_status,
	                 task_description=feed_task_description,
	                 task_percentage=DefaultAttributes.default_progress_percentage,
	                 match_id=DefaultAttributes.preinput_match_id
	                 )
	    db.session.add(u)
	    db.session.commit()
	    db.session.close()
	    if u:
	        print "Commit was successfull"
	    active_task_details = PROGRESS.query.all()
	    return render_template('program/progress.html',task_list=active_task_details)
	else:
		return render_template('/errorpages/invalidLogin.html')




@app.route('/viewProgress',methods=['GET'])
def viewProgress():
	if 'username' in session:
	    active_task_details = PROGRESS.query.filter_by(match_id='1').all()
	    return render_template('program/progress.html',task_list=active_task_details)
	else:
		return render_template('/errorpages/invalidLogin.html')


@app.route('/viewConversations',methods=['GET'])
def viewConversations():
    if 'username' in session:
	    messages = conversations.query.all()    # return render_template('program/conversations.html',task_list=active_task_details)
	    return render_template('program/conversations.html',message_list=messages)
    else:
		return render_template('/errorpages/invalidLogin.html')

@app.route('/viewConversations', methods=['POST'])
def returnConversations():
    message_title=request.form['message_title']
    message=request.form['message']
    u = conversations(message=message,
                 role=role,
                 title=message_title,
                 match_id=DefaultAttributes.preinput_match_id
                 )
    db.session.add(u)
    db.session.commit()
    db.session.close()

    if u:
        print "Commit was successfull"
    messages = conversations.query.all()
    return render_template('program/conversations.html',message_list=messages)




# start the server with the 'run()' method
if __name__ == '__main__':
    app.run(host='0.0.0.0',debug=True)
