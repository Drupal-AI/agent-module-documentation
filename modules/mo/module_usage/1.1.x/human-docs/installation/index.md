# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- No PHP version constraint beyond what your Drupal core requires.
- **jQuery UI Accordion** (`drupal/jquery_ui_accordion`) — a required module
  dependency, used for the documentation accordions in the UI.

## Install with Composer

From the project root:

```bash
composer require drupal/module_usage -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed — including the jQuery UI Accordion module, which Composer
pulls in automatically.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/module_usage -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en module_usage -y
```

Drupal will enable the jQuery UI Accordion dependency at the same time.

## Grant permissions

Module usage provides granular permissions — `view module_usage`, `create
module_usage`, `edit module_usage`, `delete module_usage`, and the restricted
`administer module_usage`. Grant the appropriate ones to your roles at **People →
Permissions** (`/admin/people/permissions`) so the right people can read and edit
documentation.

## Verify it worked

Go to **Extend** (`/admin/modules`) and expand a module's description. You should see a
new **Module Usage Documentation** accordion at the bottom of the description pane,
ready for you to add notes and URLs. See "How to use it" in the [overview](../index.md)
for the full workflow.
