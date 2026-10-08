# Installation

## Requirements

- **Drupal 8.8, 9, 10, or 11** (`core_version_requirement: ^8.8 || ^9 || ^10 || ^11`).
- Core's **Locale** module (`locale`) enabled — this is a dependency, and Drupal
  enables it automatically when you turn on gText.
- The **`google/cloud-translate`** PHP library (`^1.10`) — installed automatically by
  Composer.
- A **Google Cloud Translate API key** *only if* you want to use the official Google
  machine-translation client. Without a key, gText still works using a free fallback
  (limited to 1000 characters per request).

## Install with Composer

From the project root:

```bash
composer require drupal/gtext -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed. This also installs the `google/cloud-translate` library.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/gtext -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en gtext -y
```

> **Note — a settings.php side effect:** gText's install step appends `t` and
> `plural` to the `twig_sandbox_whitelisted_methods` setting in `settings.php` so the
> `gtext()` Twig helper works inside sandboxed templates. This is expected; it is
> what lets the helper run in themes.

## Next steps

1. If you want Google machine-translation help, add a **Google Cloud Translate API
   key** — see [Configuration](../configuration/index.md).
2. Grant the two gText permissions (*Access gtext translate strings* and *Access
   gtext translate*) to your translator roles at **People → Permissions**.
3. Visit **`/admin/config/texts`** to start translating strings.
