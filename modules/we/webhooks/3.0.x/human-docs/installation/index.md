# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- Core's **Serialization** module (`serialization`), enabled automatically as a
  dependency — it encodes and decodes the JSON/XML payloads.
- PHP's JSON extension (`ext-json`), which is standard on any Drupal-capable PHP
  build.

## Install with Composer

From the project root:

```bash
composer require drupal/webhooks -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/webhooks -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en webhooks -y
```

## Optional submodule — store received webhooks

Webhooks ships one submodule, **Webhook** (`webhook`). It subscribes to the
"webhook received" event and stores every incoming webhook as a content entity so
you can browse an audit trail at **Content → Webhooks**
(`/admin/content/webhook`, permission **Access webhook overview**). Enable it only
if you want that record:

```bash
drush en webhook -y
```

## Verify it worked

Log in as an administrator and visit
**Configuration → Web services → Webhooks** (`/admin/config/services/webhook`).
You should see an empty webhook list with an **Add webhook** button. Continue to
[Configuration](../configuration/index.md) to create your first webhook.
