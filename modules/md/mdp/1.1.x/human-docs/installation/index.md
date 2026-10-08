# Installation

## Requirements

- **Drupal 10.3+ or 11** (`core_version_requirement: ^10.3 || ^11`).
- Core's **Field** module (`field`) — enabled automatically.
- The **jQuery UI Datepicker** module (`jquery_ui_datepicker`), which supplies the calendar
  widget the picker is built on. It is listed as a dependency.

## Install with Composer

From the project root:

```bash
composer require drupal/mdp -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in the jQuery UI Datepicker
module and any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/mdp -W`, `ddev drush …`. Inside the container
> (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en mdp -y
```

## Verify it worked

Go to **Structure → Content types → *(any type)* → Manage fields** and click **Add field**.
**Multi Dates Picker** should appear in the list of field types. Add it to a content type,
then edit a piece of that content and confirm the calendar lets you pick multiple dates.
Setting up and using the field is covered in "How to use it" in the
[overview](../index.md).
