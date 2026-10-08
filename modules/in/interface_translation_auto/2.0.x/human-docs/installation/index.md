# Installation

## Requirements

- **Drupal 10.1, 11, or 12** (`core_version_requirement: ^10.1 || ^11 || ^12`).
- Core's **Language** (`language`) and **Interface Translation / Locale**
  (`locale`) modules — Drupal enables them automatically as dependencies. Your site
  also needs at least one non‑English language configured for there to be strings
  to translate.
- A **DeepL** or **OpenAI** API key.
- Your server must be able to make outbound HTTPS requests to the translation
  service you choose.

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/interface_translation_auto -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/interface_translation_auto -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en interface_translation_auto -y
```

## Verify it worked

Go to **Configuration → Regional and language → Interface Translation Auto**
(`/admin/config/regional/interface-translation-auto`). If the settings page opens,
the module is installed. Continue to [Configuration](../configuration/index.md) to
enter your API key and run the batch.
