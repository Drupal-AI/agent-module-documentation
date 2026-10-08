# Configure Webform Content Creator entities

## Admin UI

*Configuration → Webform Content Creator* (`admin/config/webform_content_creator`, route
`webform_content_creator.collection`, permission `access webform content creator configuration`).

1. **Add configuration** — give it a title, pick a **Webform** and a **Content type**
   (target bundle). Save.
2. **Manage fields** (`.../manage/{id}/fields`) — set the created content's **Title** (tokens
   allowed), then tick each target field you want to populate and choose the webform element (or a
   custom token value) that feeds it, plus its mapping plugin.

Routes (all require the same permission): `add_form`, `edit_form`, `delete_form`,
`manage_fields_form`, `collection`, `overview` (both bare and `entity.webform_content_creator.*`
variants exist).

## The config entity — `webform_content_creator`

Class `Entity\WebformContentCreatorEntity`. Config name
`webform_content_creator.webform_content_creator.<id>`. Fields (schema
`config/schema/webform_content_creator.yml`):

| Field | Meaning |
|---|---|
| `id`, `title` | Machine name / label. |
| `webform` | Source webform id. |
| `target_entity_type` | Entity type to create (default `node`). |
| `target_bundle` | Bundle to create (e.g. `article`). |
| `content_type` | Legacy bundle field (kept for BC; `target_bundle` is authoritative). |
| `field_title` | Legacy title field (title now lives in `elements['title']`). |
| `elements` | The per-field mapping map (see below). Schema type `ignore`. |
| `sync_content` | Update the created content when the submission is edited. |
| `sync_content_delete` | Delete the created content when the submission is deleted. |
| `sync_unique` | Update an existing entity matched on a unique field instead of creating new. |
| `sync_content_field` | The content field holding the submission id used for sync/unique. |
| `use_encrypt` / `encryption_profile` | Encrypt mapped values via the Encrypt module. |
| `redirect_to_entity` | Redirect the submitter to the created entity. |
| `redirect_to_entity_message` / `..._on_update` | Messages shown on redirect. |

### `elements` mapping structure

Keyed by target field machine name (plus a special `title` key). Each entry:

```yaml
elements:
  title:
    type: false
    webform_field: ''
    custom_check: true
    custom_value: '[webform_submission:values:subject]'
    mapping: default_mapping
  body:
    type: 'textarea'          # source webform element type
    webform_field: 'message'  # source webform element key
    custom_check: false       # if true, use custom_value (token) instead of the webform value
    custom_value: ''
    mapping: default_mapping   # field mapping plugin id
```

`createContent()` iterates `elements`, and for each entry resolves the value (from
`webform_field` or `custom_value` tokens) and applies it through the chosen `mapping` plugin.

## How it fires

`hook_webform_submission_insert/update/delete` (in `.module`) load all
`webform_content_creator` config entities whose `webform`, entity type, and bundle match the
submission, then call `createContent()` (insert / draft→final), `updateContent(..., 'edit')`, or
`updateContent(..., 'delete')`. Drafts are ignored until finalized.

## Token

`hook_token_info`/`hook_tokens` add `[webform_submission:unmapped_values]` — renders all submission
values not already mapped (useful to dump the rest into a body field).

## Drush / config

```
drush config:get webform_content_creator.webform_content_creator.<id>
```

There is no Drush command; create/edit via the UI or config import.
