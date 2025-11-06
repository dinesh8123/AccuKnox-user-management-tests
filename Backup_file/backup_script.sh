#!/bin/bash
# =====================================================
# Automated Backup Script (Using SCP)
# Author: Dinesh Patel
# Date: 2025-11-06
# Description:
#   Automates the backup of a specified local directory
#   to a remote server or cloud destination using SCP.
#   Generates a report on success or failure.
# =====================================================

# --------- CONFIGURATION ---------
TIMESTAMP=$(date +"%Y%m%d_%H%M%S")
LOG_FILE="backup_report_${TIMESTAMP}.log"

# --------- USER INPUT ---------
echo "=============================="
echo "🧠 Automated Backup Solution (SCP Version)"
echo "=============================="
echo

read -p "Enter source directory to back up: " SOURCE_DIR
read -p "Enter remote username: " REMOTE_USER
read -p "Enter remote host (IP or hostname): " REMOTE_HOST
read -p "Enter remote destination directory: " REMOTE_DIR

# --------- VALIDATION ---------
if [[ ! -d "$SOURCE_DIR" ]]; then
    echo "❌ Error: Source directory '$SOURCE_DIR' does not exist!" | tee -a "$LOG_FILE"
    exit 1
fi

if [[ -z "$REMOTE_USER" || -z "$REMOTE_HOST" || -z "$REMOTE_DIR" ]]; then
    echo "❌ Error: Remote details are incomplete!" | tee -a "$LOG_FILE"
    exit 1
fi

# --------- BACKUP PROCESS ---------
echo "🚀 Starting backup at $(date)" | tee -a "$LOG_FILE"
echo "Source Directory: $SOURCE_DIR" | tee -a "$LOG_FILE"
echo "Destination: $REMOTE_USER@$REMOTE_HOST:$REMOTE_DIR" | tee -a "$LOG_FILE"
echo "----------------------------------------------" | tee -a "$LOG_FILE"

# Perform SCP backup
scp -r -v "$SOURCE_DIR" "${REMOTE_USER}@${REMOTE_HOST}:${REMOTE_DIR}" >>"$LOG_FILE" 2>&1

# --------- CHECK STATUS ---------
if [[ ${PIPESTATUS[0]} -eq 0 ]]; then
    echo "✅ Backup completed successfully at $(date)" | tee -a "$LOG_FILE"
else
    echo "❌ Backup failed at $(date)" | tee -a "$LOG_FILE"
fi

echo "----------------------------------------------" | tee -a "$LOG_FILE"
echo "📄 Backup report saved as: $LOG_FILE"
echo "----------------------------------------------"
