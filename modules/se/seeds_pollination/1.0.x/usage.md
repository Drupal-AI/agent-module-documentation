<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Seeds Pollination is a helper module for the Seeds distribution that bundles small, independently-toggled site-building and admin conveniences (config-entity descriptions, a Layout Builder layout, an un-masquerade button, user-1 edit lockdown, lowercase file extensions, and dev-only Drush safety hooks).

---

Seeds Pollination collects miscellaneous enhancements used across the Seeds distribution into one module whose behaviours are switched on individually from a single settings form at `admin/config/user-interface/seeds-pollination` (config object `seeds_pollination.settings`). Its features are mostly `hook_form_alter`/`hook_entity_type_alter` glue plus one Layout Builder layout (`Seeds Lighthouse`) and a Drush command file that guards destructive `sql:sync` / `core:rsync` / `sql:drop` operations. It declares no hard module dependencies and degrades gracefully when optional modules (masquerade, entityqueue, field_ui, views_ui, locale, layout_builder) are absent. Although named after the Seeds distribution, nothing in the code contacts other sites or external services — "pollination" is a metaphor for spreading small enhancements across a site, not cross-site sync.

---

- Add a required "Administrative Description" field to config entities (fields, views, webforms, roles, entity queues, media types, node types, paragraph types, vocabularies, form displays) so builders document why each was created.
- Enforce a 20-character minimum on those config-entity descriptions via `seeds_pollination_description_validate`.
- Store the description as a `seeds_pollination` third-party setting on config entities that lack a native description field.
- Surface the stored description as an extra column in field, entity-queue, role and form-mode list builders.
- Give every content-entity bundle (node type, etc.) a "Container settings → Fluid Container" toggle stored in `seeds.container_settings`, letting themes switch a landing page between fixed and fluid containers.
- Hide the node title label and show it as a placeholder on all node forms for a cleaner editing UI.
- Provide the `Seeds Lighthouse` Layout Builder layout with 20+ regions and per-row container/fluid-container selectors plus a custom wrapper id and classes.
- Show a floating "un-masquerade" eye button for users who are masquerading but lack toolbar access, so they can drop back to their own account.
- Prevent editing of user 1 site-wide when the "Disable user 1 edit" toggle is on (replaces the standalone `disable_user_1_edit` module).
- Force uploaded file extensions to lowercase (useful for WebP and case-sensitive filesystems) via `hook_file_validate`.
- Import UI string translations from a `translations.yml` file at the Drupal root during `drush deploy`/rebuild (`seeds_pollination_rebuild`).
- Load the Root theme's global styling into Layout Builder add/update-block modals so previews look correct.
- Warn and require an explicit "I Understand" confirmation before running `drush sql:sync` or `core:rsync` against dev/prod/live/stage-named targets.
- Automatically take a gzipped SQL backup to the temp dir before `drush sql:drop`.
- Toggle any of these behaviours from one admin settings form rather than installing several single-purpose modules.
- Enable only the sub-features a given Seeds site needs and leave the rest off.
- Standardise documentation habits across a builder team by making config descriptions mandatory.
- Keep landing-page container behaviour as data (config) so it survives config export/import.
