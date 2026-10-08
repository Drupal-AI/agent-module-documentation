Devel Generate (a submodule of Devel) bulk-creates dummy content — users, nodes, taxonomy terms, menus, media, and block content — for testing, theming, and performance work.

---

Devel Generate solves the "empty site" problem when building or testing a Drupal site. It ships a set of `DevelGenerate` plugins, one per entity kind (content/nodes, users, terms, vocabularies, menus, media, block content), each with a configuration form and a Drush command. You choose how many items to create, which bundles/content types to target, whether to delete existing items first, age/date ranges for created content, how many comments to add, and options like adding a URL alias or specifying languages. Generation runs through the Batch API so it can create thousands of items without timing out. Every generator is exposed both in the UI (under Configuration → Development → Generate) and on the command line via `devel-generate:*` commands, making it scriptable for CI and local setup. The module defines a `DevelGenerate` plugin type plus a `hook_devel_generate_alter()` hook so custom or contrib entity types can add their own generators or tweak the generated values. Access is gated by the `administer devel_generate` permission and per-plugin permission callbacks. It is a development aid — never enable it on production.

---

- Seed a fresh site with hundreds of nodes for theming work.
- Generate realistic-looking articles and pages to test listings and views.
- Create bulk taxonomy terms in a vocabulary to test tagging UIs.
- Generate whole vocabularies of terms at once.
- Create many test users to exercise permissions and access rules.
- Populate menus with generated links to test navigation depth.
- Generate media items to test media library and fields.
- Create block content entities in bulk.
- Delete all existing content of a type before regenerating a clean set.
- Stress-test a view or search index with thousands of nodes.
- Benchmark page/query performance under realistic data volume.
- Add generated comments to nodes to test threaded discussions.
- Backdate created content across a date range to test archives.
- Generate content in specific languages to test multilingual sites.
- Add URL aliases to generated nodes (with Pathauto/path).
- Script content seeding in CI with `drush devel-generate:content`.
- Quickly create users from the CLI with `drush devel-generate:users`.
- Generate terms from the CLI with `drush devel-generate:terms`.
- Fill menus via `drush devel-generate:menus`.
- Generate media via `drush devel-generate:media`.
- Create block content via `drush devel-generate:block-content`.
- Reproduce a data-heavy bug locally by generating similar volume.
- Provide demo data for a client walkthrough.
- Add a custom generator for a bespoke entity type via a plugin.
- Alter generated field values with `hook_devel_generate_alter()`.
- Choose the number of comments/roles/authors per generated item.
