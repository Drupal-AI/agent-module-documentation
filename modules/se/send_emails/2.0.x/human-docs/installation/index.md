# Installation

## Requirements

- **Drupal 8.8, 9, 10, or 11** (`core_version_requirement: ^8.8||^9||^10||^11`).
- No required contrib modules and no third‑party PHP libraries.

Note that using Send Emails effectively assumes some developer involvement — the
templates are triggered by calling the module's `send_emails.mail` service from
custom code (for example in a `hook_ENTITY_TYPE_presave` or similar).

## Install with Composer

From the project root:

```bash
composer require drupal/send_emails -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/send_emails -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en send_emails -y
```

## Submodules — enable only what you need

Send Emails ships two optional submodules. Enable them individually with
`drush en`:

| Submodule | Machine name | What it adds |
|-----------|--------------|--------------|
| **Send Emails - Attachments** | `send_emails_attachments` | Lets you attach files to the emails you send. |
| **Send Emails - Manual** | `send_emails_manual` | Adds a UI to manually send a defined template to everyone in a role, at `/admin/config/send_emails/manual/[template]`. Because this can blast email on demand, restrict its permission to trusted operators. |

For example, to add manual sending:

```bash
drush en send_emails_manual -y
```

## Verify it worked

Log in as an administrator and go to **Configuration → Send Emails Configuration**
(`/admin/config/send_emails/emails`). You should see the email‑definitions form,
ready for you to create your first template. Continue to
[Configuration](../configuration/index.md) for the field‑by‑field walkthrough.
