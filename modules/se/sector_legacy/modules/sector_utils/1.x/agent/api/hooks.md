<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Sector Utilities — hooks & permission reference

All code lives in `sector_utils.module` (no `src/`, no services, no routes, no config).

## Theme-gated admin CSS

- `sector_utils_page_attachments(&$attachments)` — if
  `\Drupal::theme()->getActiveTheme()->getName() == 'claro'`, appends library
  `sector_utils/admin` (defined in `sector_utils.libraries.yml` → `css/layout.css`). Non-Claro
  admin themes get nothing.

## Node form restructure (Claro only)

- `sector_utils_form_node_form_alter(&$form, $form_state, $form_id)`:
  - When active theme is `claro`: `$form['status']['#group'] = 'meta'`, sets
    `$form['status']['#markup'] = '<h3>Publishing</h3>'`, copies `$form['actions']` into
    `$form['meta']['actions']`, and sets `$form['actions']['#access'] = FALSE` (buttons now render
    only in the meta sidebar).
  - For `node_page_form` / `node_page_edit_form` (any theme): sets the status widget `#title` to
    "Published" and clears `#description` — aligning the Basic page status control with other
    content types.

## Media delete-form usage helper (needs entity_usage)

- `sector_utils_form_alter()` delegates to `sector_utils_track_entity_usage()`:
  - Early-returns unless `entity_usage` module is enabled.
  - Reads `$form_state->getBuildInfo()['callback_object']`; proceeds only for a
    `ContentEntityDeleteForm` whose entity is a `MediaInterface`, and only when `$form_id` matches
    `media_<bundle>_delete_form`.
  - Calls `entity_usage.usage`->`listUsage($entity)`; if there are usages, replaces
    `$form['description']['#markup']` with helper text linking to route
    `entity.media.entity_usage` for that media id ("used in either published content or
    revisions"). If no usages, leaves the default form.

## Field output rewrites

- `sector_utils_preprocess_field(&$variables)` switches on `#field_name`:
  - `field_filesize` → `$variables['items'][0]['content'] = ByteSizeMarkup::create($filesize)`
    (human-readable size).
  - `field_mimetype` → `_niceMimeType($mimetype)`.
- `_niceMimeType($originalMimeType)` — fixed `switch` mapping common MIME strings to short labels
  (application/pdf→PDF, …/wordprocessingml.document→DOCX, application/zip &
  application/octet-stream→ZIP, etc.); unknown types pass through unchanged.

## Unpublished view-mode marker (needs Display Suite)

- `sector_utils_ds_pre_render_alter(&$layout_render_array, $context, &$vars)` — for DS view modes
  other than `full`, when `$context['entity']` is an `EntityPublishedInterface` and not published,
  adds class `entity-status-unpublished` to `$vars['attributes']['class']`. Theme CSS supplies the
  visual indicator.

## Contextual "Configure block" gate

- `sector_utils_contextual_links_view_alter(&$element, $items)` — if
  `$element['#links']['block-configure']` is set and the current user lacks permission
  `configure blocks from contextual links`, unsets that link.
- Permission defined in `sector_utils.permissions.yml`:
  `configure blocks from contextual links` — "Access block configuration from contextual links".

## Enable

- `drush en sector_utils -y`. Grant `configure blocks from contextual links` to the roles that
  should see the block-configure contextual link. Full behavior requires the **Claro** admin theme;
  the media-usage and unpublished-class features additionally require `entity_usage` and `ds`.
