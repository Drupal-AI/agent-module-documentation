# Installation

## Requirements

- **Drupal 8, 9, 10, or 11** (`core_version_requirement: ^8 || ^9 || ^10 || ^11`).
- The contributed **Field Group** module (`field_group`) — this is the only hard
  dependency. Popup Field Group is an extension of Field Group and cannot work
  without it.

Optionally, the **System Stream Wrapper** module
(`drupal/system_stream_wrapper`) lets you include custom CSS files in a popup via
stream‑wrapper paths. It is only a suggestion, not a requirement.

There are no PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/popup_field_group -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed. If you do not already have Field Group, add it too:

```bash
composer require drupal/field_group drupal/popup_field_group -W
```

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/popup_field_group -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en popup_field_group -y
```

Enabling it also pulls in Field Group if it is not already on. The module ships
no submodules.

## Verify it worked

Go to any bundle's **Manage form display** or **Manage display** screen (for
example **Structure → Content types → Article → Manage display**) and click
**Add group**. "Popup" should now appear in the list of group types. Head to
[Configuration](../configuration/index.md) for the full walkthrough.
