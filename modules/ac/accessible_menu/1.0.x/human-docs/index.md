# Accessible Menu — manual setup guide

**Accessible Menu** (`accessible_menu`) provides a JavaScript library that helps
make Drupal menus WCAG-compliant. It adds proper keyboard navigation, ARIA
attributes and focus handling to menus so that keyboard and screen-reader users can
open submenus, move between items, and understand the menu structure the same way a
mouse user can.

It builds on Drupal's core **Menu UI** module and applies its accessible behaviour
to your site navigation. It is a front-end accessibility enhancement — it changes
how menu markup behaves in the browser and has no content or access-control role of
its own.

The project also ships an optional submodule, **Accessible Menu Bootstrap 5**
(`accessible_menu_bootstrap_5`), for sites built on a Bootstrap 5 theme. Enable it
only if your theme uses Bootstrap 5 (see [Installation](installation/index.md)).

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer, enable
   it, and add the Bootstrap 5 submodule if you need it.

## How to use it

Enable the module and its accessible-menu JavaScript becomes available to apply to
your menus. If your theme is based on Bootstrap 5, also enable the
`accessible_menu_bootstrap_5` submodule so the accessible behaviour matches the
Bootstrap 5 menu markup.
