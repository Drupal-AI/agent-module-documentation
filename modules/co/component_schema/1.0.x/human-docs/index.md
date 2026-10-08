# Component Schema — manual setup guide

**Component Schema** (`component_schema`) provides an API and a schema-based
approach for defining and working with theme-level **components**. Components
declare a schema for their props and slots, which is validated at render, and the
module integrates with the **Style Guide** module so your components appear in a
living styleguide — a visual representation of each component in a given theme,
with documentation of its variables. It is a foundation other projects build on:
the **Bulma Components** module is the fullest example of a module built with
Component Schema integration.

This is a developer and theming framework — it has no content-authoring or
access-control role of its own. It integrates with **UI Patterns** through a
Component Schema UI Patterns submodule, and the maintainers recommend pairing it
with Component Blocks, UI Patterns Field Formatters, and UI Patterns Settings for
a fuller component workflow. It supports Drupal 10.2 and up (including 11 and 12).

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

There is **no configuration page** for this module — it is a developer framework;
components and their schemas are defined in code in your module or theme.

## Where it lives in the admin menu

Component Schema adds no admin settings page. You work with it in code, declaring
each component's schema alongside the component. To *see* your components
rendered, install the **Style Guide** module — Component Schema integrates with
it to display each component and document its variables. Clear the cache
(`drush cr`) after adding or changing component definitions.
