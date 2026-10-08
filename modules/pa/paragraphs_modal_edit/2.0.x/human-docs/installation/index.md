# Installation

## Requirements

- **Drupal 10.3, 11, or 12** (`core_version_requirement: ^10.3 || ^11 || ^12`).
- **Paragraphs** (`drupal/paragraphs`, `^1.19`) — required.
- **Paragraphs Edit** (`drupal/paragraphs_edit`, `^3.0`) — required; this module
  reuses its per‑paragraph edit routes.
- **Entity Reference Revisions** — pulled in as part of the Paragraphs stack.

## Install with Composer

From the project root:

```bash
composer require drupal/paragraphs_modal_edit -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in Paragraphs,
Paragraphs Edit, and their dependencies and update any shared packages as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/paragraphs_modal_edit -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en paragraphs_modal_edit -y
```

This enables Paragraphs and Paragraphs Edit too if they aren't already on. There
are no submodules.

## Verify it worked

As long as your paragraphs already expose Paragraphs Edit's contextual
edit/clone/delete links on the rendered page, those links will now open in a modal
dialog. Adjust the dialog width at **Configuration → User interface → Paragraphs
Modal Edit** if the forms need more room — see the
[main page](../index.md#how-to-use-it).
