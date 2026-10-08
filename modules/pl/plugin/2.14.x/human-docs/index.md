# Plugin — manual setup guide

**Plugin** (`plugin`) is a developer toolkit that extends Drupal core's plugin
system. It's an API / building‑block module: you install it because another module
depends on it, or because you're building something that needs to work generically
across many plugin types. It doesn't add end‑user features on its own — it gives
developers a richer, more introspectable plugin layer to build on.

It provides four main capabilities. First, a **plugin type registry**: any module
can declare its plugin manager services in a `$module.plugin_type.yml` file, and
Plugin exposes each as a first‑class, discoverable *plugin type* object (with a
label, provider, manager, config schema, and so on). It ships definitions for dozens
of core and contrib plugin types out of the box, so blocks, field widgets and
formatters, conditions, actions, migrate plugins, all the Views plugin types, image
effects, and more are introspectable immediately. Second, **typed plugin
definitions** — a decorator layer so plugin definitions can carry structured metadata
(label, description, category, hierarchy, context) instead of raw arrays. Third, a
**Plugin selector** plugin type with reusable form‑element implementations
(`plugin_radios`, `plugin_select_list`) that any module can use to let users pick and
configure a plugin. And fourth, a **`plugin` field type** (derived per plugin type as
`plugin:<plugin_type_id>`, e.g. `plugin:block` or `plugin:condition`) that lets an
entity store a chosen plugin id plus its configuration as field data, with a
selector widget and label / built‑block formatters.

Plugin also adds an admin **overview** page at **Structure → Plugins**
(`/admin/structure/plugin`) that lists every registered plugin type and its plugins
with detail pages — a handy reference when developing. It provides a permission
(`plugin.overview.view`) to gate that page, ParamConverters for routing to plugin
types/definitions/instances, an event‑based default‑plugin resolver, and a Drush
cache‑clear callback for plugin type definitions. Its only dependency is Drupal
core.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent — the plugin‑type YAML format,
the field type, the selector API, and hooks — read the sibling
[`agent/`](../agent/start.md) docs, which are the better fit for this developer‑
focused module.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

## Where it lives in the admin menu

The read‑only plugin overview lives at **Structure → Plugins**
(`/admin/structure/plugin`), visible to users with the **View plugin overview**
(`plugin.overview.view`) permission. There is no settings form to fill in — the page
simply lists and describes the plugin types registered on your site.

## How to use it

For most sites, "using" Plugin means nothing more than installing and enabling it so
another module's requirement is satisfied. If you're a developer, the value is in its
APIs: browse the registered plugin types at **Structure → Plugins**, declare your own
module's manager with a `*.plugin_type.yml` file, add a `plugin:<type>` field to store
a configurable plugin against an entity, or drop a Plugin selector element into a form
so users can pick and configure a plugin. All of those are code‑level tasks — see the
[`agent/`](../agent/start.md) docs for the concrete APIs and examples.
