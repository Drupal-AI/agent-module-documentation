# Installation

## Requirements

- **Drupal 11 only** (`core_version_requirement: ^11`) — there is no Drupal 10
  path.
- Core's **Layout Builder** (`layout_builder`) and **Block** (`block`).
- **Tempstore +** (`tempstore_plus`) and **Navigation +** (`navigation_plus`) —
  contributed modules from the + Suite family. These are pulled in with Layout
  Builder + and jointly replace parts of the editing experience, so treat
  adopting Layout Builder + as adopting this small family of modules.

## Install with Composer

From the project root:

```bash
composer require drupal/lb_plus -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in
`navigation_plus`, `tempstore_plus`, and any other shared dependencies.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/lb_plus -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en lb_plus -y
```

Enabling `lb_plus` also enables its required dependencies.

## Submodules — enable only what you need

Layout Builder + ships three optional submodules:

| Submodule | Machine name | What it adds |
|-----------|--------------|--------------|
| **Section Library support** | `lb_plus_section_library` | Integrates Layout Builder + with the **Section Library** module (also needs `section_library` and `navigation_plus`). |
| **LB Block Decorator support** | `lb_plus_lb_block_decorator` | Adds nested-layout support to the **Layout Builder Block Decorator** module. |
| **Edit Plus** | `lb_plus_edit_plus` | **Deprecated.** Its functionality has moved into `lb_plus`; it exists only so database updates can uninstall it. Do not enable it on new sites. |

For example:

```bash
drush en lb_plus_section_library -y
```

## Verify it worked

Open any Layout Builder–enabled entity and edit its layout. You should see the
Layout Builder + canvas — drag-and-drop, a block-placement sidebar, and the
ability to add nested sections — rather than core's modal-driven interface. Next,
grant the module's permissions to your page-building roles; see
[Configuration](../configuration/index.md).
