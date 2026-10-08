<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Paragraphs Sets (paragraphs_sets) — agent index

Insert a whole **pre-configured group of paragraphs** into a Paragraphs field in one click. Sets
are `paragraphs_set` config entities managed at **Structure → Paragraphs sets**, and offered on the
stable **Paragraphs** widget. Depends on `paragraphs` (`^1.13`); requires Drupal `^11.4 || ^12`.

- **Define/edit sets (config entity + admin UI), enable them on a field widget, default set** →
  [configure/sets.md](configure/sets.md)
- **Supply default/complex field data via alter hooks** → [hooks/data-alter.md](hooks/data-alter.md)

Key facts:
- Admin UI / configure route: `entity.paragraphs_set.collection` (`/admin/structure/paragraphs_set`);
  add form route `paragraphs_sets.set_add`; edit/delete routes `entity.paragraphs_set.edit_form` /
  `.delete_form`. Form controller `Drupal\paragraphs_sets\Form\ParagraphsSetForm` (add/edit),
  `EntityDeleteForm` (delete). List builder `Controller\ParagraphsSetListBuilder`. All routes are
  gated by the single permission `administer paragraphs sets`.
- Config entity `paragraphs_set` (`Drupal\paragraphs_sets\Entity\ParagraphsSet`, `#[ConfigEntityType]`,
  `config_prefix: set`; config prefix `paragraphs_sets.set.*`). Exported keys (config_export order):
  `id`, `label`, `icon_uuid`, `description`, `paragraphs`. `paragraphs` = ordered list of
  `{bundle: <paragraph_type>, data: <YAML-encoded field defaults>}`.
- **3.1.x data storage change:** each item's `data` is stored as a YAML-encoded **string**
  (schema `type: text`, translatable), not a nested array. Decode/encode via
  `ParagraphsSets::decodeSetItemData()` / `encodeSetItemData()`; the entity normalizes on
  `preSave()` (encode) and `getParagraphs()` (decode). `update_9002` migrates old data.
- Widget third-party settings (on the `paragraphs` widget, stored **double-nested** under
  `third_party_settings.paragraphs_sets.paragraphs_sets` of an `entity_form_display` component):
  `use_paragraphs_sets` (enable), `sets_allowed` (limit), `default_set` (seed default value).
- **3.1.x hooks are OOP** — no `.module` file. Hook classes under `src/Hook/` with `#[Hook]`
  attributes: `FieldHooks` (`field_widget_third_party_settings_form`,
  `field_widget_settings_summary_alter`), `FormHooks` (`field_widget_complete_form_alter` — the
  core widget rebuild that inserts a set's paragraphs), `ThemeHooks` (`theme` +
  two preprocess hooks).
- Alter hooks (declared in `paragraphs_sets.api.php`): `hook_paragraphs_set_data_alter()`,
  `hook_paragraphs_set_SET_data_alter()`, `hook_paragraphs_set_SET_FIELD_NAME_data_alter()`,
  `hook_paragraphs_sets_set_static_icon_uri_alter()`.
- Runtime helpers: static class `Drupal\paragraphs_sets\ParagraphsSets` (`getSets()`,
  `getSetsOptions()`, `buildSelectSetSelection()`, static Form API callbacks `setSetSubmit()` /
  `setSetAjax()`, `decodeSetItemData()` / `encodeSetItemData()`).
- Templates: `field-multiple-value-form--paragraphs-sets.html.twig`,
  `paragraphs-sets-add-dialog.html.twig`. Libraries: `paragraphs_sets/drupal.paragraphs_sets.admin`
  (css), `.../modal` (modal js+css). `hook_install()` sets module weight 12 (after paragraphs).
