# The `geo_entity` entity (API)

Class `Drupal\geo_entity\Entity\GeoEntity` extends `RevisionableContentEntityBase` implements
`GeoEntityInterface` (+ `EntityChangedTrait`). Content entity type id `geo_entity`.

## Definition highlights

- Tables: `geo_entity` (base), `geo_entity_field_data`, `geo_entity_revision`, `geo_entity_field_revision`.
- `translatable = TRUE`, `show_revision_ui = TRUE`.
- `admin_permission = "access geo overview"`.
- Access handler: `Drupal\geo_entity\GeoEntityAccessControlHandler` (see permissions doc).
- Forms: add/edit = `GeoEntityForm`, delete = core `ContentEntityDeleteForm`.
- Bundle entity `geo_entity_type`; `field_ui_base_route = entity.geo_entity_type.edit_form`.

## Base fields (`baseFieldDefinitions()`)

| Field | Type | Notes |
|---|---|---|
| `status` | boolean | default TRUE ("Enabled"), revisionable |
| `uid` | entity_reference → user | author/owner; autocomplete widget |
| `created` | created | authored-on timestamp |
| `changed` | changed | last edited |
| `label` | string (max 1275) | required, translatable; form widget in `hidden` region — usually set from the bundle `label_token` |

All the geographic data (geofield `location`, `postal_address`, `geo_file`, `external_id`, `accessibility`)
are **configurable fields added by the submodules / Field UI**, not base fields.

## Owner & label behavior

- `preCreate()` defaults `uid` to the current user, so a geo is owned by its creator.
- Implements the standard owner methods (`getOwner`, `getOwnerId`, `setOwnerId`, `setOwner`) — this drives the
  *edit own / delete own* access checks.
- `preSave()` applies the bundle `label_token` template through Token and stores the plain-text result as
  `label` (see configure/geo-types.md).
- `isEnabled()` / `setStatus()` wrap the `status` field.

## Create programmatically

```php
$geo = \Drupal::entityTypeManager()->getStorage('geo_entity')->create([
  'bundle' => 'address',
  'label' => 'Fallback label',   // overwritten by label_token if the bundle sets one
]);
$geo->save();                     // uid auto-set to current user
```

## Address autocomplete route (used by geo_entity_address)

`geo_entity.autocomplete` — path `/geo_entity/{settings_key}`, controller
`AutocompleteController::autocomplete`. Route `_access: 'TRUE'`, but the controller enforces access itself,
mirroring core's entity autocomplete: `{settings_key}` is an HMAC (`Crypt::hmacBase64(serialize($settings),
Settings::getHashSalt())`) of the selection settings stored in the `geo_entity_address_autocomplete`
key/value store; the controller recomputes the HMAC and `hash_equals()`-compares it, throwing
`AccessDeniedHttpException` on mismatch or missing key. It reads the typed `q` (a JSON address), builds an
address string, and geocodes it via the configured Geocoder providers, returning JSON suggestions with a
`drupal_address` mapping. `NUMBER_STREET_COUNTRIES` controls house-number-before-street formatting.

## Theming

- Theme hook `geo_entity` (render element), template `geo-entity.html.twig`.
- `hook_theme_suggestions_geo_entity`: `geo_entity__<view_mode>`, `geo_entity__<bundle>`,
  `geo_entity__<bundle>__<view_mode>`.
- `template_preprocess_geo_entity()` maps child elements into `content`.
