# Installation

## Requirements

- **Drupal 10.1 or 11** (`core_version_requirement: ^10.1 || ^11`).
- The **Feeds** module (`feeds`) — this module extends it.
- The **Key** module (`key`) — used by the SFTP fetcher for secure credential
  storage.
- The **DX Toolkit** module (`dx_toolkit`).

This is a **beta** release intended for community testing; keep that in mind
before using it on a production site.

## Install with Composer

From the project root:

```bash
composer require drupal/feeds_enhanced -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in Feeds, Key, DX
Toolkit and any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/feeds_enhanced -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en feeds_enhanced -y
```

Drupal enables the Feeds, Key and DX Toolkit dependencies automatically.

## Submodules

| Submodule | Machine name | What it adds |
|-----------|--------------|--------------|
| **Feeds Enhanced — Token Support** | `feeds_enhanced_tokens` | Universal token expansion for *all* Feeds and feed type text fields (source URLs, fetcher/parser/processor settings, default values). Works automatically via an event subscriber — no configuration needed. Available from release 1.0.0‑beta3. |

Enable it only if you want token support:

```bash
drush en feeds_enhanced_tokens -y
```

## Verify it worked

Create or edit a feed type at **Structure → Feed types** and confirm that the
enhanced fetchers/parsers/processor appear as options in the fetcher, parser and
processor selectors. If you enabled Token Support, tokens placed in text fields on
feeds and feed types will be expanded when the feed runs.
