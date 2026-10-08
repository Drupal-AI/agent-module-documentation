# Configure per-domain logos

One settings form, one route:

- Route `domain_access_logo.settings` → `/admin/config/domain/domain_access_logo`
  (`domain_access_logo.routing.yml`), form `DomainAccessLogoSettingsForm`
  (`src/Form/DomainAccessLogoSettingsForm.php`, form id `domain_logo_settings`).
- Gated by permission `administer domains access logos` (see
  [../permissions/permissions.md](../permissions/permissions.md)).
- Reached from the Domain admin area: a local task (`domain_access_logo.admin`,
  base route `domain.admin`) and an admin menu link (`domain_access_logo.settings`,
  parent `domain.admin`).

## The form

`buildForm()` loads every Domain entity (`entity_type.manager` → storage `domain`,
`loadMultiple()`) and renders one upload widget per domain inside a `Domain Logo
Settings` details element:

| Widget property | Value |
|---|---|
| `#type` | `managed_file` |
| element key | the domain id (e.g. `default`, `example_com`) |
| `#title` | "Upload logo for Domain: {domain label}" |
| `#upload_validators` | `FileExtension` → `png gif jpg jpeg svg` |
| `#upload_location` | `public://files` |
| `#default_value` | current `logos.<domain_id>` from config |

If no Domain records exist yet, the form renders no upload widgets and instead
shows a message linking to the Domain records list (`domain.admin`).

## What submit does

`submitForm()` iterates domains (`loadOptionsList()`) and for each key:

- Writes `logos.<domain_id>` = the managed-file value (an array of file ids) into
  `domain_access_logo.settings`.
- If a file is present, loads it and calls `setPermanent()` + `save()` so it is not
  garbage-collected as a temporary upload.
- If the file id changed from the previously stored one, the previous file is
  deleted (`deletePreviousFile()` → `File::delete()`, errors logged to channel
  `domain_access_logo`). Clearing the widget also deletes the previous file.
- Finally invalidates the `system.site` cache tags so the branding block re-renders.

## Config object + schema

- Object: `domain_access_logo.settings`. Single top-level key `logos`.
- `logos` is a map of `domain_id` → an array holding one integer **file id**
  (the managed-file value), i.e. `logos.<domain_id>[0]` is the fid.
- Schema `config/schema/domain_access_logo.schema.yml`: `logos` is a `sequence` of
  `sequence` of `integer`.
- Note: the config stores file **ids**, not the files. Because the images are
  managed files on disk (`public://files`), they are not part of a config export.

## Set it with Drush / PHP

```php
// Assume file entity 42 is an already-saved, permanent image.
$config = \Drupal::configFactory()->getEditable('domain_access_logo.settings');
$config->set('logos.example_com', [42])->save();

// Make sure the file is permanent (the form does this for you):
$file = \Drupal::entityTypeManager()->getStorage('file')->load(42);
$file->setPermanent();
$file->save();

// Clear a domain's logo:
$config->set('logos.example_com', [])->save();
```

```bash
# Inspect current mapping:
drush config:get domain_access_logo.settings logos
```

After a scripted change, invalidate the site cache tags (or `drush cr`) so the
branding block picks up the new logo.

## Upgrading from 1.x

`domain_access_logo.install` defines `domain_access_logo_update_9001()`, which moved
the old top-level per-domain keys into the `logos` parent key. Run `drush updatedb`
after updating from a 1.x release.
