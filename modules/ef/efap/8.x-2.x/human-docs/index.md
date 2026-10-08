# Extra Field API — manual setup guide

**Extra Field API** (`efap`) is a **developer framework** for building "extra
fields". In Drupal, extra fields (also called pseudo-fields) are the display-only
items that appear on an entity's **Manage display** — they render custom output but
store no data of their own. Normally a developer wires them up by hand with
`hook_entity_extra_field_info()` plus `hook_entity_view()`. Extra Field API replaces
that boilerplate with a clean **plugin type**: declare an extra field as a plugin
class, and the module handles registering and rendering it.

It is aimed squarely at module developers and site programmers — there is no user
interface and no settings form. If you are not writing code, there is nothing to
configure here; the value of the module is the API it exposes to other modules.

Because an extra-field plugin renders whatever its code produces, output safety is
the plugin author's responsibility (escape and authorise output as you would in any
render code). Extra Field API itself has no content or access-control role. It has
no dependencies beyond Drupal core and supports Drupal 8 through 11.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

There is **no configuration page** for this module — it has no settings form. You
use it by implementing extra-field plugins in your own module, and the resulting
pseudo-fields appear on the entity's **Manage display**.

## Where it lives in the admin menu

Extra Field API adds no admin page. The extra fields you build with it appear on
**Structure → Content types → (type) → Manage display** (and the Manage display of
other entity types), where a site builder can position them like any other display
component.

## How to use it

1. Install and enable Extra Field API (see Installation).
2. In your own module, implement an extra-field **plugin** using the plugin type
   this module defines, instead of the traditional
   `hook_entity_extra_field_info()` + `hook_entity_view()` pair. Make sure your
   plugin escapes and authorises its output.
3. On the target entity's **Manage display**, position your extra field and save —
   it now renders in that view mode.
