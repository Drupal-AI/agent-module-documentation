# Autocomplete Flexible — manual setup guide

**Autocomplete Flexible** (`autocomplete_flexible`) provides a customizable
autocomplete form element and an entity-reference field widget whose behaviour
and rendering can be overridden through a JavaScript plugin. It is aimed at
building tag-style, multi-select typeahead entry: selected items show as a
removable list of friendly labels while the underlying values stay hidden.

For editors, the field widget supports single or multiple (unlimited-cardinality)
selection, shows chosen items as a removable list, and starts suggesting after
you type at least three characters. For developers, there is a reusable
`autocomplete_flexible` form element you can drop into custom forms, plus a hook
to change the label shown for a selected item.

The module itself defines no routes, permissions, or services — it is purely a
field/form building block. Its security posture is inherited from the standard
core entity-reference autocomplete route it wraps, so the usual access checks on
referenced entities apply. There is no settings page.

An optional **examples** submodule (`autocomplete_flexible_examples`) ships a
demo controller, form, and library that show the element and widget in use.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent — including the form-element
properties, the JS plugin options, and the label-alter hook — read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer,
   enable it, and (optionally) the examples submodule.

## Where it lives in the admin menu

Autocomplete Flexible has no central settings page. You use it by selecting its
widget on **Structure → Content types → (your type) → Manage form display** (or
the Manage form display tab of any other fieldable entity). Developers use the
`autocomplete_flexible` form element directly in code.

## How to use it

**As a field widget (no code):**

1. Install and enable the module (see [Installation](installation/index.md)).
2. Go to **Manage form display** for a bundle that has an entity-reference
   field.
3. In the **Widget** column, choose **Autocomplete Flexible**.
4. Click **Save**. Editors now get the flexible autocomplete, including
   single/multiple selection and a removable list of chosen items.

**As a form element (developers):** use `'#type' => 'autocomplete_flexible'` in
a custom form, reusing the standard `#autocomplete_route_name` /
`#autocomplete_route_parameters` plumbing and passing per-instance options via
`#flexible_options`. To change the label shown for a selected entity, implement
`hook_autocomplete_flexible_widget_label()`. See the
[`agent/`](../agent/start.md) docs and the `autocomplete_flexible_examples`
submodule for working code.
