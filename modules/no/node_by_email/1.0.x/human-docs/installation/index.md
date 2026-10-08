# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9||^10||^11`).
- Core's **Node** module (standard on any Drupal site). Your target content type
  must have a **title** and a **body** field, since the email subject maps to the
  title and the email body maps to the body.
- The **PHP IMAP extension** must be available on the server — the module connects
  to your mailbox over IMAP, so without it the connection cannot be made.
- Access to an **IMAP mailbox** (for example a Gmail/Yahoo/AOL account with IMAP
  over SSL, or your own mail server) that will receive the incoming messages.

## Install with Composer

From the project root:

```bash
composer require drupal/node_by_email -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/node_by_email -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en node_by_email -y
```

## Verify it worked

Go to **Configuration → System → Node by Email**
(`/admin/config/node_by_email/nodebyemailconfig`), enter your IMAP details, and
save. If everything connects you'll see *"IMAP connection is made successfully."* at
the top of the page. If you see a warning instead, re-check the connection string,
username, and password. Continue to [Configuration](../configuration/index.md) for
the full field-by-field walkthrough.
