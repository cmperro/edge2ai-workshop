#!/usr/bin/env bash

# Mandatory component:              BASE
# Common components to CDH and CDP: CDSW, FLINK, HBASE HDFS, HIVE, HUE, IMPALA, KAFKA, KUDU,
#                                   NIFI, OOZIE, SCHEMAREGISTRY, SMM, SRM, SOLR, SPARK_ON_YARN, YARN,
#                                   ZOOKEEPER
# CDP-only components:              ATLAS, LIVY, RANGER, ZEPPELIN
CM_SERVICES=BASE,ZOOKEEPER,HDFS,YARN,HIVE,HUE,IMPALA,KAFKA,KUDU,NIFI,OOZIE,SCHEMAREGISTRY,SPARK_ON_YARN,SMM,CDSW,FLINK,SOLR,HBASE,ATLAS,LIVY,ZEPPELIN
ENABLE_KERBEROS=no

##### Cloudera public repository credentials - only needed if using subscription-only URLs below; leave it blank otherwise
##### Must always be set. If not needed, set to "dummy"
REMOTE_REPO_USR=dummy
REMOTE_REPO_PWD=dummy

#####  Java Package
JAVA_PACKAGE_NAME=java-1.8.0-openjdk-devel

##### Maven binary
MAVEN_BINARY_URL=https://mirrors.sonic.net/apache/maven/maven-3/3.6.3/binaries/apache-maven-3.6.3-bin.tar.gz

BASE_URI=https://archive.cloudera.com

#####  CM
CM_VERSION=7.0.3
CM_MAJOR_VERSION=${CM_VERSION%%.*}
CM_REPO_AS_TARBALL_URL=https://archive.cloudera.com/cm7/7.0.3/repo-as-tarball/cm7.0.3-redhat7.tar.gz
CM_REPO_FILE_URL=${BASE_URI}/cm${CM_MAJOR_VERSION}/${CM_VERSION}/redhat7/yum/cloudera-manager-trial.repo

#####  CDH
CDH_VERSION=7.0.3
CDH_BUILD=${CDH_VERSION}-1.cdh${CDH_VERSION}.p0.1635019
CDH_MAJOR_VERSION=${CDH_VERSION%%.*}
CDH_BASE_URI=${BASE_URI}
CDH_PARCEL_REPO=${CDH_BASE_URI}/cdh${CDH_MAJOR_VERSION}/${CDH_VERSION}.0/parcels/

#####  CFM
CFM_VERSION=2.0.0.0
CFM_BUILD=${CFM_VERSION}-106
NIFI_VERSION=1.10.0
NIFI_REGISTRY_VERSION=0.5.0
CFM_BASE_URL=<CHANGE_ME>
CFM_PARCEL_REPO=${CFM_BASE_URL}/parcel
CFM_NIFI_CSD_URL=${CFM_BASE_URL}/parcel/NIFI-${NIFI_VERSION}.${CFM_BUILD}.jar
CFM_NIFICA_CSD_URL=${CFM_BASE_URL}/parcel/NIFICA-${NIFI_VERSION}.${CFM_BUILD}.jar
CFM_NIFIREG_CSD_URL=${CFM_BASE_URL}/parcel/NIFIREGISTRY-${NIFI_REGISTRY_VERSION}.${CFM_BUILD}.jar

#####  Anaconda
ANACONDA_VERSION=5.1.0.1
ANACONDA_PARCEL_REPO=https://repo.continuum.io/pkgs/misc/parcels/archive/

#####  CDSW
# If version is set, install will be attempted
CDSW_VERSION=1.6.1
CDSW_BUILD=${CDSW_VERSION}.p1.1504243
CDSW_PARCEL_REPO=${BASE_URI}/cdsw1/${CDSW_VERSION}/parcels/
CDSW_CSD_URL=${BASE_URI}/cdsw1/${CDSW_VERSION}/csd/CLOUDERA_DATA_SCIENCE_WORKBENCH-CDH6-${CDSW_VERSION}.jar

#####  CSP
CSP_VERSION=3.0.0.0-104
CSP_MAJOR_VERSION=${CSP_VERSION%%.*}
SCHEMAREGISTRY_VERSION=0.8.1
SCHEMAREGISTRY_BUILD=${SCHEMAREGISTRY_VERSION}.${CSP_VERSION}
STREAMS_MESSAGING_MANAGER_VERSION=2.1.0
STREAMS_MESSAGING_MANAGER_BUILD=${STREAMS_MESSAGING_MANAGER_VERSION}.${CSP_VERSION}
STREAMS_REPLICATION_MANAGER_VERSION=1.0.0
STREAMS_REPLICATION_MANAGER_BUILD=${STREAMS_REPLICATION_MANAGER_VERSION}.${CSP_VERSION}
CSP_BASE_URL=<CHANGE_ME>
CSP_PARCEL_REPO=${CSP_BASE_URL}/parcel/
SCHEMAREGISTRY_CSD_URL=${CSP_BASE_URL}/parcel/SCHEMAREGISTRY-${SCHEMAREGISTRY_VERSION}.jar
STREAMS_MESSAGING_MANAGER_CSD_URL=${CSP_BASE_URL}/parcel/STREAMS_MESSAGING_MANAGER-${STREAMS_MESSAGING_MANAGER_VERSION}.jar
STREAMS_REPLICATION_MANAGER_CSD_URL=${CSP_BASE_URL}/parcel/STREAMS_REPLICATION_MANAGER-${STREAMS_REPLICATION_MANAGER_VERSION}.jar

#####  CEM
CEM_VERSION=1.0.0.0
CEM_BUILD=${CEM_VERSION}-25
CEM_MAJOR_VERSION=${CEM_VERSION%%.*}
EFM_VERSION=1.0.0
MINIFI_VERSION=0.6.0
# PUBLIC TARBALL
CEM_BASE_URL=${BASE_URI}/CEM/centos7/${CEM_MAJOR_VERSION}.x/updates/${CEM_VERSION}
CEM_TARBALL=CEM-${CEM_VERSION}-centos7-tars-tarball.tar.gz
CEM_URL=${CEM_BASE_URL}/${CEM_TARBALL}
# INDIVIDUAL
CEM_BASE_URL=<CHANGE_ME>
EFM_TARBALL_URL=${CEM_BASE_URL}/efm/efm-${EFM_VERSION}.${CEM_BUILD}-bin.tar.gz
MINIFI_TARBALL_URL=${CEM_BASE_URL}/minifi/minifi-${MINIFI_VERSION}.${CEM_BUILD}-bin.tar.gz
MINIFITK_TARBALL_URL=${CEM_BASE_URL}/minifi/minifi-toolkit-${MINIFI_VERSION}.${CEM_BUILD}-bin.tar.gz

#####   CSA
CSA_VERSION=1.0.0.0
CSA_BUILD=NA
FLINK_VERSION=1.9.0
CSA_BASE_URL=${BASE_URI}
FLINK_BUILD=${FLINK_VERSION}-csa${CSA_VERSION}-cdh6.3.0
CSA_BASE_URL=${BASE_URI}/csa/${CSA_VERSION}
CSA_PARCEL_REPO=${CSA_BASE_URL}/parcels/
FLINK_CSD_URL=${CSA_BASE_URL}/csd/FLINK-${FLINK_BUILD}.jar

# Parcels to be pre-downloaded during install.
# Cloudera Manager will download any parcels that are not already downloaded previously.
PARCEL_URLS=(
  hadoop         "$CDH_BUILD"                         "$CDH_PARCEL_REPO"
  nifi           "$CFM_VERSION"                       "$CFM_PARCEL_REPO"
  cdsw           "$CDSW_BUILD"                        "$CDSW_PARCEL_REPO"
  Anaconda       "$ANACONDA_VERSION"                  "$ANACONDA_PARCEL_REPO"
  schemaregistry "$SCHEMAREGISTRY_BUILD"              "$CSP_PARCEL_REPO"
  streamsmsgmgr  "$STREAMS_MESSAGING_MANAGER_BUILD"   "$CSP_PARCEL_REPO"
  streamsrepmgr  "$STREAMS_REPLICATION_MANAGER_BUILD" "$CSP_PARCEL_REPO"
  flink          "$FLINK_BUILD"                       "$CSA_PARCEL_REPO"
)

CSD_URLS=(
  $CFM_NIFI_CSD_URL
  $CFM_NIFICA_CSD_URL
  $CFM_NIFIREG_CSD_URL
  $CDSW_CSD_URL
  $SCHEMAREGISTRY_CSD_URL
  $STREAMS_MESSAGING_MANAGER_CSD_URL
  $STREAMS_REPLICATION_MANAGER_CSD_URL
  $FLINK_CSD_URL
)
