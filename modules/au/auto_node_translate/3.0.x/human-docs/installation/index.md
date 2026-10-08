# Installation

## Requirements

- **Drupal 10.2 or 11** (`core_version_requirement: ^10.2 || ^11`).
- Core's **Content Translation** module (`content_translation`) — a hard
  dependency that Drupal enables for you.
- A **multilingual site**: enable core's **Language** module, add at least one
  extra language, and make the content types you want to translate translatable
  (under **Configuration → Content authoring → Content language and translation**).
- Optionally, core's **Content Moderation** module if you want new translations to
  land in a specific moderation state.

There are no third‑party Composer or PHP library requirements. The built‑in
**MyMemory** provider works with no API key (an email to raise its free quota is
optional).

## Install with Composer

From the project root:

```bash
composer require drupal/auto_node_translate -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/auto_node_translate -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en auto_node_translate -y
```

Drupal enables Content Translation as a dependency at the same time.

## Next steps

Enable your languages and mark content types translatable, then grant the
per‑content‑type **Auto translate** permission and choose your translation
provider. See [Configuration](../configuration/index.md) for the full walkthrough.
