<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Drutopia Comment is a config-only Drutopia distribution feature that installs a default node comment type, the comment body field and displays, an RDF mapping, and role-based core Comment permission grants.

---

It ships **no PHP** — no `src/`, routes, services, hooks or permissions of its own. Everything it does is expressed as exported configuration under `config/install/` (a `comment` comment type targeting nodes, the `node.comment` field storage, the required `comment_body` text_long field, default form and view displays, and a `schema:Comment` RDF mapping) plus five `config_actions` files under `config/actions/` that **add** core Comment permissions to the Drutopia roles when the module is installed. Because the permission actions are applied via the `config_actions` module, the project effectively needs `drupal/config_actions` in addition to its declared dependencies (core `comment`, `field`, `node`, `rdf`, `text` and `drutopia_core`). There is nothing to configure in code: you enable the module (normally pulled in by the Drutopia install profile) and then manage comment types, moderation and permissions through core's own comment admin. This copy is a **dev checkout** (no `version:` in info.yml); the `2.0.x` directory is the branch.

---

- Give a Drutopia site a ready-made commenting setup without hand-building a comment type.
- Install the `comment` comment type ("Default comments") targeting the `node` entity type.
- Add the single-cardinality `comment` field to nodes (`field.storage.node.comment`).
- Provide the required `comment_body` (`text_long`) field on the comment bundle.
- Ship default comment form and view displays (author, subject, comment body, links).
- Add `schema:Comment` RDF metadata to rendered comments via the `rdf` mapping.
- Grant `access comments` to the **anonymous** role so visitors can read comments.
- Grant `access comments` + `post comments` to the **authenticated** role (posts go to moderation).
- Grant `edit own comments` + `skip comment approval` to the **contributor** role.
- Grant `administer comments` + `skip comment approval` to the **editor** role.
- Grant `administer comments` + `skip comment approval` to the **manager** role.
- Establish a consistent, role-graded comment permission baseline across Drutopia sites.
- Serve as the config baseline other Drutopia features can override site-by-site.
- Let editors and managers moderate comments through core's Content → Comments UI.
- Re-import default comment config after an accidental change via config management.
- Act as an installable composer unit in a Drutopia site build.
- Enable commenting on nodes without manually creating fields or displays.
- Pull core Comment, Field, Node, RDF and Text (plus Drutopia Core) in as dependencies.
- Provide a starting point for site-specific comment field/display overrides.
- Uninstall to cleanly remove the bundled comment configuration.
- Support Drupal 10.2, 11 and 12 core versions.
