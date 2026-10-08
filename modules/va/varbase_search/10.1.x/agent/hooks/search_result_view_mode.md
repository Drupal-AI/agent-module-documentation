# Hook: auto-build the `search_result` node view-mode display

Class `Drupal\varbase_search\Hook\VarbaseSearchHooks` (OOP `#[Hook(...)]` attributes).

## `form_entity_view_display_edit_form_alter`
```php
#[Hook('form_entity_view_display_edit_form_alter')]
public function formEntityViewDisplayEditFormAlter(array &$form, FormStateInterface $form_state): void {
  $form['actions']['submit']['#submit'][] = [$this, 'entityViewDisplayEditFormSubmit'];
}
```
Adds a submit handler to the **Manage display** form (`/admin/structure/types/manage/<bundle>/display`).

## `entityViewDisplayEditFormSubmit` (the real work)
When the editor enables a *custom* view mode named `search_result` for a node bundle (i.e.
`search_result` is newly present in `modes.display_modes_custom` `#value` but not in its
`#default_value`), the handler:

1. Reads the bundled template
   `src/assets/config_templates/CONTENT_TYPE_NAME/core.entity_view_display.node.CONTENT_TYPE_NAME.search_result.yml`
   via `ModuleExtensionList::getPath('varbase_search')` + `file_get_contents()`.
2. Replaces every `CONTENT_TYPE_NAME` token with the real `$form['#bundle']` machine name (both in
   the config name and the YAML body).
3. Decodes the YAML and saves it as the editable config
   `core.entity_view_display.node.<bundle>.search_result` (`$this->configFactory->getEditable(...)->save()`).

Net effect: turning on the `search_result` view mode for a content type immediately gives that
bundle a ready-made search-result layout instead of an empty display.

## The template it applies
The shipped display (`src/assets/config_templates/.../search_result.yml`) is a Display Suite +
Field Group layout:

- Layout: DS `bs_1col` (single `col-sm-12` region).
- Fields shown: `search_api_excerpt`, `node_title` (linked, `h5`), `node_author`, `node_post_date`
  (short format), `node_link`; grouped under `group_authoring_information` and
  `group_content_wrapper` field groups.
- Hidden: `body`, `links`, `langcode`.
- Depends on modules `ds`, `field_group`, `user`, and on the bundle having fields `body`,
  `field_meta_tags`, `field_yoast_seo` and view mode `search_result`. On a bundle lacking those
  (or without `ds`/`field_group`), the resulting display config will have unmet dependencies.

Access to this behavior is gated by core's own permission for the display-settings form
(`administer node display`); the handler introduces no new access surface and reads a fixed bundled
file path (no user-supplied path).
