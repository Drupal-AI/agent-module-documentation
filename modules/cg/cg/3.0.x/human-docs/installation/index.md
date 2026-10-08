# Installation

## Requirements

- **Drupal 10.3 or 11** (`core_version_requirement: ^10.3 || ^11`).
- Core's **Filter** module (`filter`) — enabled by default on most sites.
- The **`erusev/parsedown`** PHP library, which renders the Markdown. Installing
  via Composer pulls it in automatically.

## Install with Composer

Install via Composer so the Parsedown library is resolved for you:

```bash
composer require drupal/cg -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/cg -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en cg -y
```

## Submodules

Content Guide ships one optional submodule:

| Submodule | Machine name | What it adds |
|-----------|--------------|--------------|
| **Content Guide Field Group** | `cg_field_group` | Integrates guidance with the [Field Group](https://www.drupal.org/project/field_group) module, so guides can be attached to grouped fields. Enable it only if you use Field Group. |

```bash
drush en cg_field_group -y
```

## Verify it worked

Confirm the module is enabled under **Extend** and that the settings form loads at
**Configuration → Content authoring → Content Guide**
(`/admin/config/content/content_guide`). Then follow
[Configuration](../configuration/index.md) to set a base document path and attach
your first guide to a field — the guidance should appear beside that field when you
edit content. Remember to grant the **`use content guide`** permission (to trusted
editorial roles only) so those users can see the rendered guidance.
