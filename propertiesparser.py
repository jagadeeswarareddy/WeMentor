import ConfigParser
config = ConfigParser.RawConfigParser()
config.read('database.properties')

def getDatabaseUserName():
	return config.get('DatabaseSection', 'database.username');
def getDatabasePassword():
	return config.get('DatabaseSection', 'database.password');
def getDatabaseName():
	return config.get('DatabaseSection', 'database.dbname');
def getDatabaseHost():
	return config.get('DatabaseSection', 'database.host');
def getDatabaseSQLAlchemy():
	return config.get('DatabaseSection', 'database.sqlalchemyproperties');