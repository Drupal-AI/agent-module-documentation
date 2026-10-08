<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# How copy/paste works

No settings, no plugins — the behaviour is three pieces: a pre-render that injects links, two
controller routes, and a deep-clone trait.

## 1. Injecting the links (`CopySectionRender::preRender`)

`lb_copy_section_element_info_alter()` appends `CopySectionRender::preRender` to the
`layout_builder` render element's `#pre_render`. That callback (only for users with
`copy paste sections`):
- adds a **Copy** link (`#weight` 4) to every rendered section, pointing at
  `lb_copy_section.copy`;
- adds a **Paste** link to every "add section" position (only when something is in the copy
  buffer), pointing at `lb_copy_section.paste`, titled `Paste <copied section label>`;
- attaches the `lb_copy_section/admin` CSS library.

Links carry the `use-ajax` class so Layout Builder refreshes in place.

## 2. Routes / controller (`CopySectionController`)

```
lb_copy_section.copy  /lb_copy_section/copy/{section_storage_type}/{section_storage}/{delta}
lb_copy_section.paste /lb_copy_section/paste/{section_storage_type}/{section_storage}/{delta}
```

Both require permission `copy paste sections` and `_layout_builder_access: 'view'`, and load
the section storage from the **Layout Builder tempstore** (`layout_builder_tempstore: TRUE`).

- **copy(delta):** grabs `$section_storage->getSections()[$delta]`, and stores the `Section`
  object under key `copied_section` (and its label under `copied_section_label`) in the
  **current user's private tempstore**, collection `lb_copy_section`
  (`\Drupal::service('tempstore.private')->get('lb_copy_section')`).
- **paste(delta):** reads `copied_section`, rebuilds the `Section`, **deep-clones** it, then
  `$section_storage->insertSection($delta, $clone)` and writes the storage back to the Layout
  Builder tempstore. The layout is not saved until the editor clicks *Save layout* as usual.

Both end by calling `rebuild()` → AJAX `rebuildAndClose()` or a redirect to the layout URL.

## 3. Deep cloning (`DeepCloningTrait::cloneAndReplaceSectionComponents`)

So a pasted section is fully independent of the original:
- every `SectionComponent` gets a **new UUID**;
- for `InlineBlock` components the referenced `block_content` entity is `createDuplicate()`d,
  its referenced entities of allowed types (`block_content`) are recursively duplicated, and
  the duplicate is stored back as `block_serialized` (matching how core adds new inline
  blocks, avoiding usage-table / MediaLibrary access issues);
- **paragraphs** referenced by inline blocks are duplicated too
  (`cloneReferencedParagraphsEntities`), handling both classic `entity` and IEF `target_id`
  structures.

Non-inline blocks (reusable blocks, plugin blocks) are copied by configuration only — they
still reference the same underlying entity/plugin, which is the intended behaviour.

The trait credits the `section_library` module for the deep-clone approach.
