<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The `real_estate` content entity

Class: `\Drupal\styled_google_map_demo\Entity\RealEstate` (`@ContentEntityType`).
Handlers: view builder (core), list builder `RealEstateListBuilder`, forms
(`RealEstateForm` for default/add/edit, `RealEstateDeleteForm`), access handler
`RealEstateAccessControlHandler`, route provider `RealEstateHtmlRouteProvider`
(extends `AdminHtmlRouteProvider`, adds the settings route).

## Base fields (`baseFieldDefinitions()`)

| Field | Type | Notes |
|---|---|---|
| `id` / `uuid` | int / uuid | keys |
| `user_id` | entity_reference (user) | author |
| `name` | string | the **label** (`entity_keys.label = name`) |
| `price` | integer | |
| `location` | **geofield** | the point rendered on the styled map |
| `category` | entity_reference | → `real_estate` taxonomy vocabulary |
| `status` | boolean | published flag |
| `created` / `changed` | created / changed | timestamps |

## Create one in code

```php
use Drupal\styled_google_map_demo\Entity\RealEstate;

$estate = RealEstate::create([
  'name' => 'Maple House',
  'price' => 250000,
  'location' => 'POINT (-121.43 38.63)', // WKT, as geofield stores
  'status' => 1,
]);
$estate->save();
```

Load / delete: `RealEstate::load($id)`, `$estate->delete()`. The `real_estate`
vocabulary's terms carry an image `field_icon`; the parent module can use each category's
icon as that marker's pin. Manage per-bundle display at
`/admin/structure/real_estate/settings` (`field_ui_base_route = real_estate.settings`).

There is no service API and no hooks here — this submodule is a demonstration entity type,
not an extension point. The parent module's real API is in
[`../../../../../2.7.x/agent/start.md`](../../../../../2.7.x/agent/start.md).
