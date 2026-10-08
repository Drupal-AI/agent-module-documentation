# Views Taxonomy radios filter — manual setup guide

**Views Taxonomy radios filter** (`views_taxonomy_radios_filter`) lets you render a
taxonomy-term exposed filter in a view as **radio buttons** (single choice) or
**checkboxes** (multiple choices) instead of the default select dropdown — and lets
you replace the default "- Any -" option with a friendlier label like "All
categories". It's a simple way to build a scannable, tappable, always-visible set
of filter choices without reaching for a facets module.

Under the hood it provides a Views filter plugin,
`taxonomy_index_tid_radios`, that extends core's taxonomy-term filter and adds a
**Radios/Checkboxes** choice to the filter's "form element" (type) option. The
module automatically swaps in this plugin for every `entity_reference` field that
targets `taxonomy_term`, so the new option simply appears wherever such a field is
exposed as a filter — you don't have to change the field. When the exposed filter
allows multiple values it renders as checkboxes; otherwise it renders as radios.
The standard core taxonomy filter behaviour (depth, hierarchy) is preserved — only
the widget changes.

The module has no configuration UI of its own and no permissions — you configure it
per filter in the Views UI. It depends only on core's **Taxonomy** and **Views**
modules. Note that the `1.0.x` version directory is a development/pre-release
snapshot.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

## Where it lives in the admin menu

There is no admin settings page. You configure the filter inside the **Views UI**
(*Structure → Views*, `/admin/structure/views`) when editing an individual view.

## How to use it

1. Edit a view and add (or edit) a **filter** on a taxonomy-term
   `entity_reference` field. Because the module rewrites the filter plugin for
   these fields automatically, the filter already uses `taxonomy_index_tid_radios`.
2. In the filter's options, set the **form element** (the filter "type") to
   **Radios/Checkboxes**.
3. **Expose** the filter — radios and checkboxes only apply to exposed filters.
4. Optionally set the **"'All' value's label"** field (`all_label`) — the text
   shown for the no-selection option. It defaults to `- Any -` / `<Any>` depending
   on your site's Views setting.
5. Save the view.

If the exposed filter allows **multiple** values it renders as checkboxes;
otherwise it renders as radios. This works on any exposed taxonomy-term reference
filter, so you can standardise the presentation across many views. Combine it with
an AJAX view for instant radio/checkbox filtering.
