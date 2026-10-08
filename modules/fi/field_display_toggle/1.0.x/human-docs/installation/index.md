# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- Core's **Field UI** module (`field_ui`) — this is what provides the *Manage
  display* screens the toggle attaches to, so it must be enabled.

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/field_display_toggle -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/field_display_toggle -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en field_display_toggle -y
```

If Field UI is not yet enabled, turn it on too:

```bash
drush en field_ui -y
```

There is no configuration to do.

## Verify it worked

Go to **Structure → Content types → *(any type)* → Manage display**. At the top
of the form you should see two radio buttons, **Enable all fields** and
**Disable all fields**. Pick one, confirm the fields move to the content or
disabled region accordingly, and click **Save**.
