# Installation

## Requirements

Antispam by CleanTalk needs:

- **Drupal 8.8, 9, 10, or 11** (`core_version_requirement: ^8.8 || ^9 || ^10 || ^11`).
- No other Drupal modules and no third-party PHP libraries are required.
- A **CleanTalk account** (from cleantalk.org) to get an **Access key**, plus
  **outbound network access** from your server to the CleanTalk API. Without a
  valid key and network access, the module stores your settings but performs no
  live spam checks.

## Install with Composer

Note the Composer package name differs from the machine name — it is published as
`cleantalk/drupalantispam`:

```bash
composer require cleantalk/drupalantispam -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require cleantalk/drupalantispam -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en cleantalk -y
```

## Next steps

Once enabled, go to **Configuration → Content authoring → Antispam by CleanTalk →
Settings** and enter your Access key — see
[Configuration](../configuration/index.md).
