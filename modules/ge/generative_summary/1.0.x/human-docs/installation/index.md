# Installation

## Requirements

Generative Summary is light on dependencies, but it does need an external
service:

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- Core's **Field** module (`field`), which is enabled on any standard Drupal
  site.
- An **OpenAI account and API key** — the module calls the OpenAI Chat
  Completions API, so you need valid credentials and available quota. Note that
  each generated summary is a billable API request.

## Install with Composer

From the project root:

```bash
composer require drupal/generative_summary -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/generative_summary -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en generative_summary -y
```

## Verify it worked

After enabling, visit **Configuration → Content authoring → Generative Summary**
(`/admin/config/content/generative_summary`). If the settings form loads, the
module is active. It won't actually generate anything until you add your OpenAI
API key and enable the feature on at least one field — see
[Configuration](../configuration/index.md).
