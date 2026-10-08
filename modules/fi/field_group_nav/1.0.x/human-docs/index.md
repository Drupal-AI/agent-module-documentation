# Field group nav — manual setup guide

**Field group nav** (`field_group_nav`) adds a **`<nav>` field‑group format** to
the [Field Group](https://www.drupal.org/project/field_group) module, so a group
of fields can be wrapped in a semantic HTML `<nav>` element instead of a generic
`<div>`. It's a small, markup‑focused enhancement aimed at improving the
semantics and accessibility of navigation‑like field groups.

Beyond the plain nav wrapper, the module provides a **Nav item** field‑group
formatter that generates in‑page navigation links: each Nav item group you
create becomes one entry in a set of navigation links pointing at content within
the current document. That makes it handy for building a small "on this page"
style menu out of your field groups.

The module affects rendered markup only — it has no content model or access
control role — and depends solely on the Field Group module.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module and its Field Group dependency.

There is **no configuration page** for this module — it has no settings form.
Everything is set up on your entity's *Manage display*, described in "How to use
it" below.

## Where it lives in the admin menu

Field group nav adds no admin page. You use it from **Structure → Content types
(or any fieldable entity) → *(bundle)* → Manage display**, where its formats
appear in the field group format list.

## How to use it

1. Go to the display you want to edit and click **Manage display**.
2. Click **Add group** and choose the **Nav item** format (or the plain `<nav>`
   format for a simple semantic wrapper).
3. Move the fields you want inside the new field group.
4. Enable **Field group navigation** for the display.
5. Save the display.

Each Nav item group then contributes one navigation link, wrapping the grouped
content in a semantic `<nav>` element on output.
