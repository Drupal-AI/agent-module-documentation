# Configuration

There is no admin settings page. You configure Bootstrap Quicktabs by editing a
**Quicktabs instance** and choosing one of its two Bootstrap renderers.

## Set it up

1. Go to **Structure → Quicktabs** (`/admin/structure/quicktabs`) and add or edit
   a Quicktabs instance.
2. Add your tabs (each tab can be a block, node, view, and so on) as usual.
3. In the instance's **Renderer** setting, choose **bootstrap tabs** or
   **bootstrap accordion**.
4. Configure the renderer's options (below) and save.

## bootstrap tabs

Renders the instance as Bootstrap nav‑tabs or pills. Its options:

| Option | Choices | Effect |
|---|---|---|
| **Tab style** | Tabs *(default)*, Pills | Uses the Bootstrap `nav-tabs` or `nav-pills` styling. |
| **Tab position** | Basic (top, default), Left, Right, Below, Justified, Stacked | Positions the tab strip around the content, or spreads it full‑width (Justified) or vertically (Stacked). |
| **Fade effect** | On / off | Adds a Bootstrap fade transition when switching tabs. |

It also honours the Quicktabs instance's own settings: the **default/active tab**
you choose, **Ajax** mode (only the default tab is rendered up front, and the
others load on demand with a "Loading content…" placeholder), and **hide empty
tabs** (tabs whose content renders empty are skipped).

## bootstrap accordion

Renders each tab as a Bootstrap collapsible panel (a `panel-group`). It has **no
options form** — every tab becomes a panel, the default/active tab's panel starts
open, and "hide empty tabs" is honoured. Each panel's title comes from its tab
title.

## Theming (override the markup)

The module registers theme hooks with matching Twig templates you can override in
your own theme:

- `bootstrap_tabs` → `templates/bootstrap-tabs.html.twig`
- `bootstrap_tabs_tabs` → `templates/bootstrap-tabs-tabs.html.twig`
- `bootstrap_accordion` → `templates/bootstrap-accordion.html.twig`

Copy any of these into your theme to change the emitted Bootstrap markup. Bear in
mind the markup is Bootstrap 3 flavoured, so a Bootstrap‑3‑compatible theme (with
the tab/collapse JavaScript) is expected to make the tabs actually switch and
collapse.
