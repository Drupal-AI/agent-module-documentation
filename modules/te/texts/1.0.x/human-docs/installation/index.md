# Installation

## Requirements

Texts needs:

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- Core's **Locale** and **Content Translation** modules for translation features.
  Texts itself lists no hard module dependencies and installs as a standard
  contributed module.

There are no third-party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/texts -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/texts -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en texts -y
```

That is all the base module needs — it installs with no dependencies of its own.

## Optional submodule — Texts GraphQL

If you run a decoupled/headless front end and want it to read the same snippets,
enable the GraphQL submodule:

| Submodule | Machine name | What it adds |
|-----------|--------------|--------------|
| **Texts GraphQL** | `texts_graphql` | Exposes your text snippets over GraphQL so a decoupled consumer can fetch the translations, instead of hard-coding its own copies. |

```bash
drush en texts_graphql -y
```

Enable this only if you actually have a GraphQL consumer; the base Texts module is
fully usable on its own for a traditional Drupal front end.

## Verify it worked

Log in as an administrator and visit **Configuration → Regional and language →
Texts** (`/admin/config/regional/texts`). If the management screen loads, the
module is installed and ready.
