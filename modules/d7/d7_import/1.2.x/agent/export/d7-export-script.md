<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# D7 export script

`d7_export_script/export_content.php` — a standalone Drush PHP script that runs on the **source
Drupal 7 site** (not part of the D11 module runtime). It reads the live D7 database and writes the
XML files this module imports.

## Running it

```bash
# copy the script to the D7 site root, then:
drush -l example.com php-script export_content.php
```
Requires a `-l`/site (reads `global $base_url`; exits with an error if empty). Output goes to
`sites/default/files/export/{site_name}/` where `site_name` is the sanitised host of `$base_url`.

## What it exports

Uses `DOMDocument` + D7 `db_query()` to write:
- `taxonomy.xml` — `<term>`: tid, vocabulary (machine_name), name (CDATA), weight, parent
  (from `{taxonomy_term_hierarchy}`).
- `nodes.xml` — `<node>`: nid, type, title, uid, status, promote, sticky, created, changed,
  language, and a `<fields>` block of `<field name= type=>` / `<value delta=>` entries.
- `files.xml` — `<file>`: fid, filename, uri, filemime, filesize, timestamp.
- `aliases.xml` — `<alias>`: nid or tid, path, language.
- `menus.xml` — `<menu>` and `<menu_link>` rows.
- `webforms.xml` — only when Webform 7.x-4.x is installed (imported by the `d7_import_webform`
  submodule on the D11 side).

## Node-type exclusion

`$skip_node_types` (top of the script, default `['webform']`) excludes those content types from
`nodes.xml`. The default skips D7 `webform` nodes so they aren't imported twice — once as
'webform' content-type nodes and again as Webform config entities via `d7_import_webform`. Set to
`[]` to export every content type.

## XML-safety helpers

- `dom_add_element()` — plain text-node child.
- `dom_add_cdata()` — HTML-entity-decodes to UTF-8, strips invalid XML control chars
  (`[\x00-\x08\x0B\x0C\x0E-\x1F\x7F]`), and splits any `]]>` sequence so it can't break the CDATA
  section. Used for free-text values (names, bodies) that may contain markup.

## Relationship to the importers

The tag/element names written here are exactly what the D11 importers read via
`getElementValue()` (see `services/importers.md`). The D11 side re-sanitises control characters
before parsing (Drush path), because legacy D7 data still slips invalid bytes through.
