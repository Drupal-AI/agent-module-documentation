<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Layout Builder add/update-block integration

All logic is in `Drupal\entity_browser_block_layout\FormAlter` (`src/FormAlter.php`), invoked
from `hook_form_FORM_ID_alter` implementations in `entity_browser_block_layout.module`. The
module adds **no route or controller**; it only alters the core Layout Builder block forms, so
access stays governed by Layout Builder's own layout-configuration access.

## Hooks → methods

- `entity_browser_block_layout_form_layout_builder_update_block_alter()` →
  `FormAlter::alterLayoutBuilderUpdateBlockForm()`.
- `entity_browser_block_layout_form_layout_builder_add_block_alter()` →
  `FormAlter::alterLayoutBuilderAddBlockForm()` (calls the update-block alter, then adds the
  auto-open process callback).
- `hook_preprocess_views_view` (`entity_browser_block_layout_preprocess_views_view`) attaches
  the `eb_view_decoration` library to views `node_browser`, `block_browser`,
  `media_entity_browser`, `bio_browser`.
- `entity_browser_block_layout_form_views_exposed_form_alter` relabels `created_op` to
  "Post date" on the `node_browser` view's exposed form.

## alterLayoutBuilderUpdateBlockForm()

Returns early unless `$form['settings']['provider']['#value'] === 'entity_browser_block'`, so it
only touches Entity Browser Block blocks. Then it:

- Hides `admin_label`, `label` and forces `label_display` off (`#value = FALSE`, `#access = FALSE`).
- Sets the selected-items table `#empty` text and removes `#tabledrag`.
- Appends `FormAlter::filterViewModes` to `$form['settings']['selection']['table']['#process']`.
- Attaches library `entity_browser_block_layout/eb_layout_panel`.

## alterLayoutBuilderAddBlockForm()

Runs the update-block alter, then appends `FormAlter::autoOpenModal` to the entity_browser
element `#process`. `autoOpenModal()` sets
`drupalSettings.entity_browser.modal[<uuid>].auto_open = TRUE` so the browser opens without an
extra click. (Note: the code comment says this relies on an Entity Browser patch,
`3008700`, to avoid an auto-open loop.) `hideOpenBrowserButton()` is a defined process callback
that hides the open-modal button once a selection/default exists (except on a "Remove" rebuild);
it exists in the class but is not wired into the `#process` arrays in this version.

## filterViewModes() — the results table process callback

For each row (`Element::children($table)`), it splits the row key `"$entity_type:$entity_id"`,
loads the entity via `entity_type.manager`, then reads the **allowed view modes** third-party
setting from the entity's bundle config entity (`getThirdPartySetting('entity_browser_block_layout',
FormAlter::VIEW_MODES_SETTING, FormAlter::DEFAULT_VIEW_MODES)` — default `['default']`; see
[../config/view-modes.md](../config/view-modes.md)). It then:

- Filters the row's `view_mode['#options']` down to the allowed set (`ARRAY_FILTER_USE_KEY`).
- Sets `#default_value` to the first of `FormAlter::PREFERRED_VIEW_MODES` (`teaser`, `promo`)
  that is allowed, else `default`.
- Adds an **Edit** button before the Remove button, built with
  `$entity->toLink('Edit', 'edit-form', [...destination...])->toRenderable()` rendered via the
  `renderer` service — but **only** when `redirect.destination` is not a `/layout_builder/add/block`
  path (i.e. not mid-creation, so the unsaved new block is not lost).

## Attached assets

- `eb_layout_panel` — `css/eb_layout_panel.css` (sidebar table layout).
- `eb_view_decoration` — `css/eb_view_decoration.css` + `js/eb_view_decoration.js`
  (`Drupal.behaviors.GaEntityBrowserDecorationBehavior`): toggles a `checked` class and makes a
  whole `.views-col` / table row clickable to (un)check its `entity-browser-select` input.
