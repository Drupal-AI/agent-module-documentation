# Installation

## Requirements

- **Drupal 8, 9, or 10** (`core_version_requirement: ^8 || ^9 || ^10`).
- Core's **Field** module (`field`) — this is the only dependency, and it is
  enabled by default on standard installs.
- No third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/jqueryui_field -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/jqueryui_field -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en jqueryui_field -y
```

## Verify it worked

Go to **Structure → Content types → *(any type)* → Manage fields** and click
**Add field**. The **Jquery UI Field** field type should appear in the list of
available field types. Once added and given a couple of values, set its display to
**Jqueryui Tabs** or **Jqueryui Accordion** on Manage display and view a piece of
content — the items should render as interactive tabs or an accordion. See "How to
use it" in the [overview](../index.md) for the full walkthrough.
