# Installation

## Requirements

- **Drupal 8, 9, 10, or 11** (`core_version_requirement: ^8 || ^9 || ^10 || ^11`).
- The **Checklist API** module (`checklistapi`) — this is the only dependency, and
  it provides the framework the Opquast checklist is rendered through.

There are no extra PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/opquast_checklist -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in Checklist API and
update any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/opquast_checklist -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en opquast_checklist -y
```

Enabling Opquast Checklist also enables Checklist API if it is not already on.

## Verify it worked

Log in as an administrator and go to **Reports → Checklists → Opquast Checklist**
(`/admin/reports/checklistapi/opquast`). You should see the full themed list of
Opquast rules ready to check off. Tick a few items and click save to confirm your
progress is recorded.
