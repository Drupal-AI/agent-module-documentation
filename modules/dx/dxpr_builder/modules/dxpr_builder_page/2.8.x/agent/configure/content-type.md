<!-- SPDX-License-Identifier: LicenseRef-DXPR-Commercial -->
# The `drag_and_drop_page` content type

Installed from `config/optional/` when the submodule is enabled (config is `enforced` to
`dxpr_builder_page`).

## Node type
- id: `drag_and_drop_page`, label "Drag and drop Page" (`node.type.drag_and_drop_page`).
- `new_revision: true`, `display_submitted: false`, `preview_mode: 0`.
- `menu_ui` third-party settings: available menu `main`, parent `main:`.

## Fields
- `body` (`field.field.node.drag_and_drop_page.body`, uses shared `field.storage.node.body`) —
  this is the DXPR-editable field.
- `field_dth_page_layout` — page layout choice.
- `field_dth_main_content_width` — main content width.
- `field_dth_hide_regions` — which theme regions to hide on the page.
  (The `dth_` fields are DXPR Theme helper fields.)

## Displays
- Default **view** display (`core.entity_view_display.node.drag_and_drop_page.default`):
  the `body` component's `type` is **`dxpr_builder_text`** — i.e. the page body is rendered/
  edited with DXPR Builder. Confirm live:
  ```php
  \Drupal::entityTypeManager()->getStorage('entity_view_display')
    ->load('node.drag_and_drop_page.default')->getComponent('body')['type']; // dxpr_builder_text
  ```
- Default form display and a teaser view display also ship.

## Uninstall guard
`src/DXPRBuilderPageUninstallValidator.php` (service in `dxpr_builder_page.services.yml`)
implements `ModuleUninstallValidatorInterface` and returns a reason preventing uninstall while
any `drag_and_drop_page` node exists — delete that content first to uninstall.

There is nothing to configure; enabling the submodule is the whole setup. Create pages via
Content → Add content → "Drag and drop Page" (or `Node::create(['type' => 'drag_and_drop_page', …])`).
