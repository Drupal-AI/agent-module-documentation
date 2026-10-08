# Installation

## Requirements

- **Drupal 10.3 or later, or Drupal 11** (`core_version_requirement: ^10.3 || ^11`).
- No additional modules required.
- **Drush 11 or later** — optional, only needed for the command-line pattern
  management commands.

## Install with Composer

From the project root:

```bash
composer require drupal/error_squelch -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/error_squelch -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en error_squelch -y
```

After enabling, grant the **Administer Error Squelch** permission (at **People →
Permissions**) to the roles who should manage suppression patterns.

## Verify it worked

Open the Error Squelch settings form via the module's **Configure** link on the
Extend page. Add a pattern, then use the module's **test mode** to inject a known
message and confirm it gets suppressed — see [Configuration](../configuration/index.md)
for the details.
