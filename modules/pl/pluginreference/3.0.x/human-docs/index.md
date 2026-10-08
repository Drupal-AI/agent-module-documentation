# Plugin Reference — manual setup guide

**Plugin Reference** (`pluginreference`) provides a **"Plugin reference" field
type** that stores a *soft reference to a plugin* — a plugin's string ID rather
than an entity ID. Drupal's entity reference field is the answer whenever content
needs to point at an entity, but plugins are not entities: they are discovered from
code, identified by a string, and have no storage of their own. This module makes
referencing one a proper field, with autocomplete and validation, so content can
point at a block plugin, a condition, a formatter, a queue worker, or any other
plugin type.

The typical goal is to create relationships between entities and plugins so that
background actions can be run against an entity using the selected plugin. Usage is
deliberately straightforward: create a field of type **Plugin reference** on your
entity and configure it the way you would any other field.

For developers, the interesting part is that the module defines its own
**selection‑handler plugin type** (`PluginReferenceSelection`), mirroring how
entity reference lets a field narrow which targets are selectable — so you can write
a selection handler to restrict which plugins a given field may reference. An
autocomplete route backs the widget and is correctly gated by a dedicated
permission (**`pluginreference autocomplete view results`**, marked *restrict
access*), because that endpoint enumerates the plugins available on the site.

One word carries a lot of weight here: **"soft."** The stored value is just a
string, and nothing guarantees the referenced plugin still exists after a module is
uninstalled. Code that consumes the field must handle a missing plugin gracefully
rather than assuming the plugin can always be instantiated.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it alongside core Field.

There is **no central configuration page** for this module — it has no site‑wide
settings form. Setup happens per field, described in "How to use it" below.

## Where it lives in the admin menu

Plugin Reference adds no admin settings page of its own. You use it from
**Structure → Content types → *(your type)* → Manage fields**, where **Plugin
reference** appears as a field type you can add.

## How to use it

1. Go to **Structure → Content types → *(your content type)* → Manage fields** and
   click **Add field**.
2. Choose the **Plugin reference** field type and give it a label.
3. Configure the field as you would any other — including, if a selection handler
   is available, narrowing which plugins it may target.
4. Authors then pick a plugin from an autocomplete when editing content. Your code
   reads the stored plugin ID to run the chosen plugin, remembering to handle the
   case where that plugin no longer exists.

Grant the **`pluginreference autocomplete view results`** permission (at
**People → Permissions**) only to trusted roles, since the autocomplete enumerates
the site's available plugins.
