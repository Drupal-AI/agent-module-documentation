# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).

Known Overrides has **no module or PHP library dependencies** — it uses only core.

## Install with Composer

From the project root:

```bash
composer require drupal/known_overrides -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/known_overrides -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en known_overrides -y
```

## Declare your expected overrides

There is no settings form — you tell the module which overrides to expect by
editing `settings.local.php` (or `settings.php`). After the opening `<?php` line,
ensure the array exists, then register each override's config name:

```php
if (!isset($settings['knownOverrides'])) {
  $settings['knownOverrides'] = [];
}

// Example: an override you apply in this environment.
$config['mail_safety.settings']['enabled'] = TRUE;

// Register its config name so the report treats it as expected.
$settings['knownOverrides'][] = 'mail_safety.settings';
```

Add a `$settings['knownOverrides'][] = '…';` line for each configuration object
you deliberately override.

## Grant access to the report (sparingly)

Go to **People → Permissions** (`/admin/people/permissions`) and grant the
**`known overrides report`** permission only to roles that should see how this
environment differs from the codebase. It is a *restrict access* permission for
good reason — the report reveals endpoint hostnames, service names, and feature
flags.

## Verify it worked

Log in as a user with the permission and visit **Reports → Known Overrides
Report** (`/admin/reports/known-overrides`). You should see a table listing the
differences between your stored configuration and the values `settings.php` is
actually applying, with the overrides you declared marked as expected.
