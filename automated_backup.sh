#!/bin/bash
# ============================================================
#  Automated Backup Solution
# ============================================================
#  Author        : Dinesh Patel
#  Version       : 1.0
# ------------------------------------------------------------
#  Description:
#  This script automates the backup of a specified directory
#  to a remote server using SCP. It compresses the directory,
#  transfers it securely, verifies the operation, and generates
#  a detailed backup report.
# ------------------------------------------------------------
#  Features:
#   ✅ User input for backup configuration
#   ✅ Validates source directory
#   ✅ Creates timestamped .tar.gz archive
#   ✅ Securely transfers backup to remote server
#   ✅ Generates success/failure report
#   ✅ Cleans up temporary files
# ------------------------------------------------------------
#  Requirements:
#   • Bash Shell (v4 or higher)
#   • tar, scp, and ssh installed
#   • Network access to remote host
# ------------------------------------------------------------
#  Usage:
#   1️⃣  Make the script executable:
#       chmod +x automated_backup.sh
#
#   2️⃣  Run the script:
#       ./automated_backup.sh
# ------------------------------------------------------------
#  Example:
#   ./automated_backup.sh
#   Enter the source directory: /home/user/documents
#   Enter remote username: ubuntu
#   Enter remote host: 192.168.1.10
#   Enter remote directory: /home/ubuntu/backups
# ============================================================


# ---------- Function: Print Header ----------
print_header() {
    echo "========================================"
    echo "🔒 Automated Backup Solution"
    echo "========================================"
}

# ---------- Function: Perform Backup ----------
perform_backup() {
    # Prompt user for required details
    read -rp "Enter the source directory to back up: " SRC_DIR
    read -rp "Enter the remote username: " REMOTE_USER
    read -rp "Enter the remote host (e.g., 192.168.1.100 or example.com): " REMOTE_HOST
    read -rp "Enter the remote destination directory: " REMOTE_DIR

    # Validate source directory
    if [[ ! -d "$SRC_DIR" ]]; then
        echo "❌ ERROR: Source directory '$SRC_DIR' does not exist!"
        exit 1
    fi

    # Set variables
    TIMESTAMP=$(date +"%Y%m%d_%H%M%S")
    BACKUP_NAME="backup_$(basename "$SRC_DIR")_${TIMESTAMP}.tar.gz"
    BACKUP_PATH="/tmp/$BACKUP_NAME"
    LOG_FILE="backup_report_${TIMESTAMP}.log"

    echo "📦 Creating compressed archive..."
    tar -czf "$BACKUP_PATH" -C "$(dirname "$SRC_DIR")" "$(basename "$SRC_DIR")"

    if [[ $? -ne 0 ]]; then
        echo "❌ Backup creation failed!" | tee -a "$LOG_FILE"
        exit 1
    else
        echo "✅ Backup archive created: $BACKUP_PATH" | tee -a "$LOG_FILE"
    fi

    # Transfer backup to remote server
    echo "🚀 Transferring backup to remote server..."
    scp "$BACKUP_PATH" "${REMOTE_USER}@${REMOTE_HOST}:${REMOTE_DIR}" >>"$LOG_FILE" 2>&1

    if [[ $? -ne 0 ]]; then
        echo "❌ Backup transfer failed!" | tee -a "$LOG_FILE"
        echo "🔎 Check $LOG_FILE for details."
        exit 1
    else
        echo "✅ Backup successfully transferred to ${REMOTE_USER}@${REMOTE_HOST}:${REMOTE_DIR}" | tee -a "$LOG_FILE"
    fi

    # Cleanup
    rm -f "$BACKUP_PATH"
    echo "🧹 Temporary files removed." | tee -a "$LOG_FILE"

    # Report summary
    echo "----------------------------------------" | tee -a "$LOG_FILE"
    echo "📅 Backup Report - $(date)" | tee -a "$LOG_FILE"
    echo "Source Directory : $SRC_DIR" | tee -a "$LOG_FILE"
    echo "Backup File      : $BACKUP_NAME" | tee -a "$LOG_FILE"
    echo "Remote Host      : ${REMOTE_USER}@${REMOTE_HOST}" | tee -a "$LOG_FILE"
    echo "Destination Path : $REMOTE_DIR" | tee -a "$LOG_FILE"
    echo "Status           : ✅ SUCCESS" | tee -a "$LOG_FILE"
    echo "----------------------------------------" | tee -a "$LOG_FILE"
    echo "📄 Report saved at: $LOG_FILE"
    echo "✅ Backup operation completed successfully!"
}

# ---------- Script Execution ----------
print_header
perform_backup
