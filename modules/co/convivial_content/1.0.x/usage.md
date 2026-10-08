<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Convivial Content fetches YAML dataset files from a configurable source URL and imports them into Drupal as real content (taxonomy terms, media, block content, nodes, paragraphs, menus, block placements and site settings) — used to seed default/demo content for the Convivial distribution.

---

Convivial Content is the default-content importer for the Convivial (Morpht) distribution. An administrator sets a **Source URL** (default: the `morpht/convivial-default-content` GitHub raw path) on the settings form, then picks a named dataset from that source's `index.yaml` — or pastes custom YAML — and runs the import. The import pipeline (`DataImporter::importContent`) reads a schema file, then creates entities in a fixed order: taxonomy terms, image media (downloaded from URLs in the dataset), block content, nodes, paragraphs, menu links, `system.site` settings and themed block placements. A per-run "Site Clean Up" flag deletes existing content of the imported types before recreating it, and also rewrites basic site settings (front page, mail, name). It ships a Drush command (`convivial_content:import`) that does the same headlessly. It depends on `convivial_core` for its admin section and the `access convivial administration pages` permission that gates both routes. It provides no entities, permissions or plugins of its own; its single config object is `convivial_content.settings` (just the `source_url` string).

---

- Seed a fresh Convivial site with example pages, media and structure out of the box.
- Import a named dataset (for example bookshop, umami, news) chosen from a remote `index.yaml`.
- Point the importer at your own content repository by changing the Source URL.
- Paste a custom YAML dataset directly into the import form to import ad-hoc content.
- Run content import headlessly in CI/deploy with `drush convivial_content:import <dataset>`.
- Rebuild a demo site to a known baseline using the Site Clean Up option.
- Bulk-create taxonomy terms from a dataset.
- Bulk-create image media by downloading images referenced in a dataset.
- Bulk-create reusable block content (custom blocks) from a dataset.
- Bulk-create nodes with published moderation state from a dataset.
- Attach paragraphs to imported nodes and block content when the Paragraphs module is present.
- Populate node reference fields (taxonomy and node references) resolved from the dataset.
- Create menu links pointing at imported nodes.
- Place imported block content into theme regions, disabling existing region blocks first.
- Set the site front page, email and name from the dataset (clean-up runs only).
- Reset a QA/staging environment to canned demo content before a test run.
- Provide starter content for a client site that editors then replace.
- Keep default content in a Git repo separate from module code and fetch it on demand.
- Wipe and reimport only the entity types present in a dataset, leaving others untouched.
- Import files referenced from the active theme directory into the media/file system.
- Serve as the content layer of the Convivial distribution alongside Convivial Core.
