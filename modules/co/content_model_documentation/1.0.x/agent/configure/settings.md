# Configure: global settings

Form `ContentModelDocumentationConfigForm` (form id `cm_document_config_form`) at route
`entity.cm_document.config_form` → `/admin/config/system/cm_document`. Requires permission
`administer content model documentation`. This same route is the `field_ui_base_route` for the
`cm_document` entity, so Field UI "Manage fields / form display" for cm_document hang off it.

Editable config object: **`content_model_documentation.settings`** (via
`getEditableConfigNames()`).

## Keys

| Key | Type | Meaning |
| --- | --- | --- |
| `block` | bool | Make `block_content` bundles documentable (checkbox disabled unless `block_content` enabled). |
| `field` | bool | Make fields documentable (needs `field`). |
| `media` | bool | Make media types documentable (needs `media`). |
| `menu` | bool | Make menus documentable (needs `menu_link_content`). |
| `modules` | bool | Make modules documentable (always available). |
| `node` | bool | Make node content types documentable (needs `node`). |
| `paragraph` | bool | Make paragraph types documentable (needs `paragraphs`). |
| `taxonomy` | bool | Make vocabularies documentable (needs `taxonomy`). |
| `view` | bool | Make views documentable (needs `views`). |
| `export_location` | string | Machine name of a **local custom module** to hold exported/imported cm_document YAML (files land in `<module>/cm_documents/`). |

For each entity-type checkbox, if the backing module is not enabled the checkbox is disabled
and the stored value is forced to `NULL` on submit. Whichever types are enabled here control
the option list of the cm_document `documented_entity` field (see
`DocumentableEntityProvider::getUnDocumentedEntities`).

## Set without the UI

```bash
drush cset content_model_documentation.settings node 1 -y
drush cset content_model_documentation.settings export_location my_local_module -y
```

```php
\Drupal::configFactory()->getEditable('content_model_documentation.settings')
  ->set('node', TRUE)
  ->set('export_location', 'my_local_module')
  ->save();
```

## Schema caveat

`config/schema/cm_document.schema.yml` defines only `cm_document.settings` (an empty
`config_object` mapping) — that key is **not** the object the form actually writes. The live
settings object `content_model_documentation.settings` ships no typed-schema of its own, so
its keys are schema-less. Functionally harmless for operation; note it if you validate config
schema.
