# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9||^10||^11`).
- No required contrib modules and no third‑party libraries.
- **Optional:** a WYSIWYG editor module if you want rich‑text styling on the
  message body field.

## Install with Composer

From the project root:

```bash
composer require drupal/send_mails -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/send_mails -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en send_mails -y
```

## After enabling — grant access

The send form is gated by permissions, so nothing is reachable until you grant
them. Go to **People → Permissions** (`/admin/people/permissions`) and assign:

- **Access Send Mails Service** — lets a user open the compose/send form at
  `/send-mails/send`.
- **Access Advanced Send Mails Service** — unlocks advanced options such as
  role‑based sending.

Grant these only to trusted roles: a send form in the wrong hands is a potential
spam or relay vector.

## Verify it worked

Log in as a user with *Access Send Mails Service* and visit
`SITE_URL/send-mails/send`. You should see the compose form (To, Subject, Message
body). Optionally place the **Send Mails Block** from **Structure → Block layout**
to confirm the block is available.
