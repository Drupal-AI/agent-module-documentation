# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- A family of supporting Configuration Management modules, which Composer installs for
  you as dependencies:
  - `drupal/config_distro` — provides the **Distribution Updates** page and import flow.
  - `drupal/config_filter`
  - `drupal/config_merge` — powers the three-way Merge mode.
  - `drupal/config_normalizer`
  - `drupal/config_provider`
  - `drupal/config_snapshot` — records what each extension provided at install time.
  - `drupal/config_update`
- No PHP library requirements.

> **Heads up:** several of these dependencies are released as alpha/beta versions
> (for example `config_distro`, `config_merge`, and `config_provider`). That is normal
> for this toolchain, but you may need your project's `composer.json` to permit
> `alpha`/`beta` stability (a `minimum-stability` of `dev` with `prefer-stable: true`,
> or explicit version constraints) for the install to resolve.

## Install with Composer

From the project root:

```bash
composer require drupal/config_sync -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed, and pulls in all the supporting modules listed above.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/config_sync -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en config_sync -y
```

Enabling `config_sync` also enables its required modules (`config_distro_filter`,
`config_merge`, `config_normalizer`, `config_provider`, `config_snapshot`, and
`config_update`). During installation the module takes an initial **snapshot** of the
configuration every installed extension currently provides — this is the baseline it
later compares against to detect updates.

There are no submodules and no permissions of its own. Next, see
[Configuration](../configuration/index.md) to review and apply updates.
