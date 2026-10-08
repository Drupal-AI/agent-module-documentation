# Client-side Hierarchical Select — manual setup guide

**Client-side Hierarchical Select** (`cshs`) gives editors a compact drill-down
widget for choosing taxonomy terms. Instead of one giant flat select listing every
term, it shows one dropdown per hierarchy level and reveals the next level as you
choose a parent — so picking a deep term (category → subcategory → item) stays
fast and tidy, entirely in the browser with no per-level page reloads.

Under the hood it provides a reusable form element (`cshs`) plus a field widget
(id `cshs`) for entity reference fields that point at a taxonomy vocabulary. Widget
settings let you save the full lineage of the selection rather than just the leaf,
force editors to pick the deepest level, restrict the tree to a chosen parent
branch, and give each level its own label ("Region", "Country", "City"). For
display it ships four field formatters — full hierarchy, flexible hierarchy,
group-by-root, and a specific-taxonomy-level formatter — so a chosen term can be
rendered with or without its ancestor path.

It also provides Views filter plugins (including a depth-aware term filter) for
building faceted term filters, a Conditional Fields handler, and Twig templates for
full theming control. It depends only on core **Field** and **Taxonomy**. A
companion submodule, **CSHS Menu Link** (`cshs_menu_link`), brings the same
hierarchical picker to the parent-menu-item selector on node and term forms.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer,
   enable it, and pick up the menu-link submodule if you need it.

## Where it lives in the admin menu

CSHS has no central settings page. You turn it on per field:

- **The widget** is chosen on **Structure → Content types → *(type)* → Manage form
  display** — set a taxonomy entity reference field's widget to
  **Client-side Hierarchical Select**, then click its gear icon to configure it.
- **The formatters** are chosen on the matching **Manage display** page for the
  same field.
- **The Views filters** appear when you add an exposed filter on a supported term
  field inside a view.

## How to use it

1. Enable the module (see [Installation](installation/index.md)).
2. On a content type that has a taxonomy term reference field, go to **Manage form
   display**, switch that field's widget to **Client-side Hierarchical Select**,
   and open its settings with the gear icon.
3. In the widget settings, decide whether to **save the full lineage** of the
   choice, whether to **force selection of the deepest level**, whether to
   **restrict the tree to a parent term**, and set **custom labels per level** if
   you want them.
4. On **Manage display**, pick one of the four CSHS formatters to control how the
   chosen term renders — with its full ancestor path, grouped by root, at a
   specific level, or via the flexible formatter that adapts to depth.
5. For hierarchical filtering on listings, add the CSHS Views filter to an exposed
   filter and use its depth awareness to let visitors drill down.
