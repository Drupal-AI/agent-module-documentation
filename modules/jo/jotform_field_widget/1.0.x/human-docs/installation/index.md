# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- Core's **Field** module (`field`) — always present on a standard site; Drupal
  enables it as a dependency.
- A **Jotform account** with an **API key**, so the widget can look up your forms.

There are no additional third‑party Composer requirements beyond what the module
pulls in for its Jotform API client.

## Install with Composer

From the project root:

```bash
composer require drupal/jotform_field_widget -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/jotform_field_widget -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en jotform_field_widget -y
```

## Verify it worked

Go to **Configuration → Web services → Jotform Field Widget**
(`/admin/config/services/jotform-field-widget`) and confirm the settings form
appears. After you enter your API key (see
[Configuration](../configuration/index.md)) and switch a string field to the
Jotform widget, editing that content should let you pick a Jotform form.
