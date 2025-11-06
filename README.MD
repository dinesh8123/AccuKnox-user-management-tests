# 🧾 Log File Analyzer (Bash Script)

A simple and efficient **Bash script** to analyze **web server logs** (Apache or Nginx).  
This tool provides insights such as:
- Number of total requests  
- Count of 404 (Not Found) errors  
- Top requested URLs  
- IPs making the most requests  

---

## 🚀 Features

✅ Works with Apache and Nginx standard log formats  
✅ Detects 404 errors  
✅ Lists top 5 requested URLs  
✅ Lists top 5 active IPs  
✅ Saves a timestamped report automatically  
✅ Fully portable (no dependencies other than Bash and awk)

---

## ⚙️ Requirements

- Unix/Linux environment  
- Bash shell  
- Basic command-line tools (`grep`, `awk`, `sort`, `uniq`, `wc`)

---

## 🧰 Usage

1. Clone or download this repository:
   ```bash
   git clone https://github.com/yourusername/log-file-analyzer.git
   cd log-file-analyzer
   chmod +x log_file_analyzer.sh
   ./log_file_analyzer.sh OR bash log_file_analyzer.sh