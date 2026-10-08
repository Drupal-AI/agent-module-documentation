# Installation

## Requirements

Field Report is lightweight. It needs:

- **Drupal 8.8, 9, 10, or 11** (`core_version_requirement: ^8.8 || ^9 || ^10 || ^11`).
- Core's **Field UI** module (`field_ui`) — this is the only dependency, and
  Drupal enables it automatically when you turn on Field Report.

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/field_report -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/field_report -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en field_report -y
```

That's all it takes. If Field UI is not already on, Drupal enables it as a
dependency at the same time.

## Grant access

The report is gated by the **Administer field report** permission
(`administer field_report`). Administrators have it by default; grant it to other
roles at **People → Permissions** (`/admin/people/permissions`) if you want
non‑admins to view the report.

## Verify it worked

Log in as an administrator and go to **Reports → Field report**
(`/admin/reports/fields/field-report`). You should see a set of tables listing the
fields on each bundle across your site. There is no required configuration.
