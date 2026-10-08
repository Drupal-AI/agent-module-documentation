# Site Studio Per Component Library — manual setup guide

**Site Studio Per Component Library** (`site_studio_per_component_libs`) is a
small, behind‑the‑scenes helper for sites built with Acquia Site Studio
(Cohesion). It watches which Site Studio components actually appear on a node and
automatically attaches a theme library named after each component — so a
component's CSS and JavaScript only load on pages where that component is
present, instead of loading globally on every page.

The problem it solves is asset bloat. Site Studio lets you build lots of
reusable components, but their styles and scripts often end up loaded site‑wide
whether they are used or not. This module lets you keep your front‑end payloads
lean and component‑scoped: name a library after a component's machine name (UID)
in your theme, and the module wires it up for you.

It works entirely on enable — there is **no configuration UI and no
permissions**. Once the module is on, it inspects each node's Site Studio canvas
fields, collects the component UIDs (including nested child components), and for
every UID that matches a `{theme}/{uid}` library in your active theme (or its
base theme) it attaches that library. The one thing you must do yourself is
define those libraries in your theme's `*.libraries.yml`, named exactly after the
component machine names. It depends on the Acquia Site Studio module
(`cohesion`), which is Acquia's commercial product, so this module is only useful
on a site that already runs that stack.

This guide is written for a **human** setting the module up. If you want terse,
token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable the
   module, and define your per‑component theme libraries.

## How to use it

There is no settings page. After you enable the module, the workflow lives
entirely in your theme:

1. In your active theme (and/or its base theme), open the theme's
   `*.libraries.yml` file.
2. Define a library whose name matches each Site Studio component's machine name
   (UID) you want to enhance — for example a component `cpt_hero` gets a library
   `cpt_hero` pointing at its own CSS/JS files.
3. Build or edit a node that uses that component. On page render, the module
   walks the node's Site Studio canvas, finds the component, and attaches the
   matching library automatically.

Components that have no matching theme library are simply skipped, so you only
create libraries for the components you actually want to scope.
