# Installation

## Requirements

- **Drupal 11 or 12** (`core_version_requirement: ^11 || ^12`).
- **FlowDrop** (`flowdrop`) and **FlowDrop Node Category** (`flowdrop_node_category`) —
  the workflow engine and its node categorisation support.
- **AI Context** (`ai_context`) — the Context Control Center module that stores the
  context entries this module injects.

There are no extra Composer library or PHP version requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/flowdrop_ai_context -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in the FlowDrop and AI
Context dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/flowdrop_ai_context -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en flowdrop_ai_context -y
```

Drupal will enable the required FlowDrop and AI Context modules as dependencies if they
are not already on.

## Verify it worked

Open a FlowDrop workflow in the FlowDrop editor and confirm the **AI Context** node
processor is available in the node palette. If it is missing, check that `ai_context`
and `flowdrop_node_category` are enabled.
