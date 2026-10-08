# Installation

## Requirements

- **Drupal 9.3, 10, or 11** (`core_version_requirement: ^9.3 || ^10 || ^11`).
- The **Checklist API** module (`checklistapi`) — the required dependency that
  provides the interactive checklist itself. Composer pulls it in automatically.

## Install with Composer

From the project root:

```bash
composer require drupal/pasc -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer install Checklist API and
update any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/pasc -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

Enabling `pasc` will also enable its **Checklist API** dependency if it is not
already on:

```bash
drush en pasc -y
```

## Verify it worked

Log in as an administrator and open the site's checklists. You should see the
**Performance and Scalability Checklist** available, listing the optimization
tasks with checkboxes you can tick as you complete them.
