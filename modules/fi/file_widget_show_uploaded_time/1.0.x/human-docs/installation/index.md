# Installation

## Requirements

- **Drupal 8, 9, 10, or 11** (`core_version_requirement: ^8 || ^9 || ^10 || ^11`).
- Core's **Field** (`field`) and **File** (`file`) modules — enabled automatically as
  dependencies.

There are no third-party Composer or PHP library requirements. Note this is a **beta**
release (`1.0.0-beta1`).

## Install with Composer

From the project root:

```bash
composer require drupal/file_widget_show_uploaded_time -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update shared dependencies as
needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/file_widget_show_uploaded_time -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en file_widget_show_uploaded_time -y
```

## Turn it on for a field

Enabling the module changes nothing on its own — you switch the widget per field:

1. Go to an entity type's **Manage form display** (for example a Media type with a
   file field).
2. Set the file field's **Widget** to **File showing latest uploaded date**.
3. Click the **gear icon** and choose the **date/time format** for the displayed
   timestamp.
4. **Update** and **Save**.

## Verify it worked

Edit a piece of content that uses the field you configured. In the edit form, each
uploaded file should now show its latest uploaded date, formatted as you chose.
Remember this appears only on the **edit form** for editors, not in the file's public
display.
