# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- Core **Menu link content** module (`menu_link_content`), enabled automatically as
  a dependency.
- A **OneTrust account** (from https://onetrust.com/), which provides the UUID /
  data‑domain script identifier the module needs.

## Install with Composer

From the project root:

```bash
composer require drupal/gdpr_onetrust -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/gdpr_onetrust -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en gdpr_onetrust -y
```

## Submodule — enable the blocker

The most important part of a real consent setup is the blocking submodule, which
holds scripts back until the visitor consents:

```bash
drush en onetrust_cookie_blocking -y
```

| Submodule | Machine name | What it adds |
|-----------|--------------|--------------|
| **OneTrust Cookie Blocking** | `onetrust_cookie_blocking` | Prevents tracking scripts from loading until the visitor has consented to the relevant OneTrust category. This is the part that actually enforces consent — enable it. |

## Verify it worked

Log in as an administrator and open **Configuration → System → GDPR OneTrust**
(`/admin/config/system/gdpr-onetrust`). If the settings form loads, continue to
[Configuration](../configuration/index.md).
