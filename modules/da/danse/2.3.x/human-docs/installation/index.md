# Installation

## Requirements

- **Drupal 10.3 or 11** (`core_version_requirement: ^10.3 || ^11`).
- **PHP 8.1 or newer** (`php: >=8.1`).
- No hard module dependencies. **ECA** and **Push Framework** are *optional*
  integrations — install them only if you want ECA workflows or push delivery.

## Install with Composer

From the project root:

```bash
composer require drupal/danse -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/danse -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en danse -y
```

## Submodules — enable only the sources you need

DANSE's base module is the framework; the **event sources and delivery come from
submodules**. Enable just the ones that match what you want to notify on, rather
than turning them all on:

| Submodule | Machine name | Source / role |
|-----------|--------------|---------------|
| **Content** | `danse_content` | Entity activity — create/update/delete/publish/unpublish for *any* content entity (nodes, media, comments, taxonomy terms, commerce orders, and more). |
| **Config** | `danse_config` | Configuration changes. |
| **User** | `danse_user` | User account events. |
| **Form** | `danse_form` | Form submissions. |
| **Log** | `danse_log` | Log entries above a chosen severity. |
| **Generic** | `danse_generic` | Arbitrary / custom events. |
| **Webhook** | `danse_webhook` | Outbound webhook delivery to external systems. |
| **ECA DANSE** | `eca_danse` | Drive ECA workflows from subscriptions. |

For example, to notify on content changes:

```bash
drush en danse_content -y
```

> **Plan pruning first.** Before enabling high‑volume sources like `danse_log` or
> `danse_config` on a busy site, decide your retention policy — the framework
> records an event row per occurrence. See
> [Configuration](../configuration/index.md) for the prune form.

## Verify it worked

Go to **Configuration → System → DANSE** (`/admin/config/system/danse`) and
confirm the settings form loads. Enable at least one source submodule, configure
which events users may subscribe to, and check that a user can manage their
subscriptions at `/user/{user}/subscriptions`.
