# Installation

## Requirements

- **Drupal 10.2+ or 11** (`core_version_requirement: ^10.2 || ^11`).
- **Drush**, since the module gates Drush commands.

There are no third-party Composer or PHP library requirements, and no other
module dependencies.

## Install with Composer

From the project root:

```bash
composer require drupal/drush_firewall -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/drush_firewall -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en drush_firewall -y
```

## Configure your rules

Enabling the module does not block anything on its own — you decide what to allow
and deny through `$settings[]` entries in `settings.php`. See the
[main guide](../index.md) for each available setting. Because these rules are
usually environment-specific, they are best placed in a per-environment settings
file.

## Cover non-bootstrapping commands

To protect commands that do not fully bootstrap Drupal (such as `sql:sync`), also
register the module in your `drush/drush.yml` under `drush: include:` — see the
[main guide](../index.md) for the exact syntax.

## Verify it worked

Add a harmless command to `drush_firewall_denied` in your settings file, then try
to run it — the firewall should block it. Remove it from the list (or pass
`--disable-firewall`) to confirm the command runs again.
