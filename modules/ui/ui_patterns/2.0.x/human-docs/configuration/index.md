# Configuration

UI Patterns has no central settings page. "Configuring" it means two things:
choosing **where** components appear (by enabling the delivery submodules) and,
each time you use a component, filling its **props and slots** from Sources. This
page covers both.

## Where components surface (the submodules)

Each submodule plugs components into a different Drupal surface. Enable the ones
you need (see [Installation](../installation/index.md)) and you'll find components
offered in the matching admin screen:

- **Field formatters** (`ui_patterns_field_formatters`) — on a bundle's **Manage
  display** page, set a field's **Format** to a component. There are two
  formatters: one renders the whole field as a single component, the other renders
  each field item as its own component. These apply to **all** field types.
- **Blocks** (`ui_patterns_blocks`) — in **Block layout** (or the Layout Builder
  "Add block" chooser), place a component as a block in a region.
- **Layouts** (`ui_patterns_layouts`) — pick a component as a section layout in
  Layout Builder or Display Suite; the component's slots become the layout's
  regions.
- **Views** (`ui_patterns_views`) — choose a component as the row or style plugin
  of a View.
- **Field** (`ui_patterns_field`) — give editors a widget to pick and fill a
  component stored directly in a field value.
- **Library** (`ui_patterns_library`) — browse and preview all available
  components (not a placement surface, but useful for discovery).

## Configuring a component: props and slots

Wherever you use a component, the form is generated from that component's
`*.component.yml` schema and lets you set two kinds of things:

- **Props** — typed, single-value inputs (a string, a number, an enum "variant",
  an attributes object, and so on). Each prop takes **one** Source.
- **Slots** — content regions that can hold rendered markup. Each slot takes a
  **list** of Sources, so you can stack, say, some static text plus a nested
  component plus a token in one slot.

Many components also expose a **variant** (an enum prop) that switches the
component's overall style — you'll usually see it as a dropdown at the top of the
form.

## Sources: where each value comes from

The value for every prop and slot is supplied by a **Source plugin**, and the
form only offers Sources compatible with that prop's type. Common Sources include:

- **Textfield** — static text you type in.
- **Token** — a value from a token like `[node:title]`.
- **Number**, **Checkbox(es)**, **Select(s)** — simple typed inputs.
- **Entity field** — a value pulled from an entity's field (these are derived per
  field and keep cacheability metadata intact).
- **Entity reference**, **Entity link**, **Field label** — related-entity values.
- **Menu**, **Breadcrumb**, **Path**, **URL** — site navigation and routing
  values.
- **Attributes** / **Class attribute** — drive a component's HTML wrapper
  attributes or classes.
- **Component** — nest another component inside a slot.
- **WYSIWYG**, **Block**, **List textarea** — richer content sources.

So the same component can be static in one place (textfield Sources) and
data-driven in another (entity-field or token Sources), which is what makes one
component set reusable across blocks, fields, layouts, and Views.

## For developers: config shape and custom Sources

Everywhere a component is configured — block settings, field-formatter settings,
layout settings, Views style — the configuration is stored under the same
`ui_patterns` array, holding the `component_id`, an optional `variant_id`, a
`props` map (one Source each), and a `slots` map (a list of Sources each). For the
exact config structure, how to set a component from code, the full Source-plugin
list, and how to write your own Source, PropType, or PropTypeAdapter plugin, see
the sibling agent docs:
[`agent/configure/components.md`](../agent/configure/components.md) and
[`agent/plugins/plugin-types.md`](../agent/plugins/plugin-types.md).
