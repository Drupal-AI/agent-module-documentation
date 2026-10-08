# Installation

## Requirements

- **Drupal 9.5, 10, or 11** (`core_version_requirement: ^9.5||^10||^11`).
- Access to an **IMAP mailbox** — hostname, port, credentials, and (recommended)
  SSL/TLS.
- The PHP environment must be able to make **outbound IMAP connections** to your
  mail server.

There are no additional contrib‑module dependencies.

## Install with Composer

From the project root:

```bash
composer require drupal/mail_box_management -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/mail_box_management -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en mail_box_management -y
```

## Permissions

The module provides its own permissions. Because mailbox contents are private
correspondence and may contain personal data, grant these permissions only to the
users who genuinely need mailbox access, at **People → Permissions**
(`/admin/people/permissions`).

## Verify it worked

Go to **Configuration → Mail Box Management**
(`/admin/mailbox-management/configuration`). If the configuration form loads, the
module is installed. The real confirmation is entering valid IMAP details and
successfully fetching messages — see [Configuration](../configuration/index.md).
