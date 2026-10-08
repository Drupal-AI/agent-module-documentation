<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Trucie — creating an importer and running an import

**Create:** `/admin/structure/trucie-importer/add`.
- **Entity type / bundle** — target of the import; set bundle to *Read from source file* (`_get_from_source`) to take the bundle from a column.
- **Mode** — `create` or `create_update`.
- **CSV settings** (csv only) — delimiter (default `;`) and enclosure (default `"`).
- **Processors → global** — set the **Unique** field (machine name used to match existing entities, e.g. `title`, `uuid`, `nid`) and optional global `trim`.
- **Processors → field** — per column, chain processors (e.g. `field_tags`: `explode` on `|` → `trim` → `entity_lookup` taxonomy_term by `name`).

**Source file rules:** first row = header of entity field machine names; extra non-entity helper columns should start with `#`. For formatted text use `body__value` + `body__format` columns (else `body` alone).

**Run:** open the importer and upload the file; a Batch API run creates/updates entities. Related entities (e.g. referenced terms) are not auto-created — import them first.

**Available processors** (`TrucieImporterProcessor::getProcessorTypes`): date (p1=format), explode (p1=sep), floatval (p1=precision), implode (p1=sep), intval, mb_strtolower, mb_strtoupper, preg_replace (p1=pattern,p2=replacement), strtotime, trim (p1=chars), ucfirst, entity_lookup (p1=entity type, p2=lookup field).

**Programmatic:** `\Drupal::service('trucie.factory.importer')->createImporter($filePath, $ext)` then `setImportParams($params)->setProcessors(...)->setSource(...)->initBatch()->setBatch()`. Params support `is_dry_run`, `defaults` (used when a cell is empty) and `overrides` (forced values — use to prevent malicious `uid`/`status`/`uuid`).
