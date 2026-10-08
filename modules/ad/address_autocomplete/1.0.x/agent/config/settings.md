<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configuration

All configuration lives in the single config object **`address_autocomplete.settings`**
(schema: `config/schema/address_autocomplete.schema.yml`).

## Steps

1. Enable the module (requires `address`). Menu link: *Configuration → Content authoring →
   Address Autocomplete Settings*, route `address_autocomplete.settings`
   (`/admin/config/address-autocomplete`). Permission: **`administer address autocomplete`**
   (marked `restrict access: true`).
2. On the settings form, select **one active provider** (`tableselect`, single choice) — stored as
   `active_plugin`.
3. Click **Settings** next to a provider to open its per-provider form (dynamically registered route
   `admin/config/address-autocomplete/<plugin-url>`) and enter its credential.
4. On an `address` field's *Manage form display*, switch the widget to **Address autocomplete**. If no
   active provider is selected, the widget shows a warning linking back to the settings form.

## Config keys

```
address_autocomplete.settings:
  active_plugin: <plugin_id>            # e.g. google_maps
  google_maps:      { plugin_id, api_key }
  mapbox_geocoding: { plugin_id, token }
  post_ch:          { plugin_id, mode, username, password }   # mode: test|integration|production
  france_address:   { plugin_id, endpoint }                   # no credential needed
```

## Notes

- Credentials are stored as plain strings in this config object (Google `api_key`, Mapbox `token`,
  Post CH `username`/`password`). They are **not** wrapped in a Key entity, so they travel in config
  export/sync in cleartext — keep exported config out of untrusted hands and treat these as secrets in
  your deployment pipeline.
- The credential is used **server-side only** (Guzzle) and is never emitted to the browser or
  `drupalSettings`; the JS only ever calls the module's own Drupal routes.
- `hook_requirements()` (`address_autocomplete.install`) raises a warning if `post_ch` is configured
  without a `mode`. Update hooks `8800` (un-serialize plugin config) and `10001` (migrate the old
  Post CH `endpoint` URL to a `mode`) run on update.
- Post CH modes map to fixed Swiss Post hosts: `test`/`integration` → `webservices-int.post.ch`,
  `production` → `webservices.post.ch`.
