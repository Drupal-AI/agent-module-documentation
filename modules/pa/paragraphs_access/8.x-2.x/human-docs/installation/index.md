# Installation

## Requirements

- **Drupal 10, 11 or 12** (`core_version_requirement: ^10 || ^11 || ^12`).
- The **Paragraphs** module (`paragraphs`).
- The **Advanced Access (ADVA)** framework, which the 2.x branch is built around and
  which performs the actual **view** enforcement, plus a companion module that
  supplies the access rules and grants you want (for example Role Access Control).

Use the **8.x‑2.x** branch — it is the recommended, actively developed version.
8.x‑1.x is no longer maintained and should not be used.

## Install with Composer

From the project root:

```bash
composer require drupal/paragraphs_access -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer bring in Paragraphs and
update any shared dependencies as needed. Install the Advanced Access framework and
your chosen access‑rule module the same way.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/paragraphs_access -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en paragraphs_access -y
```

Enable the Advanced Access framework and your access‑rule companion module as well,
so that view grants are actually evaluated.

## Verify it worked

As a user who should **not** have edit access to a given paragraph, open the content
edit form — that paragraph's widget should be hidden or non‑editable. Then, with
your view rules configured, view the content as a restricted user and confirm the
paragraph is not shown. Finally, check the same restriction holds over
**JSON:API/REST**, field‑rendering **Views**, and any **feeds** — view enforcement
runs through the Advanced Access framework, so those paths must be tested explicitly.
