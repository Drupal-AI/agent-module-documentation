# Installation

> **Development sites only.** Read the warning on the [main page](../index.md)
> before you install. This module creates active accounts with guessable
> passwords and has no built‑in production guard — never enable it on a live site.

## Requirements

- **Drupal 9.5, 10, or 11** (`core_version_requirement: ^9.5 || ^10 || ^11`).
- Core's **User** module (`user`), which is always present.

No third‑party Composer or PHP libraries are needed.

## Install with Composer

From the project root:

```bash
composer require drupal/qa_accounts -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed. Consider requiring it as a `--dev` dependency so it never
travels to production in the first place.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/qa_accounts -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en qa_accounts -y
```

**Enabling it immediately creates the accounts.** The install hook runs the
create routine, so as soon as the module is on you'll have a `qa_<role>` user for
every role except *anonymous*. There are no submodules.

## Uninstalling

Uninstalling the module does **not** delete the accounts it created — they persist
until you remove them. Tear them down first:

```bash
drush qa_accounts:delete
drush pm:uninstall qa_accounts -y
```

See [Configuration](../configuration/index.md) for what the accounts look like and
the full set of Drush commands.
