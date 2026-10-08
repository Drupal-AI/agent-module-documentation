<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Per-bundle allowed view modes

Lets a site builder choose which view modes editors may pick when placing Entity Browser Block
referenced content of a given bundle in Layout Builder. Stored as a **third-party setting** on the
bundle config entity — the module ships **no settings form and no `configure` route**; the UI is
grafted onto the standard content-type / media-type edit forms.

## Where it is set

`FormAlter::alterEntityTypeForm()` (in `src/FormAlter.php`) is called from four hooks in
`entity_browser_block_layout.module`:

- `node_type_add_form` / `node_type_edit_form` → `alterEntityTypeForm('node', …)`
- `media_type_add_form` / `media_type_edit_form` → `alterEntityTypeForm('media', …)`

It adds a `details` group titled **"Entity Browser Block view modes"** (grouped under
`additional_settings`) containing a `checkboxes` element keyed
`FormAlter::VIEW_MODES_SETTING` (`entity_browser_block_layout_view_modes`). Options come from
`entity_display.repository`'s `getViewModeOptions($entity_type)`; the default value is the
bundle's current third-party setting (default `['default']`).

## How it is saved

The alter registers `FormAlter::entityTypeFormBuilder` as a `#entity_builders` callback. On save:

- If any view modes were checked → `$config_entity->setThirdPartySetting('entity_browser_block_layout',
  'entity_browser_block_layout_view_modes', $view_modes)`.
- Otherwise → `unsetThirdPartySetting(...)`.

## How it is consumed

`FormAlter::filterViewModes()` reads the same third-party setting on the selected entity's bundle
to filter the view-mode `#options` and pick a default in the Layout Builder block form
(see [../forms/layout-builder-integration.md](../forms/layout-builder-integration.md)). Preferred
defaults, when allowed, are `teaser` then `promo` (`FormAlter::PREFERRED_VIEW_MODES`).

## Schema & shipped config

- `config/schema/entity_browser_block_layout.schema.yml` defines
  `node.type.*.third_party.entity_browser_block_layout` as a mapping with a
  `entity_browser_block_layout_view_modes` **sequence of strings**. (Note: only the `node.type`
  third-party schema is declared; the media-type variant is written by the same code but has no
  matching schema entry in this version.)
- `config/optional/` ships four Entity Browser views used as browser sources —
  `views.view.node_browser`, `views.view.block_browser`, `views.view.media_entity_browser`,
  `views.view.bio_browser` (installed only when their config dependencies are met).

There is no `config/install/` object; the module has no site-wide settings of its own.
