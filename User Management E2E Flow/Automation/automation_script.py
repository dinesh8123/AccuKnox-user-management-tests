from playwright.sync_api import sync_playwright
import time

def run():
    with sync_playwright() as p:
        # Launch browser (visible with slow motion)
        browser = p.chromium.launch(headless=False, slow_mo=100)
        context = browser.new_context(viewport={"width": 1280, "height": 800})
        page = context.new_page()

        print("🔹 Opening login page...")
        page.goto("https://opensource-demo.orangehrmlive.com/web/index.php/auth/login")
        page.wait_for_timeout(7000)

        # Step 1: Login
        print("🔹 Entering credentials...")
        page.fill("input[name='username']", "Admin")
        page.fill("input[name='password']", "admin123")
        page.click("button[type='submit']")
        page.wait_for_selector("h6:has-text('Dashboard')")
        print("✅ Logged in successfully!")
        page.wait_for_timeout(7000)

        # Step 2: Navigate to Admin > User Management
        print("🧭 Navigating to Admin > User Management...")
        page.goto("https://opensource-demo.orangehrmlive.com/web/index.php/admin/viewSystemUsers")
        page.wait_for_selector("button:has-text('Add')")
        page.click("button:has-text('Add')")
        page.wait_for_selector("h6:has-text('Add User')")
        print("🧩 Add User form opened.")
        page.wait_for_timeout(7000)

        # Step 3: Fill Add User Details
        print("✍️ Filling new user details...")

        # --- User Role ---
        page.locator("div.oxd-grid-item--gutters:has(label:has-text('User Role')) .oxd-select-text-input").click()
        page.locator("div[role='listbox'] >> text=ESS").click()
        print("✅ User Role set to ESS")

        # --- Employee Name ---
        page.fill("input[placeholder='Type for hints...']", "a")
        page.wait_for_timeout(4000)
        page.keyboard.press("ArrowDown")
        page.keyboard.press("Enter")
        print("✅ Employee Name selected")

        # --- Status ---
        page.locator("div.oxd-grid-item--gutters:has(label:has-text('Status')) .oxd-select-text-input").click()
        page.locator("div[role='listbox'] >> text=Enabled").click()
        print("✅ Status set to Enabled")

        # --- Username ---
        username = "hellotest1"
        page.fill("div.oxd-input-group:has(label:has-text('Username')) input", username)
        print(f"🔹 Username entered: {username}")

        # --- Passwords ---
        page.fill("div.oxd-input-group:has(label:has-text('Password')) input", "admin123")
        page.fill("div.oxd-input-group:has(label:has-text('Confirm Password')) input", "admin123")
        print("🔑 Password set for new user.")

        # --- Save ---
        page.click("button:has-text('Save')")
        print("💾 Saving new user...")
        page.wait_for_timeout(7000)
        print("✅ User saved successfully!")

        # Step 4: Search for the newly created user
        print("🔍 Searching for the new user...")
        page.goto("https://opensource-demo.orangehrmlive.com/web/index.php/admin/viewSystemUsers")
        page.wait_for_selector("div.oxd-table-filter")
        page.fill("div.oxd-input-group:has(label:has-text('Username')) input", username)
        page.click("button:has-text('Search')")
        page.wait_for_selector(f"div.oxd-table-body:has-text('{username}')")
        print(f"✅ User '{username}' found in search results.")
        page.wait_for_timeout(7000)

        # Step 5: Click Edit button
        print("✏️ Clicking edit button for user...")
        user_row = page.locator(f"div.oxd-table-row:has(div:has-text('{username}'))")
        edit_button = user_row.locator("i.bi-pencil-fill")
        edit_button.first.click()
        page.wait_for_selector("h6:has-text('Edit User')")
        print("🧩 Edit User form opened.")
        page.wait_for_timeout(7000)

        # Step 6: Modify user details
        print("🛠 Editing user details...")

        # Change role to Admin
        page.locator("div.oxd-grid-item--gutters:has(label:has-text('User Role')) .oxd-select-text-input").click()
        page.locator("div[role='listbox'] >> text=Admin").click()
        print("✅ User Role changed to Admin")

        # Change status to Disabled
        page.locator("div.oxd-grid-item--gutters:has(label:has-text('Status')) .oxd-select-text-input").click()
        page.locator("div[role='listbox'] >> text=Disabled").click()
        print("✅ Status changed to Disabled")

        # Change username
        new_username = "hellotest2"
        username_field = page.locator("div.oxd-input-group:has(label:has-text('Username')) input")
        username_field.fill("")
        username_field.fill(new_username)
        print(f"✅ Username changed to {new_username}")

        # Save changes
        page.click("button:has-text('Save')")
        print("💾 Saving updated user...")
        page.wait_for_timeout(7000)
        print("✅ User details updated successfully!")

        # Step 7: Verify the edited user
        print("🔍 Verifying updated user details...")
        page.goto("https://opensource-demo.orangehrmlive.com/web/index.php/admin/viewSystemUsers")
        page.fill("div.oxd-input-group:has(label:has-text('Username')) input", new_username)
        page.click("button:has-text('Search')")
        page.wait_for_selector(f"div.oxd-table-body:has-text('{new_username}')")
        print(f"✅ Verified updated user '{new_username}' appears in list.")
        page.wait_for_timeout(7000)

        # Step 8: Delete the user
        print("🗑️ Deleting the user...")
        user_row = page.locator(f"div.oxd-table-row:has(div:has-text('{new_username}'))")
        delete_button = user_row.locator("i.bi-trash")
        delete_button.first.click()
        page.wait_for_selector("div.orangehrm-dialog-popup")
        print("⚠️ Delete confirmation dialog appeared.")
        page.locator("button:has-text('Yes, Delete')").click()
        page.wait_for_timeout(7000)
        print(f"✅ User '{new_username}' deleted successfully!")

        # Step 9: Verify user deletion
        print("🔎 Verifying user deletion...")
        page.fill("div.oxd-input-group:has(label:has-text('Username')) input", new_username)
        page.click("button:has-text('Search')")
        page.wait_for_timeout(7000)

        if page.is_visible("span:has-text('No Records Found')"):
            print(f"✅ Verified: User '{new_username}' no longer exists.")
        else:
            print("⚠️ Deletion might have failed — please check manually.")
        page.wait_for_timeout(7000)

        print("🎯 Automation completed successfully!")
        browser.close()

if __name__ == "__main__":
    run()
