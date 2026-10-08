# Installation

## Requirements

- **Drupal 10.3+, 11.1+, or 12** (`core_version_requirement: ^10.3 || ^11.1 || ^12`).
- **No required module dependencies** — the base framework runs on core alone.
- **Optional integrations:**
  - The **AI** module (`drupal/ai`) — provides "Fill with AI" and "Generate alt
    text" actions.
  - The **ECA** module (`drupal/eca`) — lets site builders trigger event-condition-
    action workflows from a field widget without writing code.

Without at least one module that provides an action plugin (AI, ECA, or your own
custom plugin), there are no buttons to attach — the base module is the framework
that hosts them.

## Install with Composer

From the project root:

```bash
composer require drupal/field_widget_actions -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/field_widget_actions -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en field_widget_actions -y
```

To use the AI or ECA integrations, install and enable those modules as well, for
example:

```bash
composer require drupal/ai -W
drush en ai -y
```

## Verify it worked

Go to **Structure → Content types → *(any type)* → Manage form display** and open a
field widget's settings (the gear icon). If an action plugin is available, you can
now choose which action(s) to attach to that field. Open an add/edit form for the
entity and confirm the action button appears next to the field.
