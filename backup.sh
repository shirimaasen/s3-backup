#!/usr/bin/env bash

#export SOURCE_BUCKET=...
#export BACKUP_BUCKET=...
#export LIST_FILE=backup.list
#export REGION=eu-west-1

#backup.sh --operation backup --backup-bucket Backup2 --source-bucket Source1 --list-file backup.list --region eu-west-1

if [ "$1" == "" ]; then
  echo usage: backup.sh --operation backup_or_restore--backup-bucket bucket_name --source-bucket bucket_name --list-file list_file_name --region backup_and_source_buckets_region
  exit 0
fi

while [ "$1" != "" ]; do
    PARAM=$1
    case $PARAM in
	--region)
	    REGION=$2
	    shift
	    ;;
	--list-file)
	    LIST_FILE=$2
	    shift
	    ;;
	--backup-bucket)
	    BACKUP_BUCKET=$2
	    shift
	    ;;
	--source-bucket)
	    SOURCE_BUCKET=$2
	    shift
	    ;;
	--operation)
	    OPERATION=$2
	    shift
	    ;;
	*)
	    echo "ERROR: unknown parameter \"$1\""
	    echo usage: backup.sh --operation backup_or_restore --backup-bucket bucket_name --source_bucket bucket_name --list-file list_file_name --region backup_and_source_buckets_region
	    exit 1
	    ;;
    esac
    shift
done

while true; do
    echo -------------------------------------------
    echo --backup-bucket:"   $BACKUP_BUCKET"
    echo --source-bucket:"   $SOURCE_BUCKET"
    echo --region:"          $REGION"
    echo --list-file"        $LIST_FILE"
    echo --operation"        $OPERATION"
    echo -------------------------------------------

    read -p "Do you wish to run operation [y/n] :" yn
    case $yn in
        [Yy]* )
          if [ $OPERATION == 'backup' ];then
            for FOLDER in $(cat $LIST_FILE); do
              echo $FOLDER
              echo ${FOLDER/$SOURCE_BUCKET/$BACKUP_BUCKET}
              aws s3 sync "$FOLDER" "${FOLDER/$SOURCE_BUCKET/$BACKUP_BUCKET}" --region $REGION --source-region $REGION
            done
          fi
          if [ $OPERATION == 'restore' ];then
            for FOLDER in $(cat $LIST_FILE); do
              echo $FOLDER
              echo ${FOLDER/$SOURCE_BUCKET/$BACKUP_BUCKET}
              aws s3 sync "${FOLDER/$SOURCE_BUCKET/$BACKUP_BUCKET}" "$FOLDER" --region $REGION --source-region $REGION
            done
          fi
        break;;

        [Nn]* ) exit;;
        * ) echo "Please answer Y or N";;
    esac
done
