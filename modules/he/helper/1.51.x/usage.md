<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Helper is a developer toolkit module: a grab-bag of reusable services, static utilities, form elements, blocks, Twig helpers, Drush commands, and opt-in behavior tweaks ("helpers") for building Drupal sites and modules.

---

Helper ships no user-facing feature of its own; instead it provides code-level building blocks. Injectable services include `helper.config` (programmatic config import/export), `helper.entity`/`helper.entity_type`/`helper.current_entity` (entity lookups, options, reference-selection handlers, resolving the entity from the current route/Layout Builder context), `helper.menu` (build render-ready menus from links or link fields), `helper.file` (create/reuse files, data URIs), `helper.theme`, `helper.text_format` (add/remove allowed tags on a text format), `helper.layout_builder` and `helper.pathauto`; plus static helpers `ArrayHelper`, `Utility`, `Html` and `Field`. It adds a `helper_entity_select` form element, two blocks (`helper_node_field`, `helper_context_entity`), Twig helpers (`format_bytes` filter, `file_data_uri` function), a `module_dependency` service tag (auto-removes a service when a module is absent), an `_is_multilingual` route requirement, sub-theme region inheritance (`inherit_regions`), and validation constraints for unique field values. A set of Drush commands manage module schema versions (`module:schema-version:get/set/delete/cleanup`), reset post-update hooks (`module:post-update:reset`), and switch install profiles (`install-profile:switch`). Finally, `helper.settings` stores a map of optional behavior "helpers" you can toggle on/off (e.g. disable HTML5 validation on all forms, hide Layout Builder providers, redirect entity 4xx to the edit form). Requires core `file` plus the `davereid/drupal-environment` and `webflo/drupal-finder` libraries.

---

- Programmatically import a module's default config or re-export config with `helper.config`.
- Resolve the entity being viewed on the current route (or in a Layout Builder context) via `helper.current_entity`.
- Build `#options` arrays of entities/bundles for a select with `helper.entity_type`.
- Get a properly configured entity-reference selection handler for a field with `helper.entity_type`.
- Render a Drupal menu (or a link field) as a themed menu tree with `helper.menu`.
- Create or reuse a managed file from a URI, or produce a data URI, with `helper.file`.
- Add or remove allowed HTML tags/attributes on a text format via `helper.text_format`.
- Add a "pick one entity" select to a form with the `helper_entity_select` element (best for config entities).
- Place a node's single field in any block region with the `helper_node_field` block.
- Output the current context entity in a chosen view mode with the `helper_context_entity` block.
- Format a byte count in Twig with the `format_bytes` filter (e.g. `{{ file.getSize()|format_bytes }}`).
- Inline a file as a data URI in Twig with the `file_data_uri` function.
- Make a service automatically disappear when a module isn't enabled using the `module_dependency` tag.
- Restrict a route to multilingual sites with the `_is_multilingual: TRUE` requirement.
- Let a sub-theme inherit its base theme's regions with `inherit_regions: true` in the theme info.
- Enforce unique values across a field with the `EntityFieldUniqueValues`/`FieldListUniqueValues` constraints.
- Set or read a module's schema version from the CLI with `drush module:schema-version:get/set`.
- Reset a specific post-update hook so it runs again with `drush module:post-update:reset`.
- Clean up orphaned schema versions of deleted modules with `drush module:schema-version:cleanup`.
- Switch the site's install profile with `drush install-profile:switch`.
- Disable HTML5 client-side validation on all forms via the `core_form_novalidate` helper.
- Allow textarea widgets on plain string/text fields via the `core_text_textarea_widgets` helper.
- Redirect 403/404 entity views to the edit form (e.g. with Rabbit Hole) via `redirect_entity_4xx_to_edit`.
- Hide core's default Layout Builder layouts with the `core_hide_layout_providers` helper.
- Add missing `title` attributes to oEmbed iframes for accessibility via `media_oembed_iframe_title`.
- Manipulate arrays (replace values/keys, chunk evenly, unique-add) with the static `ArrayHelper`.
- Run a batch synchronously or register a unique shutdown function with the static `Utility` helper.
