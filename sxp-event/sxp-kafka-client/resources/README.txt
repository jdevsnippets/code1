_     ____  _        _____  ____    _     ____  _____   _____  _     _____      _  ____  ____ 
/ \ /|/  _ \/ \  /|  /__ __\/  _ \  / \ /\/ ___\/  __/  /__ __\/ \ /|/  __/     / |/  _ \/  __\
| |_||| / \|| |  ||    / \  | / \|  | | |||    \|  \      / \  | |_|||  \       | || / \||  \/|
| | ||| \_/|| |/\||    | |  | \_/|  | \_/|\___ ||  /_     | |  | | |||  /_   /\_| || |-|||    /
\_/ \|\____/\_/  \|    \_/  \____/  \____/\____/\____\    \_/  \_/ \|\____\  \____/\_/ \|\_/\_\
                                                                                              

         java -Dshared.dir=<PROPERTIES_FILE_LOCATION> -jar sxp-kafkaclient-standalone.jar <ACTION> <MESSAGE> <TOPIC_DTLS_OPTIONAL>
  
         eg. java -Dshared.dir=c:/ -jar sxp-kafkaclient-standalone.jar pub Hello
  
  		 WITH TOPIC NAME PROVIDED AT RUNTIME
  		 -------------------------------------
        
         eg. java -Dshared.dir=c:/ -jar sxp-kafkaclient-standalone.jar pub Hello PUBLISH_TOPIC=MY_SXP
 
 
         eg. java -Dshared.dir=c:/ -jar sxp-kafkaclient-standalone.jar pub {"type":"com.cisco.common.events.WorkflowEvent","tenantId":-1} PUB_TOPIC=workflow
 
         SUBSCRIBE TO A TOPIC
  
  
         java -Dshared.dir=<PROPERTIES_FILE_LOCATION> -jar sxp-kafkaclient-standalone.jar <ACTION> <TOPIC_GROUPS_ETC>
  
  
         eg. java -Dshared.dir=c:/ -jar sxp-kafkaclient-standalone.jar sub CON_TOPIC=NEW_SXP;CON_GROUP=My
         
         
  Change the default file name with path:
  		You can change the default file name by providing environment property  kafkaconfig.file.path
  		eg. -Dkafkaconfig.file.path=hello.txt