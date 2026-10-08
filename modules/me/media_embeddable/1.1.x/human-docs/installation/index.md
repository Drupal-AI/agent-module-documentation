# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- Drupal core's **Media** module (`media`), which Drupal enables automatically as
  a dependency.

There are no contributed‑module dependencies and no third‑party PHP libraries to
install.

## Install with Composer

From the project root:

```bash
composer require drupal/media_embeddable -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/media_embeddable -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en media_embeddable -y
```

Core's Media module is enabled automatically if it is not already on.

## Verify it worked

Go to **Structure → Media types** (`/admin/structure/media`) and confirm an
**Embeddable** media type is listed. Then, before anyone uses it, visit
**People → Permissions** (`/admin/people/permissions`) and make sure
`administer media embeddable` is granted only to trusted, code‑level roles — see
[Configuration](../configuration/index.md) for why this matters.
