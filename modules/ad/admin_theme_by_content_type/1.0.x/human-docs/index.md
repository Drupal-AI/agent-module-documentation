# Admin Theme by Content Type — manual setup guide

**Admin Theme by Content Type** (`admin_theme_by_content_type`) lets you decide, **per
content type**, whether the node add/edit forms use the site's admin theme or its
front‑end theme. By default Drupal has a single "use the admin theme when editing
content" switch that applies to everything; this module makes that choice granular, so
one content type's edit form can render in the admin theme while another's uses the
public theme.

That is useful when some content types are best edited in the streamlined admin theme
(for example complex back‑office types) while others benefit from being edited in the
front‑end theme (for example landing pages where you want a closer preview of how
things look). The module depends on core's Node module and affects only the edit‑form
theme — it has no content or access‑control role.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

## Where it lives in the admin menu

The per‑type admin‑theme choice is made on each content type's own settings, under
**Structure → Content types** (`/admin/structure/types`) — edit a content type to find
the option this module adds.

## How to use it

1. Enable the module (see [Installation](installation/index.md)).
2. Go to **Structure → Content types** and edit the content type you want to adjust.
3. Set whether that type's add/edit forms should use the admin theme or the front‑end
   theme, then save.
4. Repeat for any other content types — each type keeps its own setting.
