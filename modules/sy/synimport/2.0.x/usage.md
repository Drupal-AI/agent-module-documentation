<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
SynImport is a Drush-only tool that exports Drupal content to a directory of structured YAML files and imports it back, recreating nodes, commerce products, taxonomy terms, menus and custom blocks together with their attached media and files.
---
SynImport (package "Synapse") targets site-to-site content migration for Synapse-built sites. Export commands (`synexport` and its per-type variants) walk fieldable entities and write one YAML file per entity under `<dir>/<entity_type>/`, copying attached images and files into `<dir>/files/`; import commands (`synimport` and its per-type variants) read that structure back and create the matching entities. Field values may be plain (`field_name: value`) or typed as `{type: <t>, content: <v>}` where `<t>` is one of `image`, `media`, `attach`, `taxonomy`, `paragraph`, `variations`, `attribute` (an unknown type falls back to a text value). The whole surface is CLI/Drush only: the module ships `drush.services.yml` and `SynimportCommands` but declares no routes, permissions, config forms or config schema, so it is reachable only by an operator with shell/Drush access. It depends on the `idna` module, and its export/import of commerce products, paragraphs, media and path aliases works only when those respective modules and the target bundles/fields already exist on the site — SynImport does not create or validate content types or fields. During import, field values beginning with `http` are fetched server-side and stored under `public://import/`; a separate `synimport:redis_import` command pulls "visitka"/brief content from the Synapse biz-panel service into node paragraphs.
---
- Export an entire site's content to a directory: `drush synexport <dir> <status>`.
- Export only nodes of a given bundle: `drush synexport:node <dir> <bundle> <status>`.
- Export only commerce products of a bundle: `drush synexport:product <dir> <bundle> <status>`.
- Export only taxonomy terms: `drush synexport:taxonomy <dir> <status>`.
- Export only custom blocks: `drush synexport:block <dir> <bundle> <status>`.
- Import a full content directory (contacts, menu, taxonomy, nodes, products, block, synlanding): `drush synimport <dir>`.
- Import only the contacts page body/alias: `drush synimport:contacts <dir>`.
- Import only nodes: `drush synimport:node <dir>`.
- Import only menus and their (nested) links: `drush synimport:menu <dir>`.
- Import only taxonomy terms: `drush synimport:taxonomy <dir>`.
- Import only commerce products with variations and attributes: `drush synimport:product <dir>`.
- Import only custom blocks: `drush synimport:block <dir>`.
- Import only synlanding form-background configuration: `drush synimport:synlanding_config <dir>`.
- Migrate published vs unpublished content selectively via the status argument (`1` = published, `0` = all/unpublished).
- Move a single content type between two sites without touching other content.
- Copy attached media, images and files along with their entities into `<dir>/files/`.
- Recreate a menu structure (menu entity plus a tree of `menu_link_content`) on a new site from YAML.
- Reference existing taxonomy terms from imported entities by term name via the `taxonomy` field type.
- Build commerce product variations and attribute values from `variations` / `attribute` typed fields.
- Attach paragraph-based field content described inline in the YAML during import.
- Set a node as the site front page during import via an `is_front: true` key.
- Seed a fresh environment with sample content using the bundled `content file examples/`.
- Pull visitka/brief content from the Synapse biz-panel service into an existing node's paragraphs: `drush synimport:redis_import <app_id> <source>`.
