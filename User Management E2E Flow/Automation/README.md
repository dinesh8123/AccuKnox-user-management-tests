"""
# 🟢 OrangeHRM User Automation

Automates **user management tasks** in [OrangeHRM demo](https://opensource-demo.orangehrmlive.com/) using **Playwright**.  
This script handles the full user lifecycle: **Create → Search → Edit → Verify → Delete → Verify**.

---

## 📦 Project Setup

1. **Clone the repository**
```bash
git clone 
cd Automation

#Create a Virtual Enviroment (Recomended)
python -m venv venv
source venv/bin/activate   # Linux/Mac
venv\Scripts\activate      # Windows

#Playwright version 1.43.0 OR later
#Install the requied packages
pip install playwright

#Install Playwright Browser
playwright install

#How to run
python automation.py

