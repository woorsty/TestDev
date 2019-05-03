FROM jboss/wildfly
ADD pom.xml /tmp
ADD ejb-in-war /tmp/ejb-in-war

RUN /opt/jboss/wildfly/bin/add-user.sh admin Admin#70365 --silent
USER root
RUN yum -y install wget
RUN wget http://repos.fedorapeople.org/repos/dchen/apache-maven/epel-apache-maven.repo -O /etc/yum.repos.d/epel-apache-maven.repo
RUN yum -y install apache-maven

RUN mvn -f /tmp/ejb-in-war clean package
RUN cp /tmp/ejb-in-war/target/ejb-in-war.war /opt/jboss/wildfly/standalone/deployments/ejb-in-war.war