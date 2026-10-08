# Licenses & configuration

## Admin UI & permission
- Route `entity.attribution_license.collection` → `/admin/structure/attribution-license`
  (the `configure` route). All license routes require the **`administer attribution_license`**
  permission (title "Administer license"; the config entity's `admin_permission`).
- Collection-page action links:
  - **Add license** → `entity.attribution_license.select_form` →
    `/admin/structure/attribution-license/add` (SPDX import via `AttributionLicensesForm`).
  - **Add custom license** → `entity.attribution_license.add_form` →
    `/admin/structure/attribution-license/add-custom` (blank entity form `attribution_license.add`).
  - Per license: **Edit** (`edit_form`, `/{id}`) and **Delete** (`delete_form`, `/{id}/delete`).
- Menu link `entity.attribution_license.overview` under *Structure*.

> Route note vs 1.1.x: the SPDX import form now lives at `entity.attribution_license.select_form`
> (`/add`); the blank custom-entity form is `entity.attribution_license.add_form` (`/add-custom`).

## The `attribution_license` config entity
`src/Entity/AttributionLicense.php`, config prefix `attribution.attribution_license.<id>`.
Exported fields (schema `attribution.attribution_license.*`):

| Field | Type | Meaning |
|---|---|---|
| `id` | string | machine id (also config key) |
| `identifier` | string | SPDX identifier, e.g. `CC-BY-4.0` |
| `name` | label | human name |
| `osiCertified` | bool | OSI-approved |
| `deprecated` | bool | SPDX deprecation status |
| `link` | string | URL to the license text (may be empty) |

Ten defaults install from `config/install`: `all_rights_reserved`, `cc0_1_0`, `cc_by_4_0`,
`cc_by_nc_4_0`, `cc_by_nc_nd_4_0`, `cc_by_nc_sa_4_0`, `cc_by_nd_4_0`, `cc_by_sa_4_0`,
`gpl_2_0_or_later`, and (new in 1.2) `unknown_unasserted` (identifier `Uncertain`,
name "Uncertain copyright status", empty link).

## Importing SPDX licenses
`AttributionLicensesForm` (route `entity.attribution_license.select_form`,
`/admin/structure/attribution-license/add`) lists all licenses from the bundled
`composer/spdx-licenses` package (400+) in a multi-select. Selected ones are created as config
entities; the machine `id` is transliterated from the SPDX identifier. Re-importing an existing
license catches the save exception and shows "already exists" rather than duplicating.

## Restricting licenses per field
An `attribution` field has a field setting `licenses` (multi-select of license ids;
`AttributionItem::fieldSettingsForm`, default `[]`). If set, the field's widget only offers those
licenses; if empty, all licenses are offered. Stored under schema `field.field_settings.attribution`
(also carries an optional `default` license key).

## Creating a license in code
```php
\Drupal\attribution\Entity\AttributionLicense::create([
  'id' => 'cc_by_4_0',
  'identifier' => 'CC-BY-4.0',
  'name' => 'Creative Commons Attribution 4.0 International',
  'osiCertified' => FALSE,
  'deprecated' => FALSE,
  'link' => 'https://spdx.org/licenses/CC-BY-4.0.html#licenseText',
])->save();
```

## Update hook
`attribution_update_10001` (in `attribution.install`) ALTERs existing `attribution` field tables
to add the five AI columns (`creation_type`, `ai_tool`, `ai_prompt`, `prompt_editor_name`,
`prompt_editor_link`) and installs the `unknown_unasserted` license if missing. Run `drush updb`
after updating from 1.1.x.
