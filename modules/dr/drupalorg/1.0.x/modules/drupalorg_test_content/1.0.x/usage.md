<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
DrupalOrg test content is a submodule of Drupal.org that imports exported default content to seed a local or development site with representative sample data.

---

`drupalorg_test_content` contains no PHP code — it ships a `content/` directory of YAML exports (nodes and their paragraphs, media, files, taxonomy terms, block content and users) that the `default_content` module imports on install. It exists so contributors running the Drupal.org module locally get realistic content (projects, documentation, users, etc.) to develop and test against without needing a full drupal.org data set. It depends on `default_content:default_content` and supports Drupal 9, 10 and 11. It is a developer convenience only and is not meant for production.

---

- Populate a fresh local site with sample Drupal.org content.
- Provide example project/documentation nodes for developing the Drupal.org module.
- Seed sample users, media and files for local testing.
- Seed taxonomy terms (e.g. development/maintenance status) used by Project Browser filters.
- Provide block-content fixtures for theming/layout work.
- Give a reproducible content baseline for manual QA.
- Import content automatically on module enable via `default_content`.
- Avoid hand-creating test content when spinning up a dev environment.
- Support demos of the Drupal.org customizations.
- Serve as an example of a `default_content` export set.
