# Installation

## Requirements

- **Drupal 11** (`core_version_requirement: ^11`).
- **Field Widget Actions** (`field_widget_actions`) — the module that adds action
  buttons to field widgets.
- **FlowDrop Workflow** (`flowdrop_workflow`) and the FlowDrop base modules — the
  workflow engine the actions execute.

There are no extra Composer library or PHP version requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/flowdrop_field_widget_actions -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in the Field Widget
Actions and FlowDrop dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/flowdrop_field_widget_actions -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en flowdrop_field_widget_actions -y
```

Drupal will enable Field Widget Actions and the required FlowDrop modules as
dependencies if they are not already on.

## Verify it worked

Go to any content type's **Manage form display** and edit a text or textarea widget.
You should be able to add a **Field Widget Action** that runs a FlowDrop workflow. If
the option is missing, confirm both `field_widget_actions` and `flowdrop_workflow` are
enabled and that you have at least one workflow defined.
