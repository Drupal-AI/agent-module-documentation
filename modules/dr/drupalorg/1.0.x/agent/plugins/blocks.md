<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Blocks, theme hooks & libraries

## Blocks (`src/Plugin/Block/`, annotation `@Block`)

- **`drupalorg_documentation_issue_submission`** — `DrupalOrgDocumentationIssue`. On a `documentation` node, renders (theme `drupalorg_documentation_issue_submission`) a link to `https://www.drupal.org/node/add/project-issue/documentation` prefilled with the page title and URL. Cached per `url` + `node:<id>` tag.
- **`drupalorg_documentation_tree`** — `DrupalOrgDocumentationTree`. On `documentation`/`guide` nodes, builds a nested tree of published child docs/guides (queried by `og_group_ref_documentation`, sorted by `field_weight`/`title`), rendering titles as links plus `field_summary`. Cache tags for every listed node.
- **`drupalorg_sponsor_widget`** — `DrupalOrgSponsorWidget`. Renders `field_sponsor` (name, URL, logo via `sponsor_widget_image` image style; theme `drupalorg_sponsor_widget`); walks up guide parents to inherit a sponsor when `field_sponsor_type == sponsor_all_nested_guides`. Cache context `route` + `node:<id>` tag.

## Theme hooks (`drupalorg_theme()` in `drupalorg.module`)

`drupalorg_issue_forks_management` (template + `drupalorg.theme.inc`), `drupalorg_sponsor_widget`, `drupalorg_documentation_issue_submission`. Templates live in the module's `templates/` dir.

## Libraries (`drupalorg.libraries.yml`)

- `copy_to_clipboard` — `js/copy_to_clipboard.js` (dep `core/drupal`).
- `fork_check_access` — `js/fork_check_access.js` (deps `core/drupal`, `core/once`); front-end for the issue-fork check-access endpoint.
- `icon-field` — `css/icon-field.css`; attached on admin routes by `hook_page_attachments_alter`.
