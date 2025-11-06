#!/bin/bash
# =====================================================
# Log File Analyzer Script
# Author: Dinesh Patel
# Date: 2025-11-06
# Description: Analyzes web server logs (Apache/Nginx)
#              for common patterns like 404 errors,
#              top requested pages, and top IPs.
# =====================================================

# ---------- CONFIGURATION ----------
TOP_COUNT=5

# ---------- FUNCTIONS ----------

# Function to check if log file exists
check_log_file() {
    if [[ -z "$LOG_FILE" ]]; then
        echo "❌ Error: No log file specified."
        exit 1
    elif [[ ! -f "$LOG_FILE" ]]; then
        echo "❌ Error: Log file '$LOG_FILE' not found!"
        exit 1
    fi
}

# Function to analyze total requests
total_requests() {
    TOTAL_REQ=$(wc -l < "$LOG_FILE")
    echo "📊 Total Requests: $TOTAL_REQ"
}

# Function to count 404 errors
count_404() {
    TOTAL_404=$(grep " 404 " "$LOG_FILE" | wc -l)
    echo "🚫 Total 404 Errors: $TOTAL_404"
}

# Function to show top requested URLs
top_urls() {
    echo -e "\n🌐 Top $TOP_COUNT Requested URLs:"
    awk '{print $7}' "$LOG_FILE" | sort | uniq -c | sort -nr | head -n $TOP_COUNT | awk '{printf "  %s - %s requests\n", $2, $1}'
}

# Function to show top IPs
top_ips() {
    echo -e "\n📡 Top $TOP_COUNT IPs with Most Requests:"
    awk '{print $1}' "$LOG_FILE" | sort | uniq -c | sort -nr | head -n $TOP_COUNT | awk '{printf "  %s - %s requests\n", $2, $1}'
}

# Function to generate report
generate_report() {
    REPORT_FILE="log_analysis_report_$(date +%Y%m%d_%H%M%S).txt"
    {
        echo "=============================================="
        echo "🧾 Web Server Log Analysis Report"
        echo "Generated on: $(date)"
        echo "Analyzed Log: $LOG_FILE"
        echo "=============================================="
        echo ""
        total_requests
        count_404
        top_urls
        top_ips
        echo ""
        echo "✅ Analysis complete. Report saved: $REPORT_FILE"
    } | tee "$REPORT_FILE"
}

# ---------- MAIN EXECUTION ----------

# Ask user for log file path at runtime
read -p "Enter the full path of the web server log file: " LOG_FILE
check_log_file
generate_report

exit 0
