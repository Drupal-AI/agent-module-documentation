# Installation

## Requirements

- **Drupal 11** (`core_version_requirement: ^11`).
- The **ECA** base module (`eca`).
- The **Field Widget Actions** module (`field_widget_actions`).

Both dependencies are pulled in automatically when you require this module with
Composer. You will also want one of ECA's modelling tools (BPMN.iO or the ECA
Classic Modeller) installed so you have a UI in which to build models.

## Install with Composer

From the project root:

```bash
composer require drupal/eca_field_widget_actions -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in ECA and Field
Widget Actions and update any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/eca_field_widget_actions -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en eca_field_widget_actions -y
```

This also enables `eca` and `field_widget_actions` if they are not already on.

## Verify it worked

Create an ECA model that starts with the **ECA Field Widget** event at
**Configuration → Workflow → ECA**. Then open a content type's **Manage form
display** and confirm the Field Widget Action registered for that model appears as
an option on a field's widget. Clicking the resulting button on a content form
should fire your model.
