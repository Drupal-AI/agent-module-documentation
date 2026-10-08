# Installation

> **Development sites only.** Stage File Proxy is designed for local, dev, and
> staging environments. **Do not enable it on production** — production is the
> origin, not the proxy.

## Requirements

- **Drupal 11.3 or 12** (`core_version_requirement: ^11.3 || ^12.0`).
- Core's **Image** module (`image`) — Drupal enables it automatically as a
  dependency.
- No third‑party Composer or PHP library requirements.

## Install with Composer

Because it is a development dependency, install it with `--dev` so it does not ship
to production:

```bash
composer require --dev drupal/stage_file_proxy -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require --dev drupal/stage_file_proxy -W`, `ddev drush
> …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en stage_file_proxy -y
```

A common pattern is to auto‑enable it right after syncing the production database
to a dev environment — add a `sql-sync` `target-command-specific` `enable` entry
for `stage_file_proxy` to your dev Drush site alias (see the module's `INSTALL.md`).
The module ships **no submodules**.

## Keeping it off production

If you configure the module through the UI and use configuration sync, keep it out
of your production config with
[Config Split](https://www.drupal.org/project/config_split). Setting the config in
`settings.local.php` instead sidesteps the problem entirely.

## Next steps

Nothing is proxied until you set the **origin** URL — see
[Configuration](../configuration/index.md).
