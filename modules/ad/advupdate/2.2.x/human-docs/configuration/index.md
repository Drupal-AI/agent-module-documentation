# Configuration

Update Manager Advanced has no settings page of its own. It adds one checkbox to
Drupal's existing Update settings form, and provides one optional admin block.

## The email report toggle

1. Log in as a user with the **Administer site configuration** permission (an
   administrator by default).
2. Go to **Reports → Available updates → Settings**, or navigate directly to
   `/admin/reports/updates/settings`.
3. Find the checkbox **"Expand the report using 'Update Manager Advanced'
   module"**.

- **Checked** *(default)* — Drupal's "Available updates" notification email is
  expanded to include the full per‑project detail: installed versus recommended
  version, release‑note links, and inline flags such as *(Security update)* and
  *(Unsupported)*, grouped into Enabled, Disabled, and Manual updates required
  (core) sections.
- **Unchecked** — the module stays installed but silent; the email reverts to
  Drupal's plain notification.

Click **Save configuration** to apply. Note the email itself is sent by Drupal's
core update system on cron, on whatever "Check for updates" schedule you have
configured — this setting only controls whether the extra detail is appended.

> **Tip:** to receive the report as nicely formatted HTML rather than plain text,
> combine this with a mail‑formatting module (for example Swift Mailer or a mail
> theme).

## The Security Updates block

The module provides a **Security Updates** block (in the *Administration*
category) that surfaces pending security updates on an admin page.

1. Go to **Structure → Block layout** (`/admin/structure/block`).
2. Place the **Security Updates** block in a region — typically an admin dashboard
   or a region only administrators see.

Behavior of the block:

- It lists **only** projects whose update status is *not secure*, showing each
  one's installed and recommended version with a link to the available‑updates
  report.
- It is visible only to users with the **Administer site configuration**
  permission.
- It **hides itself automatically** when there are no pending security updates, so
  it only ever appears when there is something to act on.

There are no other settings to configure.
