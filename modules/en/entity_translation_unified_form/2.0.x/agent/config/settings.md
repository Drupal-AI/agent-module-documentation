<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configuration & settings

## Install & enable

```bash
composer require drupal/entity_translation_unified_form
drush en entity_translation_unified_form -y
```

Only dependency is core **`content_translation`** (which pulls in `language`). No sub-modules, no
permissions of its own, no Drush commands, **no config object / config schema** — every setting is
stored inside core Content Translation's per-bundle *bundle translation settings*.

## Where settings live (no config object)

All getters/setters in `entity_translation_unified_form.module` read and write through
`\Drupal::service('content_translation.manager')` (which implements
`BundleTranslationSettingsInterface`):

```php
$settings = $content_translation_manager->getBundleTranslationSettings($entity_type_id, $bundle);
$settings['entity_translation_unified_form_enable'] = $enabled;
$content_translation_manager->setBundleTranslationSettings($entity_type_id, $bundle, $settings);
```

So the ETUF flags ride along inside `language.content_settings.{entity_type}.{bundle}` third-party
settings; there is no `config/install/*` or `config/schema/*` in this module.

### Per-bundle setting keys and their accessors

| Setting key (in bundle translation settings) | Getter / setter fn (`.module`) | Meaning |
|---|---|---|
| `entity_translation_unified_form_enable` | `…_bundle_enabled` / `…_set_bundle_enabled` | Master on/off: inject all languages' fields into this bundle's add/edit form. |
| `entity_translation_unified_form_theme` | `…_bundle_display_mode` | Display-mode plugin id (`EntityTranslationUnifiedFormInlineMode` or `EntityTranslationUnifiedFormTabbedMode`). |
| `entity_translation_unified_form_language` | `…_language_display` | How the language is shown in field labels: `current`, `native`, or `code`. |
| `entity_translation_unified_form_translate_labels` | `…_translate_labels_enabled` / `…_set_…` | Also translate field labels/descriptions per language (Inline mode only). Forces config-override language while building each field. |
| `entity_translation_unified_form_sbs_enable` | `…_sbs_enabled` / `…_set_…` | Side-by-side two-column UI (node only). When on, mode is forced to Inline. |
| `entity_translation_unified_form_moderation_sync_disable` | `…_moderation_sync_disabled` / `…_set_…` | Disable the moderation-state sync JS (`js/sync.js`) for this bundle (node only). |
| `entity_translation_unified_form_save_only_button` | `…_save_only_button` / `…_set_…` | Add a "Save only" submit button (node only). |
| `entity_translation_unified_form_replace_node_edit_pages` | `…_replace_node_edit_pages` | Replace the node edit route so all languages' fields are reachable (node only). |

## UI 1 — Content language page (primary, all entity types)

Route **`language.content_settings_page`** = `/admin/config/regional/content-language` (this is the
module's `configure` link). `EntityTranslationUnifiedFormHooks::formLanguageContentSettingsFormAlter()`
alters `language_content_settings_form` and, **only if the current user has the
`administer content translation` permission**, adds, per translatable bundle, the checkboxes/selects
for `…_enable`, `…_theme`, `…_language`, `…_translate_labels`, and (node only) `…_sbs_enable`,
`…_moderation_sync_disable`, `…_save_only_button`, `…_replace_node_edit_pages`. `#states` hide each
control until *translatable* / *enable* are checked.

Non-node entity types (media, paragraph, taxonomy term, user, …) get the first four options here.

## UI 2 — Node-type edit form (node only, redundant path)

`formNodeTypeFormAlter()` adds `entity_translation_unified_form_form_node_type_form_process` to the
node-type form's `#process` and `…_form_node_type_form_submit` to its submit. The process callback
adds a **"Unified form"** fieldset under *Workflow* (visible only when the node type's
`language_content_type` equals `ENTITY_TRANSLATION_UNIFIED_FORM_ENABLED` = the core constant `4`,
i.e. translation enabled) containing `…_enable`, `…_translate_labels`, `…_sbs_enable`,
`…_moderation_sync_disable`, and (on edit, not add) `…_save_only_button`. Submit writes the same
bundle translation settings.

## Display-language label options

`entity_translation_unified_form_get_language_display_options()` → `current` (Current language),
`native` (Native language), `code` (Language code). Applied by the Inline plugin's `alterTitle()`
to suffix each cloned field's title, e.g. `Title (English)` / `Title (Français)` / `Title (fr)`.

## Display-mode options

`entity_translation_unified_form_get_mode_options()` reads all `EntityTranslationUnifiedFormMode`
plugin definitions (`admin_label` keyed by id). Ships `EntityTranslationUnifiedFormInlineMode`
(default) and `EntityTranslationUnifiedFormTabbedMode` — details in
[../plugins/form-modes.md](../plugins/form-modes.md).

## "Save only" button

When `…_save_only_button` is on, `formAlter()` adds a `saveonly` submit button whose handlers are
`::submitForm`, `::save`, `entity_translation_unified_form_entity_translation_unified_page_submit_save_only`.
The last handler redirects back to `entity.node.edit_form` for the same node (stripping any
`destination` query on `/edit?destination=/`).

## "Replace node edit"

When any node bundle has `…_replace_node_edit_pages` on,
`Routing\RouteSubscriber::alterRoutes()` repoints the core `entity.node.edit_form` route's
`_controller` to `ReplacementNodeEditController::getReplacementNodeEditPage()` and sets the `{node}`
parameter to `load_latest_revision => TRUE`. The controller always builds the **default-language**
edit form (`getTranslation(LanguageInterface::LANGCODE_DEFAULT)`), so translatable fields hidden on
non-default-language core edit forms stay reachable. The route's access **requirement** (core
`_entity_access: node.update`) is left unchanged. See
[../architecture/form-build-save.md](../architecture/form-build-save.md) for the access implications.

## Uninstall

`hook_uninstall` deletes legacy `state` keys `entity_translation_unified_form_enable_{node_type}`
for each node type (the module previously stored the flag in State).
