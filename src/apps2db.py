import logging
import os
import psycopg2
import pandas as pd
from psycopg2.extras import LoggingConnection
from appleStoreScraper import AppleScraper
from playStoreScraper import GoogleScraper
logger = logging.getLogger(__name__)
logger.setLevel(level=logging.DEBUG)
handler = logging.StreamHandler()
handler.setLevel(logging.DEBUG)
logger.addHandler(handler)

def initConn() -> any:
    print(
       "Try to establish a database connection with the parametes: DB_HOST {host}, DB_PORT: {port}, DB_NAME: {name}, DB_USERNAME: {username}, DB_PASSWORD: *****".format(
            host=os.environ.get("DB_HOST"),
            port=os.environ.get("DB_PORT"),
            name=os.environ.get("DB_NAME"),
            username=os.environ.get("DB_USERNAME"),
        )

    )
    conn = psycopg2.connect(
        connection_factory=LoggingConnection,
        host="DB_HOST",
        port="DB_PORT",
        database="DB_NAME",
        user="DB_USERNAME",
        password="DB_PASSWORD",
    )
    conn.initialize(logger)

    print("Database connection established")

    return conn
  
def storeApps():
    #load the apps(android ,ios)
      android_apps = []
      ios_apps = []
      
      apple_medizin = AppleScraper()
      ios_apps += apple_medizin.main("https://apps.apple.com/de/genre/ios-medizin/id6020")
      apple_fitness = AppleScraper()
      ios_apps += apple_fitness.main("https://apps.apple.com/de/genre/ios-gesundheit-und-fitness/id6013")
      google_medizin = GoogleScraper()
      android_apps += google_medizin.main("https://play.google.com/store/search?q=MEDCAL&c=apps")
      google_fitness = GoogleScraper()
      android_apps += google_fitness.main("https://play.google.com/store/search?q=HEALTH_AND_FITNESS&c=apps")
    
    #init a connection
      conn = initConn()
      cur = conn.cursor()
#start  inserting the apps data into the right (table)
#################andoid  app#########################
      android_app_query = "insert into android_app VALUES  "
      if (len(android_apps)>1):
        for (i,app) in enumerate(android_apps):
          android_app_query   +="\n(%s,%s,%s,%s,%s,%s,%s),\n"%(i,"\'"+app["StoreID"].replace("\'","\"")+"\'","\'"+app["App Title"].replace("\'","\"")+"\'","\'"+app["Description"].replace("\'","\"")+"\'","\'"+app["Icon"].replace("\'","\"")+"\'","\'"+app["Developer"].replace("\'","\"")+"\'",app["Price"])
        cur.execute(android_app_query [ :-2]+";",)
      else:
        android_app_query   +="(%s,%s,%s,%s,%s,%s,%s);"%(i,"\'"+app["StoreID"].replace("\'","\"")+"\'","\'"+app["App Title"].replace("\'","\"")+"\'","\'"+app["Description"].replace("\'","\"")+"\'","\'"+app["Icon"].replace("\'","\"")+"\'","\'"+app["Developer"].replace("\'","\"")+"\'",app["Price"])
        cur.execute(android_app_query,)


#################andoid version app###################
      android_version_query = "insert into android_app_version VALUES  "
      if (len(android_apps)>1):
        for (i,app) in enumerate(android_apps):
          android_version_query   +="\n(%s,%s,%s,%s,%s,%s,%s),\n"%(i+1,"\'"+app["Version"].replace("\'",NULL,"\"")+"\'",app["review_count"],app["Released"],"\'"+app["recent_changes"].replace("\'","\"")+"\'",NULL,True,i)
        cur.execute(android_version_query [ :-2]+";",)
      else:
        android_version_query   +="(%s,%s,%s,%s,%s,%s,%s);"%(i+1,"\'"+app["Version"].replace("\'",NULL,"\"")+"\'",app["review_count"],app["Released"],"\'"+app["recent_changes"].replace("\'","\"")+"\'",NULL,True,i)
        cur.execute(android_version_query,)


#####################ios app##########################
      ios_app_query = "insert into ios_app VALUES  "
      if (len(ios_apps)>1):
        for (i,app) in enumerate(ios_apps):
          ios_app_query   +="\n(%s,%s,%s,%s,%s,%s,%s),\n"%(i,"\'"+app["StoreID"].replace("\'","\"")+"\'","\'"+app["App Title"].replace("\'","\"")+"\'","\'"+app["Description"].replace("\'","\"")+"\'","\'"+app["Icon"].replace("\'","\"")+"\'","\'"+app["Developer"].replace("\'","\"")+"\'",app["Price"])
        cur.execute(ios_app_query [ :-2]+";")
      else:
        ios_app_query   +="(%s,%s,%s,%s,%s,%s,%s);"%(i,"\'"+app["StoreID"].replace("\'","\"")+"\'","\'"+app["App Title"].replace("\'","\"")+"\'","\'"+app["Description"].replace("\'","\"")+"\'","\'"+app["Icon"].replace("\'","\"")+"\'","\'"+app["Developer"].replace("\'","\"")+"\'",app["Price"])
        cur.execute(ios_app_query,)

#####################ios app version##################
      ios_version_query = "insert into ios_app_version VALUES  "
      if (len(ios_apps)>1):
        for (i,app) in enumerate(ios_apps):
          ios_version_query   +="\n(%s,%s,%s,%s,%s,%s,%s),\n"%(i+1,"\'"+app["Version"].replace("\'","\"")+"\'",app["review_count"],app["Released"],"\'"+app["recent_changes"].replace("\'","\"")+"\'",True,i)
        cur.execute(ios_version_query [ :-2]+";",)
      else:
        ios_version_query   +="(%s,%s,%s,%s,%s,%s,%s);"%(i+1,"\'"+app["Version"].replace("\'","\"")+"\'",app["review_count"],app["Released"],"\'"+app["recent_changes"].replace("\'","\"")+"\'",True,i)
        cur.execute(ios_version_query,)
   #commit
      conn.commit()
      conn.close()        
if __name__ == "__main__":
    storeApps()
