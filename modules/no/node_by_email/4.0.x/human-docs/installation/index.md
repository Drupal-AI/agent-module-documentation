# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- Core's **Node** module. Your target content type must have a **title** and a
  **body** field, since the email subject maps to the title and the email body maps
  to the body.
- The **PHP IMAP extension** (`ext-imap`) on the server — the module opens an IMAP
  connection to your mailbox, so it will not work without it.
- **Drush 11** (`drush/drush ^11`) — required for the `node_by_email:generate_node`
  command and pulled in as a Composer dependency.
- Access to an **IMAP mailbox** (Gmail/Yahoo/AOL over SSL, or your own mail server)
  to receive the incoming messages.

## Install with Composer

From the project root:

```bash
composer require drupal/node_by_email -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer bring in Drush 11 and any
other shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/node_by_email -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

If the PHP IMAP extension is missing, install it for your server's PHP (for example
the `php-imap` package on many distributions) before continuing.

## Enable the module

```bash
drush en node_by_email -y
```

## Verify it worked

1. Go to **Configuration → System → Node by Email**
   (`/admin/config/node_by_email/nodebyemailconfig`), enter your IMAP details, and
   save. A successful connection shows *"IMAP connection is made successfully."*
2. Confirm the Drush command is available:

   ```bash
   drush node_by_email:generate_node
   ```

   (alias `drush nbe-gn`). It runs an ingestion pass over unseen mail.

Then continue to [Configuration](../configuration/index.md) for the full
field-by-field walkthrough.
