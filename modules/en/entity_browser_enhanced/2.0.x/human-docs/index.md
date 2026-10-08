# Enhanced Entity Browser — manual setup guide

**Enhanced Entity Browser** (`entity_browser_enhanced`) adds usability polish to
[Entity Browser](https://www.drupal.org/project/entity_browser), Drupal's tool
for picking existing entities (images, media, nodes) from a searchable grid. It
does not replace Entity Browser — it lets you attach an "enhancer" (a bundle of
extra CSS and JavaScript behaviour) to a browser's **View** widget so the
selection experience feels slicker, especially for image and media browsers.

The module ships two ready-made enhancers:

- **Enhanced Multiselect** — turns the grid into a click-anywhere tile selector:
  the whole thumbnail tile is clickable (no fiddly checkboxes), it respects the
  target field's cardinality so editors cannot pick more items than allowed, it
  disables the "select" button until something is chosen, and a double-click
  picks an item and submits in one gesture.
- **Enhanced Autoselect** — a single click on a row immediately adds that entity
  to the selection.

You choose which enhancer (if any) applies to each View widget of each entity
browser, and the choice is stored as configuration so it deploys between
environments. Developers can also ship their own enhancers from a module or theme
by declaring them in a small YAML file (see the sibling agent docs). The module
has **no settings page, no permissions and no Drush commands** of its own — the
one thing you configure is done right on Entity Browser's own widget
configuration form.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

## Where it lives in the admin menu

The module adds no page of its own. You use it through Entity Browser's existing
admin section at **Configuration → Content authoring → Entity browsers**
(`/admin/config/content/entity_browser`), where a new **Select enhancer**
dropdown appears on each View widget.

## How to use it

Once the module is enabled, assign an enhancer to a browser's View widget:

1. Go to **Configuration → Content authoring → Entity browsers**
   (`/admin/config/content/entity_browser`).
2. **Edit** the entity browser you want to enhance and go to its **Widgets** step.
3. Each **View** widget row now shows a **Select enhancer** dropdown with the
   options *- None -*, *Enhanced Multiselect* and *Enhanced Autoselect*.
4. Pick the enhancer you want and **Save**.

Only *View* widgets get the dropdown — other widget types (such as Upload or
Entity form) are skipped, because the enhancers act on the grid of results a View
produces. After saving, clear caches (`drush cr`) so the new behaviour and styles
are picked up.

A couple of practical tips:

- The **Multiselect** enhancer expects the widget's View to use a **Grid**
  display format, since it makes the grid tiles clickable.
- The **Autoselect** enhancer works together with the View widget's own
  "Automatically submit selection" setting.
- To remove an enhancer later, set the dropdown back to *- None -* and save.

If you use Lightning Media, note that this module automatically removes Lightning
Media's competing browser styling so the enhancers display cleanly.
