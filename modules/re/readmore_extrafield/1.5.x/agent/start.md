<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Read More Extra Field (readmore_extrafield) — agent index

Exposes the "Read more" link as an **extra (pseudo) field**, so it can be positioned and
reordered in Manage Display like any real field. Core requirement `^9 || ^10 || ^11`; the
only dependency is core `field`.

## What this 1.x line is

- **Lightweight, node-only, zero-config.** The whole module is
  `readmore_extrafield.module` + `templates/readmore-extrafield.html.twig` + `.info.yml` +
  `LICENSE.txt`. No `src/`, no routes, no permissions, no config entities, no config schema,
  no JS, no CSS/libraries, no Drush.
- Built entirely from **hooks in the `.module` file** (not the plugin/`extra_field`
  architecture the 3.x line uses — 3.x is a rewrite with per-view-mode settings). If you need
  a configurable label, CSS classes, or link attributes, that is 3.x, not this version.
- `.info.yml` reports the legacy `version: '8.x-1.5'`.

## How it works (real machine names)

- `readmore_extrafield_entity_extra_field_info()` — registers the **display** extra field
  `extra_field_readmore_extrafield` for **every node bundle only**
  (`NodeType::loadMultiple()`), label "Read more", `weight: 100`. It is **off by default**;
  you turn it on per view mode in Manage Display (it exports in the
  `core.entity_view_display.node.*` config).
- `readmore_extrafield_node_view()` — when that display component is enabled, builds a
  `#theme => 'readmore_extrafield'` render array. The link is **hardcoded**: title `t('Read
  more')`, URL `Url::fromRoute('entity.node.canonical', …)` (the host node), anchor class
  `read-more`, wrapper class `readmore-extrafield`. Nothing here is configurable in 1.x.
- **Display-only.** It never touches the node, its access, or core's own "Read more" node
  link — both can appear at once if the display is configured that way. The link just points
  at the node's canonical URL, so normal node access applies when it is followed.

## What you'd do → where

- **Override the template / use theme suggestions / understand the render variables** →
  [theming/template.md](theming/template.md)
- Enabling/placing the field itself is just Manage Display (drag the "Read more" row out of
  *Disabled* for the view mode); it needs no admin form, so there is no `configure` doc.
