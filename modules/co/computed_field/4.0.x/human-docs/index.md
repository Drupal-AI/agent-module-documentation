# Computed Field — manual setup guide

**Computed Field** (`computed_field`) lets you add **read‑only fields whose value is
calculated on the fly** instead of being typed in and stored in the database. A computed
field borrows a normal core field type (string, integer, entity reference, date, …) and
gets its value from a small piece of code called a *computed field plugin*. Because it
reuses core field types, its output displays through the same formatters as any ordinary
field — you position it in **Manage display** and theme it like everything else.

Typical uses are things like showing a live count of related items, concatenating a full
name from separate first/last fields, deriving a price or total from other fields, or —
using the one ready‑made plugin the module ships, `reverse_entity_reference` — listing all
the entities that point *at* the current one (a "backlinks" or "related content" field)
without building a View. The value is recomputed every time the entity is viewed, so it is
always current.

There are two ways a computed field gets attached. Developers can write a plugin that
**attaches itself automatically** to chosen entity types/bundles (no clicking required), or
a site builder can **add one through the Field UI** — but only if the optional **Computed
Field UI** submodule (`computed_field_ui`) is enabled, which adds an "Add computed field"
action to the *Manage fields* screen. The base module depends only on core's **Field**
module and works on Drupal 10.2+ / 11. It adds one permission, *Administer computed_field
entities*, which gates creating and editing these fields.

This guide is written for a **human** setting the module up through the UI and code. If you
want terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead — they cover writing your own plugin,
cacheability, and the programmatic API in depth.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable the module, and
   turn on the Computed Field UI submodule if you want the point‑and‑click flow.

## Where it lives in the admin menu

Computed Field has **no settings page of its own** (its `configure` route is unset). Its
one real UI touch‑point comes from the **Computed Field UI** submodule, which adds an **Add
computed field** button to a bundle's field list at **Structure → Content types →
*your type* → Manage fields** (and the equivalent for other entity types). The permission
that guards it, *Administer computed_field entities*, is set at **People → Permissions**.

## How to use it

Once the module (and, for the click path, the **Computed Field UI** submodule) is enabled:

1. Go to a bundle's **Manage fields** screen, e.g. **Structure → Content types → Article →
   Manage fields**.
2. Click **Add computed field**, choose one of the available computed field plugins, give
   the field a label, and — if the plugin is configurable — fill in its options. The
   bundled `reverse_entity_reference` plugin, for example, asks which reference field to
   walk backwards, so the new field lists every entity whose that field points at the
   current one.
3. Save. The field now appears on the bundle. Because it is read‑only there is **no widget**
   on the edit form and **no stored data** — instead, arrange where it shows under **Manage
   display** and pick a formatter, exactly as you would for a normal field.

Fields you add this way are stored as exportable configuration, so they move between
environments with your normal config sync.

For anything beyond the bundled plugin — computing a full name, a count, a value from a
remote service, a per‑user value with custom caching — a developer writes a computed field
plugin in code. That is a developer task rather than a UI one; the
[`agent/`](../agent/start.md) docs walk through the plugin attribute, the `computeValue()`
method, the two attach modes, and cacheability.
