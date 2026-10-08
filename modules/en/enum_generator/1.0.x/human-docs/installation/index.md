# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- Core's **Taxonomy** module (`taxonomy`) — the generator reads vocabularies and
  terms, and Drupal enables it automatically as a dependency.
- The **`nette/php-generator`** PHP library, which builds the generated files.
  Because of this Composer dependency, install the module **with Composer** (not
  by copying files) so the library is pulled in.

## Install with Composer

From the project root:

```bash
composer require drupal/enum_generator -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer install
`nette/php-generator` and update any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/enum_generator -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en enum_generator -y
```

## Grant the permission

The generator is gated by the **Access enum generator** permission, which is
marked *restrict access*. Grant it only to trusted developer roles under
**People → Permissions**.

## Verify it worked

Go to **Structure → Enum Generator → Taxonomy**
(`/admin/structure/enum-generator/taxonomy`). You should see the generator form
with Namespace, Vocabulary, Generation Type, and Backing Type fields. Pick a
vocabulary and submit to download a generated `.php` file. See
[How to use it](../index.md#how-to-use-it) for details.
