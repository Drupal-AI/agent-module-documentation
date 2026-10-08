# UIkit Components — manual setup guide

**UIkit Components** (`uikit_components`) is the companion module to the
[UIkit base theme](https://www.drupal.org/project/uikit). A base theme can style
markup, but it cannot easily add new render elements or reshape Drupal's menus
into the markup a component framework expects. This module fills that gap: it
supplies the render elements, Twig helpers and admin configuration that let a
UIkit-based theme render things like navigation, off-canvas menus and dropdowns
as proper UIkit components.

Its main job is menu integration. It depends on core's **Link** and **Menu link
content** modules so that ordinary Drupal menus can be rendered using UIkit's
navigation, off-canvas and dropdown markup — something a theme alone struggles to
do cleanly. It also exposes a documented API (`uikit_components.api.php`) and a
service class that themes and other modules can build against, keeping component
logic in a module rather than scattered through theme preprocess functions.

Because it is a *companion* module, its value depends on you running the UIkit
base theme: the module supplies the components, the theme supplies the CSS and
JavaScript. Enabling it on its own changes very little. The module is also mature
— its `info.yml` still carries a legacy `core: 8.x` line — but it remains
compatible with Drupal 11.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it alongside the UIkit base theme.
2. [Configuration](configuration/index.md) — the admin settings page for the
   module's components.

## Where it lives in the admin menu

UIkit Components adds its own settings page (its `configure` route is
`uikit_components.admin`), reachable from the admin menu with a local task link.
Everything else it provides is used by *theme and module developers* through its
API and render elements rather than through the UI — read
`uikit_components.api.php` in the module before writing theme code against it.
