# Entity Bundle Scaffold — manual setup guide

**Entity Bundle Scaffold** (`entity_bundle_scaffold`) is a developer tool that
removes the repetitive, click-through work of defining content structures and
hand-writing bundle classes. It gives you a set of **Drush commands** for creating
entity types and bundles — node types, taxonomy vocabularies, Paragraphs types, and
ECK entity types/bundles — plus **code generators** that produce entity bundle
class files (complete with typed field getters) and controller classes for the
`wmcontroller` pattern.

Under the hood the generators are built on the `nikic/php-parser` library and a
pluggable `EntityBundleClassMethodGenerator` plugin type, with implementations for
all the common field types (string, integer, datetime, entity reference, link,
address, office hours, list/enum, computed, and more). You can extend generation
with your own plugins, or swap a generator via an alter hook.

This is a development-time tool, not a runtime feature: it exposes no routes, no
permissions, and no web-facing endpoints, and it writes generated PHP files into a
module's source tree on disk. Its behavior — target namespaces, base classes, which
module receives generated files, and whether bundle classes are regenerated
automatically when a bundle or field changes — is driven by the
`entity_bundle_scaffold.settings` configuration object. It requires **Drupal 10 or
11** and **PHP 7.4+**.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable the
   module, and get to know its Drush commands.

There is **no admin settings form** for this module. Its behavior is controlled by
the `entity_bundle_scaffold.settings` configuration object, edited through
configuration management (a config YAML file or `drush config:set`), described in
"How it is configured" below.

## Where it lives

Entity Bundle Scaffold adds no admin menu item. You work with it entirely from the
command line via Drush, and its behavior is tuned through configuration rather than
a settings page.

## How to use it

The typical workflow is:

1. Install and enable the module (see [Installation](installation/index.md)).
2. Adjust `entity_bundle_scaffold.settings` for your project (output module,
   namespace pattern, base classes — see below).
3. Run the Drush commands to create entity types/bundles or to generate bundle
   classes and controllers. Run any command with `-h` / `--help` for its full
   arguments, options, and aliases.

Key commands include `nodetype:create`, `vocabulary:create`,
`paragraphs:type:create`, `eck:type:create`, `eck:bundle:create`,
`eck:bundle:delete`, `entity:bundle-class-generate`, and `wmcontroller:generate`.
The full list is in [Installation](installation/index.md).

## How it is configured

The `entity_bundle_scaffold.settings` object drives generation. Its main keys are:

- **`generators.bundle_class`** — controls bundle-class generation: `base_classes`,
  `fields_to_ignore` (fields to skip when building getters), `output_module` (which
  module receives the generated files), `field_getter_name_source` (derive getter
  names from the field name or the field label), `namespace_pattern`, and the
  `auto_create` / `auto_update` toggles.
- **`generators.controller`** — controls controller generation: `base_class`,
  `output_module`, `namespace_pattern`, and `auto_create`.

When `auto_create` / `auto_update` are enabled, the module's entity-insert hook
regenerates bundle classes and controllers automatically when a bundle or field
config is created (this is skipped during configuration sync).
