# Installation

## Requirements

- **Drupal 10.3, 11, or 12** (`core_version_requirement: ^10.3 || ^11 || ^12`).

That's all — the module builds on core's Field API and has no other module
dependencies and no third-party PHP libraries.

## Install with Composer

From the project root:

```bash
composer require drupal/limited_field_widgets -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run them from your
> host machine — `ddev composer require drupal/limited_field_widgets -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en limited_field_widgets -y
```

## Verify it worked

Find a field whose storage cardinality is **Unlimited**, open the bundle's **Manage
form display**, and click that field widget's cog. You should see a new required
**"Limit values"** number setting. Enter a maximum and save — see the
[overview](../index.md#how-to-use-it) for how the cap is enforced. There is no other
configuration.
