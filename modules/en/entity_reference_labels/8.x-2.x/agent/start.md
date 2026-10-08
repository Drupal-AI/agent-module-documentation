<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Entity Reference Labels (entity_reference_labels) — agent index

Registers an alternative **entity-reference selection handler** ("reference method") named
**Default (Descriptive)** that makes an edit form's autocomplete/select options show each candidate's
label **plus** its id, bundle and language — e.g. `Sidebar - (12 | block | en)` — to disambiguate
same-named entities. It affects **selection in edit forms only**, not how a saved reference is displayed.

- Version dir **8.x-2.x** (installed release `8.x-2.2`). Core `^8.8 || ^9 || ^10 || ^11`. License GPL-2.0-or-later.
- **No dependencies** beyond core, **no permissions**, **no routes**, **no services**, **no hooks**,
  **no config schema / settings form**, no `.module`/`.install`, no submodules, no libraries.
- Package: none declared. Maintainer: George Anderson (geoanders).

## What it provides

- One selection-plugin group **`default_descriptive`** built from a deriver, so a derivative exists for
  **every** entity type (id `default_descriptive:<entity_type_id>`).
- Two plugin classes and one deriver, all under `src/Plugin/`:
  - `EntityReferenceSelection/DefaultDescriptiveSelection` (extends core `DefaultSelection`).
  - `EntityReferenceSelection/PhpDescriptiveSelection` (extends `DefaultDescriptiveSelection`).
  - `Derivative/DefaultDescriptiveSelectionDeriver` (extends core `DefaultSelectionDeriver`).

## Solution docs

- **The selection plugins, the deriver, the descriptive-label format, escaping, and how to enable it** →
  [plugins/selection.md](plugins/selection.md)

## Operate it

Install/enable the module, then on an entity-reference field's settings page choose **Default (Descriptive)**
as the *reference method* and use an autocomplete (or select) widget on the bundle's form display. No further
configuration exists.
