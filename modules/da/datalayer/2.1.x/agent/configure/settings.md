# Configure datalayer

All behavior lives in the `datalayer.settings` config object. Edit via the form
(`/admin/config/search/datalayer`, route `datalayer.settings_form`, permission
`administer site configuration`) or with drush/config.

```bash
drush cget datalayer.settings                         # dump all settings
drush cset datalayer.settings output_terms true -y    # toggle a boolean
drush cset datalayer.settings entity_type contentType -y   # rename a JSON key
```

## Settings keys (config: `datalayer.settings`)

| Key | Type | Default | Effect |
|---|---|---|---|
| `add_page_meta` | bool | `true` | Emit entity metadata for the page's route entity. |
| `output_terms` | bool | `true` | Add taxonomy terms the entity references (under `entityTaxonomy`). |
| `output_fields` | bool | `false` | Add values of fields opted in via their per-field expose setting. |
| `remove_from_admin_routes` | bool | `true` | Suppress the dataLayer on admin routes. |
| `lib_helper` | bool | `false` | Attach Google's `data-layer-helper` library (`datalayer/helper`). |
| `group` | bool | `false` | Add owning Group name (needs `group` module) for nodes. |
| `entity_meta` | string[] | `[]` | Entity property names output for **all** entity types (e.g. `created`, `changed`, `uid`). |
| `vocabs` | string[] | `[]` | Limit `output_terms` to these vocabulary ids (empty = all). |
| `enable_ia` | bool | `false` | Output URL-path components as IA categories. |
| `ia_depth` | int | `3` | How many path components to emit. |
| `ia_category_primary` | string | `primaryCategory` | Key for the first path component. |
| `ia_category_sub` | string | `subCategory` | Key prefix for subsequent path components (`subCategory1`, `subCategory2`, …). |
| `expose_user_details` | string | `''` | URL pattern(s) (Drupal path-match syntax) on which current-user data is exposed. Empty = never. |
| `expose_user_details_roles` | string[] | `[]` | Restrict user exposure to these roles (empty = all roles). |
| `current_user_meta` | string[] | `[]` | User property names to output when exposed. |
| `expose_user_details_fields` | bool | `false` | Also output exposed user field values (`userFields`). |
| `key_replacements` | map | `[]` | Rename exposed field sub-keys before output. |

### Output JSON key labels (rename to match your data contract)

Each of these is the literal JSON key the value is pushed under:

| Key | Default JSON key |
|---|---|
| `entity_type` | `entityType` |
| `entity_bundle` | `entityBundle` |
| `entity_identifier` | `entityId` |
| `entity_title` | `entityTitle` |
| `group_label` | `groupLabel` |
| `drupal_language` | `drupalLanguage` |
| `drupal_country` | `drupalCountry` |
| `site_name` | `siteName` |

## What always outputs

Even with no entity, the defaults push: `drupalLanguage`, `drupalCountry`, `siteName`
(from `system.date` / `system.site`) and `userUid` (current user id).

## Expose a single field's value

Fields are opted in individually — there is no global "all fields" switch; `output_fields`
only publishes fields that carry the third-party setting. On the field settings form
(e.g. `field_config_edit_form`) the module adds an **Expose to dataLayer** checkbox and a
label. In config this is stored as a third-party setting on the field:

```yaml
# field.field.<entity>.<bundle>.<field>.yml
third_party_settings:
  datalayer:
    expose: 1
    label: mySku
```

Then set `output_fields: true`. Disabling expose auto-removes the stored settings on save.

## Verify current output (drush, no browser needed)

```bash
drush php:eval 'require_once DRUPAL_ROOT."/modules/contrib/datalayer/datalayer.module"; print json_encode(_datalayer_defaults());'
```
