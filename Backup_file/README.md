# 🧠 Automated Backup Solution (Bash Script)

A simple yet powerful **Bash script** to automate the backup of any local directory to a **remote server or cloud storage**.  
It uses `rsync` for fast and secure synchronization and generates a **backup report** indicating success or failure.

---

## 🚀 Features

✅ Backs up local directories to a remote server (via SSH)  
✅ Uses `rsync` for efficient incremental transfers  
✅ Automatically creates timestamped reports  
✅ Handles errors gracefully with clear logs  
✅ Fully interactive — prompts for all required inputs  

---

## ⚙️ Requirements

- A Unix/Linux system with:
  - `bash`
  - `rsync`
  - SSH access to the remote server
- Ensure passwordless SSH (optional but recommended) using SSH keys.

---

## 🧩 Usage

### 1️⃣ Clone this Repository
```bash
git clone https://github.com/yourusername/automated-backup-solution.git
cd automated-backup-solution
