# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`; the project also
  supports Drupal 9.4+).
- **PHP 8**.
- The **CKEditor Mentions** module (`ckeditor_mentions`) — this module builds on
  it and cannot work without it. Drupal enables it as a dependency.
- No third‑party Composer or PHP library requirements of its own.

> **Heads‑up:** This project is **not covered by the Drupal security advisory
> policy**. Weigh that for production use.

## Install with Composer

From the project root:

```bash
composer require drupal/ckeditor_mentions_notifications -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed, and it will pull in CKEditor Mentions if it is not already
present.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/ckeditor_mentions_notifications -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en ckeditor_mentions_notifications -y
```

If CKEditor Mentions is not yet enabled, enable it too (and make sure mentions are
turned on for the relevant text formats — see that module's guide):

```bash
drush en ckeditor_mentions -y
```

## Verify it worked

Configure the notification email (see [Configuration](../configuration/index.md)),
then, as a test, mention a user in a CKEditor field and confirm that user receives
the email — provided they have not disabled notifications on their profile.
