# Installation

## Requirements

- **Drupal 8.8, 9, 10, 11, or 12** (`core_version_requirement: ^8.8 || ^9 || ^10 || ^11`).
- The **Paragraphs** module (`paragraphs`) — Drupal enables it automatically as a
  dependency when you turn on Paragraphs Gantt.

The chart is drawn with the bundled dhtmlx Gantt JavaScript library, so there are
no extra Composer libraries for you to install. The module works best with a
Bootstrap 5 admin theme, but that is a recommendation, not a requirement.

## Install with Composer

From the project root:

```bash
composer require drupal/paragraphs_gantt -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/paragraphs_gantt -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en paragraphs_gantt -y
```

## Verify it worked

Go to **Structure → Paragraph types** and confirm a **Gantt** paragraph type is
listed. Then open a content type that has a Paragraphs field, visit its **Manage
display**, and check that the **Gantt** formatter is available for that field.
Once you map the task/start/end fields and add some paragraphs, the field renders
as an interactive Gantt timeline. See "How to use it" on the
[overview page](../index.md) for the full workflow.
