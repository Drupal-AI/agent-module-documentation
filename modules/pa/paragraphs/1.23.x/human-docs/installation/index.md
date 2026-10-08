# Installation

## Requirements

- **Drupal 10.3 or 11** (`core_version_requirement: ^10.3 || ^11`).
- The contributed **Entity Reference Revisions** module (`drupal/entity_reference_revisions`,
  `~1.3`) — this is what gives paragraphs their revisionable storage. Composer
  pulls it in automatically.
- Core's **File** module (`file`), enabled automatically as a dependency.

There are no PHP extension or third‑party library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/paragraphs -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer bring in Entity Reference
Revisions and update any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/paragraphs -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en paragraphs -y
```

Enabling Paragraphs alone gives you the field type and the type-management UI, but
no visible change on your content until you create Paragraph types and add a
Paragraphs field (see [Configuration](../configuration/index.md)).

## Submodules

Paragraphs ships three optional submodules. Enable only what you need with
`drush en`:

| Submodule | Machine name | What it adds |
|-----------|--------------|--------------|
| **Paragraphs Library** | `paragraphs_library` | Lets editors save a paragraph to a reusable library and reference the same authored item from many pages. Pairs well with the Entity Browser module for a nicer picker. |
| **Paragraphs Type Permissions** | `paragraphs_type_permissions` | Adds per-type create/edit/delete permissions so you can restrict which roles may use which Paragraph types. |
| **Paragraphs Demo** | `paragraphs_demo` | Installs example Paragraph types and content to learn from. Handy on a scratch/dev site; not for production. |

For example, to enable the library:

```bash
drush en paragraphs_library -y
```

## Verify it worked

Log in as an administrator and visit **Structure → Paragraphs types**
(`/admin/structure/paragraphs_type`). You should see the (empty) list of Paragraph
types with an **Add paragraph type** button. That confirms the module is active and
ready for you to start building types.
