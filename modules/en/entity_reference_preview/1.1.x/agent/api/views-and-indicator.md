<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Views integration & draft indicator

Hooks live in `entity_reference_preview.module`.

## Views display extender

- `src/Plugin/views/display_extender/EntityPreviewDisplayExtender.php` — `@ViewsDisplayExtender` id
  **`entity_preview`**. Adds a per-display option `entity_reference_preview_enable` (default 0) under an
  "Entity Preview" section in the Views UI. Schema `views.display_extender.entity_preview` (config/schema).
- Registered/unregistered in `views.settings` `display_extenders` by `hook_install()` /
  `hook_uninstall()` (`entity_reference_preview.install`) when Views is present.

## hook_views_post_execute()

For a view display with `entity_reference_preview_enable` on, whose row plugin is `EntityRow` or
`Fields`:
- **Not previewing**: for each `RevisionableInterface` result row, sets
  `$row->_entity->_show_preview_indicator` = `!isLiveVersion(entity)` **AND** the viewer has
  `view entity_reference_preview indicator` **AND** config `enableDraftIndicator`; adds
  `user.permissions` / `entity_reference_preview` / with|without-indicator cache contexts.
- **Previewing**: collects the row entities and calls `EntityStateManager::maybeSwapEntities()` (which
  access-checks each swap), then replaces each `$row->_entity` with the returned latest revision.

## Draft indicator rendering

- `hook_entity_view_alter()`: if `$entity->_show_preview_indicator` is set (only set on access-checked,
  permission-gated paths above and in the formatter), calls `_entity_reference_preview_render_indicator()`
  which prepends a `<span class="entity-reference-preview__has-draft">` whose `title`/value is a
  translated message naming the entity type, id, current vid, latest vid and label, and attaches the
  `entity_reference_preview/indicator` library (`css/indicator.css`). Adds tag `erp_draft_indicator`.
- The indicator therefore appears only for users with `view entity_reference_preview indicator` when
  `enableDraftIndicator` is on and the reference has a newer non-default revision.
