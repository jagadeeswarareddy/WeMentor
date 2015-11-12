#from flask import Flask
#from flaskext.mysql import MySQL
#from flask import render_template
 
#mysql = MySQL()
#app = Flask(__name__)
#app.config['MYSQL_DATABASE_USER'] = 'root'
#app.config['MYSQL_DATABASE_PASSWORD'] = 'qwerty'
#app.config['MYSQL_DATABASE_DB'] = 'enableindia'
#app.config['MYSQL_DATABASE_HOST'] = 'localhost'
#mysql.init_app(app)
 
from dbconnect import app
from flaskext.mysql import MySQL
import propertiesparser

mysql = MySQL()

app.config['MYSQL_DATABASE_USER'] = propertiesparser.getDatabaseUserName();
app.config['MYSQL_DATABASE_PASSWORD'] = propertiesparser.getDatabasePassword();
app.config['MYSQL_DATABASE_DB'] = propertiesparser.getDatabaseName();
app.config['MYSQL_DATABASE_HOST'] = propertiesparser.getDatabaseHost();
mysql.init_app(app)

def hello():
  return "hello"

def list():
    db = mysql.connect();
    db.autocommit(True);
    cursor = db.cursor();
    query = "SELECT * from MENTEE_DUMMY";
    cursor.execute(query)
    final_list=[];
    data=[];

    data = cursor.fetchone();
    final_list.append(data);

    while data is not None:
      #print data[1];
      data = cursor.fetchone();
      final_list.append(data);


    cursor.close();
    db.close();

    return final_list;

def listMentee():
    db = mysql.connect();
    db.autocommit(True);
    cursor = db.cursor();
    query = "SELECT b.UserID, b.Name, b.Disability, a.EMail from accountinfo a , personalinfo b where a.UserID = b.UserID and a.Role='Mentee'";
    cursor.execute(query)
    final_list=[];
    data=[];

    data = cursor.fetchone();
    final_list.append(data);

    while data is not None:
      #print data[1];
      data = cursor.fetchone();
      final_list.append(data);


    cursor.close();
    db.close();

    return final_list;

def listMentor():
    db = mysql.connect();
    db.autocommit(True);
    cursor = db.cursor();
    query = "SELECT b.UserID, b.Name, a.EMail from accountinfo a , personalinfo b where a.UserID = b.UserID and a.Role='Mentor'";
    cursor.execute(query)
    final_list=[];
    data=[];

    data = cursor.fetchone();
    final_list.append(data);

    while data is not None:
      #print data[1];
      data = cursor.fetchone();
      final_list.append(data);


    cursor.close();
    db.close();

    return final_list;

def listModerator():
    db = mysql.connect();
    db.autocommit(True);
    cursor = db.cursor();
    query = "SELECT b.UserID, b.Name, a.EMail from accountinfo a , personalinfo b where a.UserID = b.UserID and a.Role='Moderator'";
    cursor.execute(query)
    final_list=[];
    data=[];

    data = cursor.fetchone();
    final_list.append(data);

    while data is not None:
      #print data[1];
      data = cursor.fetchone();
      final_list.append(data);


    cursor.close();
    db.close();

    return final_list;


def fetchPendingModerator():
    db = mysql.connect();
    db.autocommit(True);
    cursor = db.cursor();
    query = "SELECT * from MODERATOR where MODERATOR_STATUS IS NULL";
    cursor.execute(query)
    final_list=[];
    data=[];

    data = cursor.fetchone();
    final_list.append(data);

    while data is not None:
      #print data[1];
      data = cursor.fetchone();
      final_list.append(data);


    cursor.close();
    db.close();

    return final_list;

def updateModeratorStatus(id, statusValue):
    db = mysql.connect();
    db.autocommit(True);
    cursor = db.cursor();
    query = "UPDATE MODERATOR SET MODERATOR_STATUS='"+statusValue+"' WHERE idMODERATOR="+id;
    val=cursor.execute(query);
    print(val);
    return val;


def search(key):
    db = mysql.connect();
    db.autocommit(True);
    cursor = db.cursor();
    query = "SELECT b.UserID, b.Name, b.Disability, a.EMail from accountinfo a , personalinfo b where a.UserID = b.UserID and a.Role='Mentee' and b.Name like '%"+key+"%'";
    cursor.execute(query)
    final_list=[];
    data=[];

    data = cursor.fetchone();
    final_list.append(data);

    while data is not None:
      #print data[1];
      data = cursor.fetchone();
      final_list.append(data);


    cursor.close();
    db.close();

    return final_list;


def searchMentee(key):
    db = mysql.connect();
    db.autocommit(True);
    cursor = db.cursor();
    query = "SELECT b.UserID, b.Name, b.Disability, a.EMail from accountinfo a , personalinfo b where a.UserID = b.UserID and a.Role='Mentee' and b.Name like '%"+key+"%'";
    cursor.execute(query)
    final_list=[];
    data=[];

    data = cursor.fetchone();
    final_list.append(data);

    while data is not None:
      #print data[1];
      data = cursor.fetchone();
      final_list.append(data);


    cursor.close();
    db.close();

    return final_list;

def searchMentor(key):
    db = mysql.connect();
    db.autocommit(True);
    cursor = db.cursor();
    query = "SELECT b.UserID, b.Name, a.EMail from accountinfo a , personalinfo b where a.UserID = b.UserID and a.Role='Mentor' and b.Name like '%"+key+"%'";
    cursor.execute(query)
    final_list=[];
    data=[];

    data = cursor.fetchone();
    final_list.append(data);

    while data is not None:
      #print data[1];
      data = cursor.fetchone();
      final_list.append(data);


    cursor.close();
    db.close();

    return final_list;

def searchModerator(key):
    db = mysql.connect();
    db.autocommit(True);
    cursor = db.cursor();
    query = "SELECT b.UserID, b.Name, a.EMail from accountinfo a , personalinfo b where a.UserID = b.UserID and a.Role='Moderator' and b.Name like '%"+key+"%'";
    cursor.execute(query)
    final_list=[];
    data=[];

    data = cursor.fetchone();
    final_list.append(data);

    while data is not None:
      #print data[1];
      data = cursor.fetchone();
      final_list.append(data);


    cursor.close();
    db.close();

    return final_list;

def view(id):
    db = mysql.connect();
    db.autocommit(True);
    cursor = db.cursor();
    query = "SELECT b.UserID, b.Name, b.Disability, a.EMail from accountinfo a , personalinfo b where a.UserID = b.UserID and a.Role='Mentor' and a.UserID="+id;
    cursor.execute(query)
    data=[];
#select a.Name from personalinfo a , mentor_mentee_match b where a.UserID = b.mentor_id and b.mentee_id="+id
    data = cursor.fetchone();

    cursor.close();
    db.close();

    return data;


def viewMentee(id):
    db = mysql.connect();
    db.autocommit(True);
    cursor = db.cursor();
    query = "SELECT b.UserID, b.Name, b.Disability, a.EMail from accountinfo a , personalinfo b where a.UserID = b.UserID and a.Role='Mentee' and a.UserID="+id;
    cursor.execute(query)
    data=[];

    data = cursor.fetchone();

    cursor.close();
    db.close();

    return data;

def viewMentor(id):
    db = mysql.connect();
    db.autocommit(True);
    cursor = db.cursor();
    query = "SELECT b.UserID, b.Name, a.EMail from accountinfo a , personalinfo b where a.UserID = b.UserID and a.Role='Mentor' and a.UserID="+id
    cursor.execute(query)
    data=[];

    data = cursor.fetchone();

    cursor.close();
    db.close();

    return data;

def viewModerator(id):
    db = mysql.connect();
    db.autocommit(True);
    cursor = db.cursor();
    query = "SELECT b.UserID, b.Name, a.EMail from accountinfo a , personalinfo b where a.UserID = b.UserID and a.Role='Moderator' and a.UserID="+id
    cursor.execute(query)
    data=[];

    data = cursor.fetchone();

    cursor.close();
    db.close();

    return data;

def delete(id):
    db = mysql.connect();
    db.autocommit(True);
    cursor = db.cursor();
    
    a = cursor.execute("DELETE from MODERATOR where idMODERATOR="+id);
    return str(a);


def insert():
    db = mysql.connect();
    db.autocommit(True);
    cursor = db.cursor();
    data=('XYZ','HEARING','NOS');
    a = cursor.execute("INSERT INTO MENTEE_DUMMY(MENTEE_NAME,MENTEE_DISABLITIY,MENTEE_ASSIGNED_MENTOR) VALUES ('%s','%s','%s')" % ('XYZ','HEARING','NOS'));
    return str(a);

#if __name__ == "__main__":
#    app.run()
