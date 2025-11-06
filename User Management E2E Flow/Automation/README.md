# 🟢 OrangeHRM User Automation

Automates **user management tasks** in the [OrangeHRM demo](https://opensource-demo.orangehrmlive.com/) using **Playwright**.  
This script handles the full user lifecycle: **Create → Search → Edit → Verify → Delete → Verify**.

---

## 📦 Project Setup
 
#Create a Virtual Enviroment (Recomended)
# Linux / Mac
python -m venv venv
source venv/bin/activate

# Windows
python -m venv venv
venv\Scripts\activate


#Playwright version 1.43.0 OR later
#Install the requied packages
pip install playwright

#Install Playwright Browser
playwright install

#How to run
- cd Automation
- python automation.py

