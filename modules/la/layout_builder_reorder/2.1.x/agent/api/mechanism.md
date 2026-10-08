<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# How Layout Builder Reorder works

No configuration exists — the module is entirely a render alteration plus one route. Two
pieces:

## 1. Injecting the Move up / Move down links

`LayoutBuilderReorderHooks::elementInfoAlter()` (`#[Hook('element_info_alter')]`) appends a
`#pre_render` to the core `layout_builder` render element:

```php
$types['layout_builder']['#pre_render'][] =
  '\Drupal\layout_builder_reorder\SectionRearrangeRender::preRender';
```

`SectionRearrangeRender::preRender()` (a `TrustedCallbackInterface`) iterates every rendered
section that has a `configure` link, then adds:

- `rearrange_up` — a **Move up** AJAX link on every section except the first;
- `rearrange_down` — a **Move down** AJAX link on every section except the last.

Each link points at the move route with `new_delta = delta ∓ 1`, uses classes `use-ajax`,
`layout-builder__link`, `layout-builder__link--rearrange`, and `--up` / `--down`, and its
`#access` is the URL's own access check.

## 2. Performing the move

Route `layout_builder_reorder.move_section`:

```
/layout_builder/move/section/{section_storage_type}/{section_storage}/{delta}/{new_delta}
```

- `section_storage` is upcast from the **layout_builder tempstore** (route option
  `layout_builder_tempstore: TRUE`).
- Access: `_layout_builder_access: view` (same as core Layout Builder — no new permission).
- Controller `MoveLayoutBuilderSectionController::__invoke()`:
  1. `$sections = $section_storage->getSections();`
  2. swaps `$sections[$delta]` and `$sections[$new_delta]`;
  3. `removeAllSections()` then re-`appendSection()` in the new order;
  4. saves to the tempstore (`layoutTempstoreRepository->set()`);
  5. returns `rebuildLayout()` (AJAX) to refresh the UI.

The change lands in the Layout Builder **tempstore**; it becomes permanent when the editor
clicks **Save layout** (core behaviour). Programmatically, the same reorder is just swapping
section deltas on the section storage (e.g. the entity's `layout_builder__layout` field for an
override) and saving.

## What it does NOT do

No config entity, no settings, no schema, no permission, no service, no Drush command, no
plugins. Uninstalling removes the links; existing section order is unchanged.
