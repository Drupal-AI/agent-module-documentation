# Module Matrix — manual setup guide

**Module Matrix** (`module_matrix`) replaces Drupal's default **Extend** (install) and
**Uninstall** module pages with a modern, filterable interface — a richer alternative
to Module Filter for sites with large module lists. Built with vanilla JavaScript (no
jQuery), it swaps the core tables and `<details>` elements for a flex/grid layout with
accordion‑style module details.

It adds instant client‑side search plus filters that core does not offer: filter by
**status** (enabled, disabled, unavailable), by **lifecycle** (active, deprecated,
experimental, obsolete), and by **stability** (stable, RC, beta, alpha, dev), with a
one‑click reset. Modules are grouped by **package**, with colour‑coded counts (grey
total, green enabled, red disabled). The per‑module details section is fully
customisable — you can toggle up to 14 fields such as machine name, version,
lifecycle, stability, requires/required‑by, project links, subpath, last modified, and
help/permissions/configure links. It also offers three layout modes (packages on the
left, right, or top), a dark mode, six accent‑colour themes, a compact mode, and a
grid layout.

Module Matrix depends only on core's System module, requires **PHP 8.1**, and provides
its own permission for the enhanced interface.

> Enabling and disabling modules is a highly privileged action. As with core's Extend
> page, restrict Module Matrix's permission to trusted administrators.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

The module's settings (layout, theme, and which detail fields to show) are covered
below, folded into this overview.

## Where it lives in the admin menu

- The **enhanced module pages** take over the core **Extend** (`/admin/modules`) and
  **Uninstall** (`/admin/modules/uninstall`) screens once the module is enabled.
- The **settings form** is at the `module_matrix.settings_form` route, where you pick
  the layout mode, accent theme, dark/compact modes, and which of the 14 detail fields
  appear on each module.

## How to use it

1. After enabling (see [Installation](installation/index.md)), open **Extend**
   (`/admin/modules`) — it now renders as the Module Matrix interface.
2. Use the text search and the status/lifecycle/stability filters to narrow the list;
   click **Reset** to clear them.
3. Click a package to jump to its modules; expand a module's accordion to see the
   detail fields you have enabled.
4. Visit the Module Matrix **settings form** to choose your layout (left/right/top),
   accent colour, dark and compact modes, and exactly which detail fields to display.
