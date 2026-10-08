# Installation

## Requirements

Contact Emails works on a wide range of Drupal versions and leans on two other
modules:

- **Drupal 8.8, 9, 10, or 11** (`core_version_requirement: ^8.8 || ^9 || ^10 || ^11`).
- Core's **Contact** module (`contact`) — enabled automatically as a dependency.
- The contrib **Contact Storage** module (`contact_storage`), so submissions are
  saved as entities that emails can read and reference. This is a separate
  project; Composer pulls it in for you when you require Contact Emails.

There are no PHP library or extra Composer requirements beyond those modules.

## Install with Composer

From the project root:

```bash
composer require drupal/contact_emails -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update shared
dependencies as needed, and it brings in Contact Storage at the same time.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/contact_emails -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en contact_emails -y
```

This also enables `contact` and `contact_storage` if they are not already on.
There are no submodules to consider.

## Verify it worked

Log in as an administrator and go to **Structure → Contact forms**. Each form now
has an **Emails** operation, and there is a central listing at **Structure →
Contact forms → Emails** (`/admin/structure/contact/emails`). Add your first
email there and core's single-recipient behaviour is replaced.

Next, see [Configuration](../configuration/index.md) for how each email's
recipients, reply-to, subject and body work.
