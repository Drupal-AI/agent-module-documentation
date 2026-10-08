# Entity Preprocess Services — manual setup guide

**Entity Preprocess Services** (`entity_preprocess_services`) is a **developer's
tool**. It lets you preprocess entities (add or change Twig template variables)
from a **service class** using dependency injection, instead of piling logic into
procedural `hook_preprocess_HOOK()` functions in your `.module` file.

Under the hood it adds a service compiler pass and a provider. You write a
preprocess service class, tag it in your module's `*.services.yml`, and declare
which entities it applies to (by entity type, bundle, and/or view mode). The
module then calls the right services when an entity is rendered. Out of the box
it wires this up for **nodes** and **paragraphs**; for any other (or custom)
entity type you call a small helper, `_entity_preprocess_services_preprocess_entity()`,
from that entity's preprocess hook and it does the rest.

Because it is aimed at developers, it **adds no admin UI and no out‑of‑the‑box
end‑user features** — enabling it alone changes nothing visible. The value comes
when you (or another module) register tagged preprocess services. An optional
example submodule, **Entity Preprocess Services Example**
(`entity_preprocess_services_example`), ships a working service definition you can
copy from. It supports a wide core range (Drupal 8.8 through 11) and has no
third‑party dependencies.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable the
   module, and optionally enable the example submodule.

There is **no configuration page** for this module — it is configured entirely in
code (your module's `*.services.yml`), described in "How to use it" below.

## Where it lives in the admin menu

The module adds no admin page. Everything is done in code inside your own custom
module.

## How to use it

1. Create a preprocess service class in your custom module.
2. In your module's `*.services.yml`, tag the service so the module picks it up,
   and declare where it applies:

   ```yaml
   mymodule.preprocess_service.node.full:
     class: Drupal\mymodule\PreprocessService\MyNodeFullPreprocessService
     tags:
       - { name: entity_preprocess_service, priority: 100 }
     properties:
       applies_to:
         - { entity_type: 'node', view_mode: 'full', bundle: 'page' }
   ```

   The `applies_to` entries can use `entity_type`, `bundle`, and `view_mode`, and
   `priority` controls the order services run in.
3. To narrow things down, add an `excludes` list under `properties` — for
   example, preprocess all nodes *except* the `news` bundle.
4. For entity types beyond nodes and paragraphs, implement that entity's
   `hook_preprocess_HOOK()` and call
   `_entity_preprocess_services_preprocess_entity($variables, $entity, $view_mode)`
   so your tagged services fire for it too.

The bundled **Entity Preprocess Services Example** submodule contains a complete
`*.services.yml` and service class you can use as a template.
