# Installation

## Requirements

- **Drupal 9.2 or 10** (`core_version_requirement: ^9.2 || ^10`).
- Core modules: **Node**, **Taxonomy**, **Menu link content**, **Image**,
  **File**, **Field**, and **Menu UI** — enabled automatically as dependencies.
- The **Migrate** core module, plus the contrib modules **Migrate Plus**
  (`migrate_plus`) and **Migrate Tools** (`migrate_tools`).
- The `gathercontent/client` PHP library (`^1.2`) for API communication — this is
  pulled in automatically by Composer.
- A GatherContent (Content Workflow) account with an API key.

Because the module uses a custom PHP library for API communication, installing
with Composer is by far the easiest route — it downloads the module *and* all of
its dependencies for you.

## Install with Composer

From the project root:

```bash
composer require drupal/gathercontent -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in Migrate Plus,
Migrate Tools, and the `gathercontent/client` library as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/gathercontent -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en gathercontent -y
```

Then run database updates in case the module registers any:

```bash
drush updatedb -y
```

## Submodules — enable what you need

| Submodule | Machine name | What it adds |
|-----------|--------------|--------------|
| **GatherContent UI** | `gathercontent_ui` | The admin UI for defining import mappings and running manual imports. Most sites want this. |
| **GatherContent Upload** | `gathercontent_upload` | Pushes Drupal content back *up* to GatherContent. |
| **GatherContent Upload UI** | `gathercontent_upload_ui` | The admin UI for the upload/push functionality. |

For a typical import‑only setup, add the UI submodule:

```bash
drush en gathercontent_ui -y
```

## Verify it worked

Log in as an administrator and go to **Configuration → Web services →
GatherContent** (`/admin/config/services/gathercontent`). If the page loads,
continue to [Configuration](../configuration/index.md) to connect your account.
