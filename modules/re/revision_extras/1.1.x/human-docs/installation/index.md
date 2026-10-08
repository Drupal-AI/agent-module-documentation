# Installation

## Requirements

- **Drupal 10.2 or newer** (`core_version_requirement: ^10.2 || ^11`; the module
  also declares support up to Drupal 13).
- No other modules are required — it needs only Drupal core.

**Recommended companions (optional):**

- **Token** (`drupal/token`) — enables the extra revision log message tokens for
  media and custom blocks.
- **Drupal Symfony Mailer Lite** or **Drupal Symfony Mailer Plus** — required only
  if you want the daily change report's CSV email attachment.
- **Diff** (`drupal/diff`) — adds a diff link to the change report.

## Install with Composer

From the project root:

```bash
composer require drupal/revision_extras -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/revision_extras -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en revision_extras -y
```

## Verify it worked

The core-issue workarounds are active immediately on install. To configure the
opt-in features, go to **Configuration → User interface → Revision Extras**
(`/admin/config/user-interface/revision-extras`) — you should see the settings form
for requiring revisions and customizing the log message field. See "How to use it"
on the [overview page](../index.md) for the full walkthrough.
