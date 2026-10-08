# Custom Entity Example — manual setup guide

**Custom Entity Example** (`custom_entity_example`) is a **developer reference
module** — an example/starter, not an end‑user feature. It defines a complete,
standards‑compliant custom content entity type (`custom_entity_example`) together
with a config‑entity bundle (`custom_entity_example_type`), wired up with the usual
handlers: storage, list builder, forms, access, canonical routes, permissions, and
templates. The point is to give you a working, correct entity you can read to learn
the pattern, then **copy and rename** as the starting point for your own entity type.

To make the copy‑and‑rename step faster, it ships a code‑generation helper: a Drush
command (and a matching UI clone form) that clones the example into a new module by
search‑replacing the example's names with yours. That generator operates on local
scaffold files only — it reads a file, substitutes names, and writes it back — so it
is a local developer tool, not a web‑facing feature.

Because it's example code, treat it accordingly: it's meant to be studied and
cloned, and you'd typically **remove it after copying** rather than leave the sample
entity enabled in production. It builds on the contrib **Entity API** handlers for
query access and per‑bundle permissions, and targets Drupal 9 and 10.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

## Where it lives in the admin menu

When enabled, you can browse the example entity's collection at its management page
(route `entity.custom_entity_example.collection`) and add fields to the bundle
through the normal field UI, just as with any content entity type.

## How to use it

There are two ways to generate your own entity from the example:

1. **Via the UI** — visit the clone form at
   `admin/content/custom-entity-example-types/clone-form`, make sure the destination
   folder is writable, enter your target module and names, and click **Generate**.
2. **Via Drush** — run the generator command (`cee-ge`), passing the source and
   target names as arguments. For example:

   ```bash
   drush cee-ge 'custom_entity_example' 'we_company' 'custom-entity-example' 'company' \
     'custom_entity_template_example' 'company' 'CustomEntityExample' 'WeCompany' \
     'custom entity example' 'company' 'Custom Entity Example' 'Company'
   ```

   Each argument supplies one form of the name (machine name, path, class name,
   label, and so on) so the generated module comes out consistently renamed.

After generating your own module, enable that instead, add its fields through the
field UI, and (optionally) uninstall the example. The README shipped with the module
documents the argument order and clone process in full.
