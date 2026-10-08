<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configure Loqate

Two admin forms, both gated by the `administer loqate api` permission and living under
`/admin/config/services/loqate-api`.

## 1. API key — `LoqateApiKeyConfigForm`

- Route `loqate.loqate_api_key_config_form`, path `/admin/config/services/loqate-api`.
- A single `key_select` (Key module) element. Choose the **Key entity** holding your Loqate API key.
- Saved to config **`loqate.loqateapikeyconfig`**, key `loqate_api_key` = the **Key entity id**
  (schema `loqate.schema.yml`, nullable string).
- `Loqate::getApiKey($key_id = NULL)` reads this id and returns the underlying key **value** via the
  Key repository. Passing a `$key_id` overrides it (used by per-widget key overrides).

Set up the key + config via Drush:
```bash
ddev drush key:save loqate_api_key --label='Loqate API key' --key-type=authentication \
  --key-provider=config --key-value='YOUR_LOQATE_KEY' -y
ddev drush cset loqate.loqateapikeyconfig loqate_api_key loqate_api_key -y
```

## 2. PCA address field mapping — `PcaAddressSettingsForm`

- Route `loqate.settings_form`, path `/admin/config/services/loqate-api/pca-address`.
- A draggable table mapping each **address element** to a **Loqate field** with a **mode** and
  **enabled** flag. Saved to config **`loqate.settings`**, key `pca_fields` (a sequence).

Each `pca_fields` row:
| Field | Meaning |
|---|---|
| `element` | Address element key (`locality`, `postal_code`, `address_line1`, `country_code`, `organization`, `dependent_locality`, `administrative_area`, `sorting_code`). |
| `field` | Loqate response field name (`City`, `PostalCode`, `Line1`, `Line2`, `Company`, …) or empty. |
| `mode` | Population mode int — `PcaAddressMode`: NONE=0, SEARCH=1, POPULATE=2, DEFAULT=3, PRESERVE=4, COUNTRY=8. |
| `enabled` | Whether this mapping is applied. |

Shipped defaults (`config/install/loqate.settings.yml`) enable City→locality, PostalCode→postal_code,
Line1/Line2→address_line1/2, Company→organization (all mode 2 = POPULATE); the rest disabled.

## Per-widget / per-element key override

The field widget settings (`PcaAddressFieldWidgetTrait`) and the element's `#pca_options['key']` can
name a **different** Key entity. If it is empty or cannot be resolved, `Loqate::getApiKey()` falls
back to the default configured above.

## Notes / gotchas

- The **key value** is exposed to the browser in `drupalSettings` because Loqate's SDK runs
  client-side (there is no server proxy). Use a Loqate key restricted to your domain(s).
- The external SDK host `api.addressy.com` is fixed in `loqate.libraries.yml`; add it to your CSP or
  self-host the asset.
