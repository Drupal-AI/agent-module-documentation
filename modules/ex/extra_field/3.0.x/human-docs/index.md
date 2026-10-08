# Extra Field — manual setup guide

**Extra Field** (`extra_field`) is a developer's module that turns Drupal's
"pseudo‑field" mechanism into two clean, discoverable **plugin types**. It lets a
module drop a PHP class into a folder and immediately get a draggable, weightable
"field" on an entity's **Manage display** or **Manage form display** page — a field
that looks and behaves like a real field but stores no data. Think of it as the
tidy, testable replacement for hand‑writing `hook_entity_extra_field_info()` plus a
pile of preprocess functions.

A classic use is rendering computed or derived output as something a site builder
can position: a "related content" list, a computed price or stock line, a "last
updated by X on Y" line, a share widget, a QR code, or the result of an external API
lookup — all placed and reordered right alongside the entity's real fields in
*Manage display*. The form‑side plugin type does the equivalent for entity **forms**:
add a custom submit button, a disclaimer, a not‑stored confirmation checkbox, or
extra validation, positioned with the other form elements.

Extra Field provides two plugin managers — one for **display** plugins and one for
**form** plugins — plus three base classes that handle the common cases (raw output,
output wrapped in a proper field template with a label, and form elements). A plugin
declares which entity bundles it applies to, using `entity_type.bundle`,
`entity_type.*` (every bundle of a type) or `*.*` (every content entity type). Both
plugin sets can be extended by other modules through alter hooks, and the project
ships Drush code generators plus an `extra_field_example` submodule full of
ready‑to‑copy plugins.

The module has **no settings form, no configuration page and no permissions** — the
only persistent state is the extra field you enable and position on a display, which
is stored in that display's normal configuration. It provides Drush code generators,
supports Drupal 10.2 and 11, and depends only on core's **Field** module.

This guide is written for a **human** installing the module and understanding what
it is for. If you are an AI coding agent — or a developer who wants the exact
attribute keys, base classes, machine‑name rules and alter hooks — read the sibling
[`agent/`](../agent/start.md) docs instead, which are the real "how to write a
plugin" reference.

## Contents

1. [Installation](installation/index.md) — install the module with Composer, enable
   it, and optionally enable the example submodule.

## Where it lives in the admin menu

Extra Field adds no admin page of its own. Once a module (yours or the bundled
example) provides an extra‑field plugin, that field appears as a positionable row on
the relevant entity's **Manage display** (*Structure → Content types → … → Manage
display*) or **Manage form display** page, where you drag it into place and can hide
it per view mode.

## How to use it

Extra Field is used by writing plugins in code — there is nothing to click to
"configure" the module itself. In outline:

1. Enable the module (see [Installation](installation/index.md)). To see it working
   immediately with ready‑made examples, enable the **Extra Field Example**
   submodule.
2. In your own module, create a class under `src/Plugin/ExtraField/Display/` (for a
   display field) or `src/Plugin/ExtraField/Form/` (for a form element), give it an
   `ExtraFieldDisplay` / `ExtraFieldForm` attribute with an `id`, `label` and a
   `bundles` list, and extend one of the provided base classes.
3. Rebuild caches. The field now appears on the matching entity's *Manage display* /
   *Manage form display* page as `extra_field_<your_plugin_id>` — drag it where you
   want it, and it renders in that position.
4. In Twig you can also print it explicitly with
   `{{ content.extra_field_<plugin_id> }}`.

The bundled Drush generators can scaffold these plugin classes for you. The full
plugin API — attribute keys, the three base classes, the `bundles` wildcards, the
alter hooks and the generator commands — is documented in the
[`agent/`](../agent/start.md) reference.
