# Installation

## Requirements

- **Drupal 8, 9, 10, or 11** (`core_version_requirement: ^8||^9||^10||^11`).
- No other module dependencies for the base module.

## Install with Composer

From the project root:

```bash
composer require drupal/hashids -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/hashids -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en hashids -y
```

## Submodules

| Submodule | Machine name | What it adds |
|-----------|--------------|--------------|
| **Hashids Hash field** | `hashids_hash_field` | A field type that generates a hashid from reference IDs you select in the field settings — supports entity reference, Commerce, and relation references. |

Enable it only if you want the field:

```bash
drush en hashids_hash_field -y
```

## Verify it worked

After enabling the base module, your custom code (or a submodule that depends on
it) can encode integers into short hashid strings and decode them back. If you
enabled **Hashids Hash field**, add the field to a content type under
**Structure → Content types → *(your type)* → Manage fields** and you should see
the Hashids hash field type available.

Before you put hashids into URLs or identifiers, re-read the security note on the
[overview page](../index.md): hashids are reversible obfuscation, not a security
control, so keep enforcing real access checks.
