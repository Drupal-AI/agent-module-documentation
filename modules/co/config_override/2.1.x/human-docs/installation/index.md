# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- The **`symfony/dotenv`** library (`^4.0 || ^5.0 || ^6.0`), which powers the
  environment‑variable override source. Composer installs it automatically with the module.

There are no module dependencies to enable by hand.

## Install with Composer

From the project root:

```bash
composer require drupal/config_override -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in `symfony/dotenv` and update
any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/config_override -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en config_override -y
```

Enabling the module makes the three override sources available. It does not, on its own,
override anything — you supply the actual overrides through `settings.php`, a module's YAML,
or environment variables, as described in [the main guide](../index.md).

## Verify it worked

Because Config Override has no UI, the way to confirm it is working is to define a single
override and check that it takes effect. For example, drive the site name from an
environment variable (per the module's `README.md` naming convention), clear caches
(`drush cr`), and confirm the site uses the overridden value at runtime while
`drush config:get system.site name` still shows the stored value. That difference —
overridden at runtime, unchanged in storage — is Config Override working as intended.
