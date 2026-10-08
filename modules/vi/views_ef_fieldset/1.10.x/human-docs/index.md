# Views Exposed Form Fieldset — manual setup guide

**Views Exposed Form Fieldset** (`views_ef_fieldset`) lets you tidy up a view's
**exposed form** — the filters, sort controls, and Submit/Reset buttons that
visitors interact with — by grouping them into nested containers. Instead of a
long, flat row of exposed filters, you can arrange them into HTML **fieldsets**
(collapsible `details`), plain **containers**, or **vertical tabs**, each with its
own title and description, all built with a simple drag-and-drop table inside the
Views UI.

This is the easy way to build a polished, faceted-style search or a compact
mobile filter panel using nothing but core Views. Common uses: tuck advanced or
rarely used filters inside a collapsed fieldset, split "keyword" and "date range"
filters into separate groups, move the Submit and Reset buttons into a specific
container, or use vertical tabs to save vertical space on a data-heavy report. You
can even nest a fieldset inside a fieldset, and apply different groupings to
different displays (page vs block) of the same view.

The module works by adding a Views **display-extender** plugin, which it enables
for every view on install. All of your grouping is stored in the view's own
configuration, so it exports and deploys along with the rest of your view — and it
only rearranges the *live* exposed form; the view's results are untouched. There
is **no admin settings page**; everything is configured per view, per display,
through the standard Views UI.

This guide is written for a **human** building a view. If you want terse,
token-cheap references for an AI coding agent — the config tree structure and the
render mechanism — read the sibling [`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

Configuration happens inside the Views UI rather than on a settings page, so it is
described below rather than on a separate page.

## Where it lives in the admin menu

There is no dedicated settings page. You configure the grouping while editing a
view at **Structure → Views** (`/admin/structure/views`), in the display's
**Exposed form** settings.

## How to use it

1. Enable the module. Its display extender is switched on for all views
   automatically.
2. Go to **Structure → Views** (`/admin/structure/views`) and edit a view that has
   **exposed** filters (the filter criteria you have marked "Expose this filter to
   visitors").
3. In the display, open the **Exposed form** section (click the current "Exposed
   form style" or "Settings" link there).
4. Tick **"Enable fieldset around exposed forms?"**. A drag-and-drop table appears
   listing every exposed element — each filter (and its operator), the exposed
   Sort by / Sort order controls if you have them, and the Submit and Reset
   buttons.
5. **Build your groups.** Add containers and, for each one, choose its type —
   **Container** (a plain `<div>`), **Fieldset** (a collapsible `details` element),
   or **Vertical tabs** — and give it a title, an optional description, and whether
   it starts open or collapsed. Then drag each filter, sort, or button underneath
   the container you want it in, and reorder or nest as needed.
6. **Apply, then Save the view.**

The exposed form now renders with your grouping. Because the layout lives in the
view's configuration, it exports with the view and deploys across environments.
You can style the groups with the module's `views-ef-fieldset-container` CSS
classes if you want to go further.
