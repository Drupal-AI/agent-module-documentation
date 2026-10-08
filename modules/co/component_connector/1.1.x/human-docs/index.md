# Component Connector — manual setup guide

**Component Connector** (`component_connector`) helps developers wire external
front-end components and layouts into the current Drupal theme. You define and
register component definitions in **YAML files**, and each definition can declare
a theme hook, the CSS/JS libraries the component needs, and the variables and
custom fields passed into its render. The module then takes care of registering
the theme hook and loading the right libraries with their dependencies, so a
design-system component can be rendered through Drupal's normal theme layer.

This is a developer/theming tool: components are authored in code and rendered
through templates, and the module has no content-authoring or access-control role
of its own. It has no other module dependencies.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

## Configuration

There is one small settings page, at **Configuration → System → Components
settings** (`/admin/config/system/component_connector_settings`, permission
*Administer site configuration*). It has a single **Theme** select: choose the
theme whose folder holds your component definitions. The module only scans that
one theme for `*.theme.yml` / `*.suggestion.yml` files. The install default is
the **Claro** admin theme, so in most projects you will point this at your
front-end theme.

## Where it lives in the admin menu

Apart from that one Theme select, you work with Component Connector entirely in
code: declare your component definitions in YAML files inside the configured
theme, add the CSS/JS the components reference (a `name.css` / `name.js` next to
the definition is picked up automatically), and render the components through
your templates. Clearing the cache (`drush cr`) after adding or changing a
definition ensures Drupal picks up the new theme hooks and libraries.
