# Installation

## Requirements

- **Drupal 9.3, 10, or 11** (`core_version_requirement: ^9.3 || ^10 || ^11`).
- **Hook Event Dispatcher** (`hook_event_dispatcher`) — provides the event system
  this module plugs into.
- **Inline Entity Form** (`inline_entity_form`) — the module whose hooks are being
  re‑exposed as events.

Both required modules are contributed projects. Installing with Composer (below)
pulls them in automatically.

## Install with Composer

From the project root:

```bash
composer require drupal/inline_entity_form_event_dispatcher -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer fetch and update the
`hook_event_dispatcher` and `inline_entity_form` dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/inline_entity_form_event_dispatcher -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

Enable it along with its dependencies (Drush will enable required modules
automatically):

```bash
drush en inline_entity_form_event_dispatcher -y
```

## Verify it worked

Confirm all three modules are enabled:

```bash
drush pm:list --status=enabled | grep -E 'inline_entity_form|hook_event_dispatcher'
```

You should see `inline_entity_form_event_dispatcher`, `inline_entity_form`, and
`hook_event_dispatcher` listed. From here the work is in code: add an
`event_subscriber` service in your custom module that listens for the Inline
Entity Form events this module dispatches.
