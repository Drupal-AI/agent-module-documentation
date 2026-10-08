# Bootstrap Icons — manual setup guide

**Bootstrap Icons** (`bootstrap_icons`) makes the open-source
[Bootstrap Icons](https://icons.getbootstrap.com/) library available inside
Drupal as an **icon pack**. It plugs into Drupal core's Icon API (introduced in
Drupal 11.1), so anywhere the site or a theme can pick an icon, Bootstrap's set of
SVG icons shows up as a choice.

There is nothing to configure. The module registers the icon pack; the icons
themselves are static SVG assets. It has no content role and no access role — it
simply extends the palette of icons the Icon API can offer.

This is the module you want when a theme, component, or another module asks you to
"choose an icon" and you would like Bootstrap's icons in that picker.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

## Where it lives in the admin menu

Bootstrap Icons adds no menu item and no settings page. Once enabled, the icons
appear wherever Drupal's Icon API offers an icon picker — for example in themes or
modules that let you select an icon for a link, menu item, or component.

## How to use it

1. Install and enable the module on a **Drupal 11.1+** site (see
   [Installation](installation/index.md)).
2. Open any icon picker provided by your theme or another module.
3. The **Bootstrap Icons** pack is now one of the available icon sets — pick an
   icon from it as you would from any other pack.
