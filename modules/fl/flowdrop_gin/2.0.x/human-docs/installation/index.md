# Installation

## Requirements

- **Drupal 11.3** (`core_version_requirement: ^11.3`).
- **FlowDrop UI Components** (`flowdrop_ui_components`) — the FlowDrop UI layer this
  module restyles. Enabled automatically as a dependency.
- The **Gin** admin theme installed and set as your administration theme. Gin is what
  this module integrates with; without it there is nothing to align to.

There are no extra Composer library or PHP version requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/flowdrop_gin -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in the FlowDrop UI
Components dependency as needed. If Gin is not yet installed, add it too:
`composer require drupal/gin -W`.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/flowdrop_gin -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en flowdrop_gin -y
```

Make sure Gin is set as the admin theme (**Appearance → Administration theme**).

## Verify it worked

Open a FlowDrop workflow or dashboard in the admin UI. The FlowDrop components should
now use Gin's accent colours, and switching Gin between light and dark mode should
carry FlowDrop along with it.
