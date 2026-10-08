# Configure the Blue Billywig connection

Global settings form: route `blue_billywig.settings` → `/admin/config/media/blue-billywig`
(permission `administer blue_billywig`). Config object `blue_billywig.settings` (schema
`config/schema/blue_billywig.schema.yml`). Class `Form\SettingsForm` (extends `ConfigFormBase`).

## Settings keys

Defaults ship in `config/install/blue_billywig.settings.yml`.

| Key | Type | Default | Meaning |
|---|---|---|---|
| `publication` | string | `null` | Publication **subdomain** (e.g. `example` for `https://example.bbvms.com`). Required. On save, `https://`, `http://` and `.bbvms.com` are stripped from the entered value. |
| `client_id` | string | `null` | Optional client identifier; filters API/search results (`klantnaam`) to this publication/client. |
| `key` | integer | `null` | API **key ID** (the id related to the secret). Required. |
| `secret` | string | `null` | API secret. Field is a `password` input; leave blank on the form to keep the stored value (only overwritten when a new value is typed). |
| `playout` | string | `null` | Site default playout id (dropdown populated from `client->playouts()`). |
| `embed_type` | string | `javascript` | Default embed type: `javascript` or `iframe` (`SettingsForm::EMBED_TYPES`). |
| `debug` | bool | `false` | Enable upload debug logging to the browser console (Uppy widget). |
| `enable_accessibility` | bool | `true` | Show the Scribit.Pro accessibility request option on BB media. |
| `enable_content_protection` | bool | `true` | Show the content-protection policy selector (`field_bb_cpp` widget). |
| `enable_delete_sync` | bool | `true` | Delete the OVP mediaclip when the Drupal media entity is deleted (skipped if another media entity still references the same clip). |

## Validation & save behaviour

- `validateForm()` calls `client->validateApi(key, secret, publication)`, which does a live
  `GET /sapi/playout` against the platform; invalid credentials block the save with an error on
  key/secret/publication.
- `submitForm()` normalizes the publication (strips scheme + `.bbvms.com`), only writes `secret` when
  a new one was entered, then invalidates cache tags `blue_billywig:embed`,
  `blue_billywig:playouts`, `blue_billywig:cpp_policies` (playout/embed changes affect embed output).
- Runtime health: `hook_requirements` (in `blue_billywig.install`) calls `client->playouts()` and
  reports OK / error on the *Status report* depending on whether the API answers.

## Migrating from AWS-credential versions

Older releases stored AWS S3 credentials. `blue_billywig_update_10002` removes those keys
(`aws_access_key_id`, `aws_secret_access_key`, `aws_s3_bucket_url`, `aws_s3_upload_prefix`,
`aws_s3_region`, `aws_s3_endpoint`, `aws_debug`) and migrates `aws_debug` → `debug`. Uploads now use
the Blue Billywig SAPI for presigned S3 URLs, so no AWS credentials are needed. Run
`drush updatedb && drush cache:rebuild` after updating code.

## Setting values without the UI

```
ddev drush config:set blue_billywig.settings publication example -y
ddev drush config:set blue_billywig.settings embed_type iframe -y
```

The secret can also be overridden out of config via `settings.php`
(`$config['blue_billywig.settings']['secret'] = getenv('BB_SECRET');`).
