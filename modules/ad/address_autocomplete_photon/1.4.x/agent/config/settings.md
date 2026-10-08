<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configuration, routes & permissions

## Install & enable

```bash
composer require drupal/address_autocomplete_photon
drush en address_autocomplete_photon -y
```

Requires the **Address** module (`address:address`; composer `drupal/address: ^1.0 || ^2.0`),
which itself pulls in the `commerceguys/addressing` library. Core `^10.3 || ^11 || ^12`.

## Settings form

- Class `Drupal\address_autocomplete_photon\Form\SettingsForm` (`ConfigFormBase`), form id
  `address_autocomplete_photon_configure`.
- Route **`address_autocomplete_photon.configure`** → `/admin/config/system/address-autocomplete-photon`,
  requirement `_permission: 'administer address autocomplete photon'`.
- Menu link `address_autocomplete_photon.configure` (title *"Address autocomplete"*) under
  `system.admin_config_system` (*Configuration → System*), weight 50.
- Editable config: `address_autocomplete_photon.settings`.

## Config object: `address_autocomplete_photon.settings`

Install defaults (`config/install/address_autocomplete_photon.settings.yml`) and schema
(`config/schema/…`) define one `autocomplete` mapping:

| Key | Type | Default | Meaning |
|---|---|---|---|
| `autocomplete.min_length` | integer | `1` | Minimum characters typed before the Photon lookup fires (form field *"Autocomplete minimal input length"*). |
| `autocomplete.limit` | integer | `3` | Maximum number of suggestions shown in the dropdown. |
| `autocomplete.remove_duplicates` | boolean | `true` | Drop duplicate Photon results (e.g. a city that is also a state). |
| `autocomplete.managed_fields_display` | string | `hide` | How the auto-filled Address sub-fields are presented: `default` (visible & editable), `hide`, or `disable` (shown read-only). |

`SettingsForm::submitForm()` casts `min_length`/`limit` to `(int)`, `remove_duplicates` to
`(bool)`, and saves `managed_fields_display` as the raw radio value.

Config-export example:

```yaml
# address_autocomplete_photon.settings
autocomplete:
  min_length: 3
  limit: 5
  remove_duplicates: true
  managed_fields_display: hide
```

## Permissions (`address_autocomplete_photon.permissions.yml`)

- **`administer address autocomplete photon`** — `restrict access: TRUE`; gates the settings form only.
- **`override address fields`** — lets a user reveal and hand-edit the auto-filled Address
  sub-fields when a widget instance has `allow_overrides` enabled. Enforced server-side in
  `AddressAutocomplete::addressElements()`
  (`$element['#allow_overrides'] && \Drupal::currentUser()->hasPermission('override address fields')`)
  and reflected into `drupalSettings` so the client only shows the toggle button when both hold.

## Architecture notes

- The only server route is the admin settings form (permission-gated). There is **no** autocomplete
  proxy controller — the Photon request is issued directly by the browser to a **hardcoded** endpoint
  (`https://photon.komoot.io/api/`), which is not a config- or request-supplied URL. Self-hosting the
  Photon server requires patching the JS in this version.
