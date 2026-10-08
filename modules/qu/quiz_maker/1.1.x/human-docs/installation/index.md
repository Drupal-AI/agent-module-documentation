# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`). The 1.x
  branch is intended for Drupal 9/10 sites.
- Core modules **Datetime Range** and **Editor** (enabled automatically as
  dependencies).
- Several contributed modules, which Composer installs for you when you use the
  `-W` flag below:
  - **Entity Reference Revisions** (`entity_reference_revisions`)
  - **Inline Entity Form** (`inline_entity_form`)
  - **Field Group** (`field_group`)
  - **Views Bulk Operations** (`views_bulk_operations`)
  - **Entity Browser** (`entity_browser`)
  - **Entity API** (`entity`)

## Install with Composer

From the project root:

```bash
composer require drupal/quiz_maker -W
```

The `-W` (`--with-all-dependencies`) flag is important here — it lets Composer pull
in all of the contrib dependencies listed above and update any shared packages as
needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/quiz_maker -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en quiz_maker -y
```

Drupal will enable the dependencies at the same time.

## Submodules

Quiz Maker ships an export submodule, **Quiz Maker Export**
(`quiz_maker_export`), which lets you export quiz results to PDF or a spreadsheet.
Enable it only if you need that:

```bash
drush en quiz_maker_export -y
```

## Verify it worked

Log in as an administrator and look under **People → Permissions** for the Quiz
Maker permissions, then grant the roles that should create, take, and review
quizzes. Head to [Configuration](../configuration/index.md) to build your first
quiz.
