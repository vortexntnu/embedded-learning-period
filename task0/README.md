# Task 0: Create Your Own Branch

One of the most **convenient** and powerful features of Git is that each person can have their **own branch** to work on.  
This allows you to develop and test code without affecting the main project, and later merge your work when it’s ready.

---

## Why Branches Are Useful
- **Isolation** – Your changes won’t break the main branch.
- **Collaboration** – Multiple developers can work on different features at the same time.
- **History Tracking** – You can always look back and see when and why changes were made.

---

## Step 1: Create a New Branch

1. Make sure you have cloned the repository:
   ```bash
   git clone https://github.com/vortexntnu/embedded-learning-period.git
   cd embedded-learning-period
2. Create and switch to a new branch (replace `{username}` with your actual username or name):
   ```bash
   git checkout -b {username}_branch
   ```

---

## Step 2: Create a New File

Let’s create a simple text file to practice committing changes.

1. Create a new file:
   ```bash
   touch my_first_file.txt
   ```

2. Open it in your preferred editor (example using `nano`):
   ```bash
   nano my_first_file.txt
   ```
   Add some text, then save and close the file.

---

## Step 3: Commit Your Changes

To commit and save your file to your branch, follow these steps:

1. Stage the file:
   ```bash
   git add my_first_file.txt
   ```

2. Commit it with a message:
   ```bash
   git commit -m "My first commit"
   ```

3. Push the branch to the remote repository:
   ```bash
   git push --set-upstream origin {username}_branch
   ```

---

## Step 4: Verify

After pushing:
- Check the repository on GitHub to see your branch.
- Make sure `my_first_file.txt` exists in your branch.

---
