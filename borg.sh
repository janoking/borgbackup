#!/bin/bash

ROOTDIR="/home/serverbackup/backups/"
LOG="prune-backup.log"

# copy all output to logfile
exec > >(tee -i ${LOG})
exec 2>&1

echo "###### Pruning backup for server1 on $(date) ######"

borg prune -v ${ROOTDIR}server1 \
--keep-daily=7 \
--keep-weekly=4 \
--keep-monthly=6

echo "###### Pruning backup for server2 on $(date) ######"

borg prune -v ${ROOTDIR}server2 \
--keep-daily=7 \
--keep-weekly=4 \
--keep-monthly=6


echo "###### Pruning finished ######"

# Send logfile to serveradmin
mailx -r admin@bitschieber.com -s "Backup | Prune" admin@bitschieber.com < $LOG

