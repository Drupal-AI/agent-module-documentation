<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Entity Print + TypeSet.sh (entity_print_typeset) — agent index

**A `typeset` HTML-to-PDF print-engine plugin for the Entity Print module, backed by the commercial pure-PHP typeset.sh library.**

- **Version:** 1.0.x (release 1.0.0-alpha2 — experimental / proof-of-concept)
- **Core:** `^10 || ^11`
- **Depends:** `entity_print:entity_print` (Drupal module) + the paid PHP library `typesetsh/typeset.sh` installed via Composer
- **Package:** Entity Print
- **License:** GPL-2.0-or-later

## What it provides

- One plugin only: `Drupal\entity_print_typeset\Plugin\EntityPrint\PrintEngine\Typeset`, annotated `@PrintEngine(id="typeset", label="Typeset.sh", export_type="pdf")`, extending Entity Print's `PdfEngineBase`.
- No routes, no permissions, no services, no hooks, no config objects/schema, no submodules, no Drush commands, no settings form of its own. There is nothing to configure in the module — you pick the *Typeset.sh* engine through Entity Print's own settings/print UI.

## Solution docs

- **The print-engine plugin — install, the paid library, how HTML becomes a PDF, methods** → [plugins/typeset.md](plugins/typeset.md)
