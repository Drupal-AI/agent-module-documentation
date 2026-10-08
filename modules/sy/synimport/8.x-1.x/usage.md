<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
SynImport bulk-imports and exports Drupal content between a site and a directory of structured YAML files, driven entirely from Drush.
---
The module solves site-to-site content migration for Synapse-built sites: `drush synexport <dir> <status>` walks nodes, commerce products, taxonomy terms and blocks and writes one YAML file per entity (with attached images/files copied into `<dir>/files`), and `drush synimport <dir>` reads that structure back and recreates the entities. Field values may be typed (`image`, `media`, `attach`, `taxonomy`, `paragraph`, `variations`, `attribute`) or plain; unknown types fall back to text. It does NOT verify that the target bundles/fields exist — they must be created on the destination site first.

Operationally the whole surface is CLI-only: there are no routes, no permissions and no forms, so it is reachable only by an operator with shell/Drush access. Two code paths reach the network when importing: `src/Service/Import/Files.php` fetches any field value beginning with `http` via `@file_get_contents()` (used for remote image/attachment URLs found in the YAML), and `src/Service/Import/Redis.php` pulls visit-card/brief data from the hardcoded hosts `app.biz-panel.com` / `biz-panel.com`, authenticating with a token derived from a hardcoded salt plus the ISO week number. Imported media/files are saved into `public://import/`. Because import sources come from operator-supplied files, treat those files as trusted input.
---
- Export an entire site's content to a directory: `drush synexport <dir> <status>`.
- Export only nodes of a given type: `drush synexport:node <dir> <type> <status>`.
- Export only commerce products of a bundle: `drush synexport:product <dir> <type> <status>`.
- Export only taxonomy terms: `drush synexport:taxonomy <dir> <status>`.
- Import a full content directory: `drush synimport <dir>`.
- Import only the contacts page: `drush synimport:contact <dir>`.
- Import only nodes: `drush synimport:node <dir>`.
- Import only menus and their links: `drush synimport:menu <dir>`.
- Import only taxonomy terms (parents carry their children): `drush synimport:taxonomy <dir>`.
- Import only commerce products with variations: `drush synimport:product <dir>`.
- Import only custom blocks: `drush synimport:block <dir>`.
- Import only synlanding configuration: `drush synimport:synlanding_config <dir>`.
- Migrate published vs unpublished content selectively via the status argument (1/0).
- Move a single content type between two sites without touching other content.
- Copy attached media and files along with entities into `<dir>/files`.
- Recreate a menu structure (menu + links) on a new site from YAML.
- Seed a fresh environment with sample content using the bundled `content file examples/`.
- Attach paragraph-based field content described in YAML during import.
- Reference existing taxonomy terms from imported nodes by the `taxonomy` field type.
- Build commerce product variations and attributes from `variations`/`attribute` typed fields.
- Pull visit-card / brief content from the Synapse biz-panel service into paragraphs.