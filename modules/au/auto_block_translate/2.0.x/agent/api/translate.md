<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Translate route, form, access, and tab/operation

Everything this module adds hangs off one dynamically-registered route for `block_content`.

## Route (dynamic)

`src/Routing/AutoBlockTranslateRouteSubscriber.php` (service `auto_block_translate.subscriber`,
event `RoutingEvents::ALTER` at priority **-210** so it can inherit admin status). For each
content-translation-supported entity type it filters to `block_content` and adds:

- **Route name** `entity.block_content.auto_translation_add`
- **Path** `block/{block_content}/auto-translate-form`
- `_form` = `Drupal\auto_block_translate\Form\TranslationForm`, `_title` = "Automatic Translation"
- Requirements: `_access_auto_block_translation: block_content`, `block_content: \d+`
- Options: `_admin_route: TRUE`, param `block_content` upcast to `entity:block_content`.

## Access check

`src/Access/AutoBlockTranslateAccessCheck.php` (service `auto_block_translate.manage_access`,
`applies_to: _access_auto_block_translation`):

1. Loads the routed entity; if it is translatable, runs the entity type's own
   `translation.content_translation.access_callback` — if that returns allowed, access is allowed
   (inheriting its cacheability).
2. Otherwise falls back to `AccessResult::allowedIfHasPermission($account, $permission)` where
   `$permission` is `auto translate {entity_type_id}` (or `auto translate {bundle} {entity_type_id}`
   when the entity type's permission granularity is `bundle`). That permission is **defined by the
   parent** `auto_node_translate` module (`AutoNodeTranslatePermissions`), not here.
3. Non-translatable / no entity → `AccessResult::neutral()`.

## The form — `src/Form/TranslationForm.php`

- `FormBase`, id `auto_block_translate_form`. Injects the parent `Translator`, `language_manager`,
  `entity_type.manager`, `content_translation.manager`, `config.factory`,
  `plugin.manager.auto_node_translate_provider`, `datetime.time`, `current_user`.
- `buildForm()`: one checkbox per site language whose id differs from `$block_content->langcode`;
  label reads *"overwrite translation"* if the block already has that translation else *"new
  translation"*. Single **Translate** submit.
- `validateForm()`: sets an error if `auto_node_translate.settings:default_api` is empty
  ("translation API is not configured").
- `submitForm()`: reads the routed `block_content`, calls `autoBlockTranslateBlock()`, then
  redirects to `entity.block_content.canonical`.

### `autoBlockTranslateBlock(BlockContent $block_content, $translations)`

- Source lang = `$block_content->langcode->value`. Pulls `getExcludeFields()` and `getTextFields()`
  from the parent `Translator`; reads `default_api` from `auto_node_translate.settings`; creates the
  provider via `createInstance($default_api_id)`.
- For each selected language: `getTranslatedBlock()` returns the existing translation or
  `addTranslation()`. Per field, by field type:
  - text type in `getTextFields()` and name not excluded → `Translator::translateTextField(...)`.
  - `link` → `Translator::translateLinkField(...)`.
  - `entity_reference_revisions` → skipped here, handled in a second pass.
  - any other non-excluded field → value copied verbatim from the source.
- Second pass over all fields: `entity_reference_revisions` → `Translator::translateParagraphField()`
  (so referenced Paragraphs are translated once for all selected languages).
- Finalize: `setNewRevision(TRUE)`, `revision_log` = "Automatic translation using @api",
  `setRevisionCreationTime(request time)`, `setRevisionUserId(currentUser)`, `save()`.

Note: the actual translation, external-API call, endpoint, and credentials are entirely inside the
parent `Translator` / provider plugin (e.g. `MyMemoryTranslationApi`) — this module only orchestrates
field iteration and revision saving.

## Tab / operation / overview link — `auto_block_translate.module`

- `auto_block_translate_entity_operation()`: adds an **"Auto Translate"** operation (weight 51) on a
  `block_content` entity that has a `drupal:content-translation-overview` link template and passes
  `auto_node_translate_translate_access()`.
- `auto_block_translate_preprocess_links()`: on the block content-translation-overview dropbutton,
  injects an **"Add/Update automatic translation"** link to the same route (with a `destination`).
- Local task tab: `Plugin/Derivative/AutoBlockTranslateLocalTasks` deriver (referenced by
  `auto_block_translate.links.task.yml`, weight 101) puts an "Automatic Translation" tab under the
  block canonical route.
