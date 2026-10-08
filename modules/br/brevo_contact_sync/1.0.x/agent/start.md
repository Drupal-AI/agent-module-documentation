<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Brevo Contact Sync (brevo_contact_sync) — agent index

Pushes each saved Drupal **user** to a **Brevo** (formerly Sendinblue) contact and adds it to a
chosen Brevo list. A thin bridge over the **`sendinblue_api`** module (hard dependency — supplies
the API key and list/custom-field lookups). Package `Sendinblue`. Core `^10 || ^11`. License
GPL-2.0-or-later. Version 1.0.2. No composer.json, no submodules.

- **Mapping form, config object/keys, route & permission** → [config/settings.md](config/settings.md)
- **The presave sync hook, field-type value extraction, create-vs-update** → [api/sync.md](api/sync.md)

## What it actually is (from source)

- **One config form**: `src/Form/BrevoContactMappingForm.php` (`BrevoContactMappingForm extends
  ConfigFormBase`, form id `user_mapping_config_form`). Route **`brevo_contact_sync.mapping`** at
  `/admin/config/services/sendinblue-api/contact-mapping`, permission
  **`administer sendinblue api configuration`** (defined by `sendinblue_api`, not here),
  `_admin_route: TRUE`. Registered as a menu link and as a **local task** under the
  `sendinblue_api.config` base route.
- **One hook**: `brevo_contact_sync_entity_presave()` in `brevo_contact_sync.module` — the entire
  sync engine, runs on every entity presave and acts only when `bundle() == "user"`.
- **Writes one config object**: `brevo_contact_sync.settings` with keys `mappings` (array of
  `{user_field, ref_value, mapping_field}`) and `selected_list` (Brevo list id).
- **No** services, **no** permissions of its own, **no** plugins, **no** Drush, **no** install
  file, **no** `config/` (no schema, no defaults), **no** routes beyond the form.

## Dependencies / libraries

- Drupal module dep: `sendinblue_api` (the "Brevo: Digital Marketing Tool" project). The form
  injects `sendinblue_api` service, `cache.default` and `entity_field.manager`.
- The presave hook uses the **official Brevo PHP SDK** classes (`Brevo\Client\Configuration`,
  `Brevo\Client\Api\ContactsApi`, `Model\CreateContact`, `Model\UpdateContact`) — provided
  transitively via `sendinblue_api`; the SDK's default Guzzle client performs the HTTPS calls.
- Note: the form file has an unused `use Drupal\brevo_contact_sync\Service\FieldsDefinition;` — no
  such class ships in this module.
