# Installation

## Requirements

- **Drupal 11** (`core_version_requirement: ^11`).
- Core's **Link** module (`link`) enabled — this is the only dependency, and
  Drupal enables it automatically when you turn on SMS Link Field.

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/sms_link_field -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/sms_link_field -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en sms_link_field -y
```

## Verify it worked

Go to **Structure → Content types →** *(any type)* **→ Manage fields → Add
field**. You should see a **Link (with SMS support)** field type in the list. Add
it, then check **Manage display** for the **Link with SMS support** formatter.
