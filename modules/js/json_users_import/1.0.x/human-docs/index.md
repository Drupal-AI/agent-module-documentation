# Json Users Import — manual setup guide

**Json Users Import** (`json_users_import`) is an admin form that batch-creates
Drupal user accounts from a block of JSON you paste into the page — no file
upload required. When you migrate people from another portal you often receive
their details as JSON rather than a CSV; this module reads that JSON array,
creates an account for each object, and optionally emails each new user a welcome
message.

You control which JSON keys map to which user fields on a configuration page, so
the module can pick up the email address, username, and any additional user
fields you've defined. On import it validates each username, skips rows whose
email or username already exists, and creates the remaining accounts as **active**
users with a random password. If you turn on welcome emails, each new user can
receive either a one-time login link or their generated password.

A few things are important to understand before you use it:

- **It creates real, login-enabled accounts in bulk.** This is sensitive: treat
  access to the import form as you would any account-creation power, and only
  import user data you trust.
- **It never assigns roles.** Imported accounts get only the authenticated user
  role — there is no way for the import to grant admin or other elevated roles.
- **Access is locked down tightly by default.** Both pages are gated behind a
  `json import users` permission, but the module ships without defining that
  permission, so out of the box only user 1 (the superuser) can reach them. To
  let other administrators use it, you (or a developer) must define that
  permission first.
- Sending welcome emails relies on the **SMTP Authentication Support** module,
  which is a dependency.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer,
   enable it, and its SMTP dependency.
2. [Configuration](configuration/index.md) — map JSON keys to user fields, set up
   the welcome email, and run an import.

## Where it lives in the admin menu

- **Field and email mapping** sits at **Configuration → People → Json users
  import configuration** (`/admin/config/people/json_users_import_config`).
- **The import form itself** sits under **People → Json users import**
  (`/admin/people/json_users_import`).
