# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- Valid **AB InBev CDP API credentials** for the platform you are connecting to.
- No third-party Composer or PHP library requirements are declared.

## Install with Composer

From the project root:

```bash
composer require drupal/abinbev_cdp -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/abinbev_cdp -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en abinbev_cdp -y
```

## Store your CDP credentials securely

Do not paste the CDP API credentials directly into a configuration form that
gets exported to code. Keep them in an environment variable instead. With DDEV
you can save one like this:

```bash
ddev dotenv set .ddev/.env --abinbev-cdp-key=<value>
ddev restart
```

The flag `--abinbev-cdp-key` becomes the environment variable
`ABINBEV_CDP_KEY`, which the site can read at runtime. Keep `.ddev/.env` out of
version control. After enabling the module, supply the connection details for
each brand/market configuration you need.
