# Configuration

ai.txt's whole configuration is a single admin form where you write the contents
of the `ai.txt` file the module serves.

## Edit the ai.txt contents

1. Log in as a user with the module's edit permission (an administrator by
   default).
2. Go to the **ai.txt** settings form under **Configuration**
   (`aitxt.admin_settings_form`).
3. Enter your **AI‑crawler directives** — the text that will be published at
   `/ai.txt`. This is per‑site and free‑form, following the emerging `ai.txt`
   convention.
4. Save. The `/ai.txt` file is regenerated from what you entered and served to
   any crawler that requests it.

## What it does and doesn't do

- It **declares** how you want AI crawlers to treat your content. Like
  `robots.txt`, this is **advisory** — a well‑behaved crawler reads and honors
  it, but nothing forces compliance.
- It does **not** block requests or enforce access. If you need to actually
  prevent access, use server‑ or application‑level controls in addition to this
  declaration.
