<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configuration & rendering reference

## `webform_extra_field.settings` (config object)

Single key, `webform_extra_field_admin` — a nested sequence choosing which bundles may use the
extra field. Written by `WebformExtraFieldSettingsForm` (`administer webform extra field`),
read by `hook_extra_field_display_info_alter()`.

```yaml
webform_extra_field_admin:
  node:
    article: article        # truthy = enabled for node.article
    page: 0                 # unchecked
  taxonomy_term:
    tags: tags
```

Schema (`config/schema/webform_extra_field.schema.yml`): `webform_extra_field.settings` is a
`config_object` whose `webform_extra_field_admin` is a `sequence` of per-entity-type `sequence`s of
string bundle values. The settings form only lists entity types that are
`ContentEntityType` **and** define a `field_ui_base_route` (i.e. fieldable content entities that
have a Manage Display), so config/config-only entity types never appear.

`hook_extra_field_display_info_alter()` iterates that map and, for each truthy bundle, appends
`"$entity_type_id.$bundle_id"` to `$info['webform_extra_field_display']['bundles']`, which is what
makes the `webform_extra_field_display` Extra Field Plus plugin available on that bundle's Manage
Display. Removing a bundle here removes the pseudo-field option from that bundle.

## Per-display setting (`webform_id`)

The actual form choice lives in the **entity view display** config for the bundle/view mode (managed
by Extra Field Plus), not in `webform_extra_field.settings`. `WebformExtraFieldDisplay`:

- `extraFieldSettingsForm()` adds a `#type => select` named **`webform_id`**, options built from
  `Webform::loadMultiple()` (`id => label`), with an empty option `- None -` whose value is `_none`.
- `defaultExtraFieldSettings()` defaults `webform_id` to `_none`.
- `getExtraFieldComponentId()` ensures the component id is prefixed with `extra_field_`.

## Render path (`view()`)

```php
$webform_id = $this->getEntityExtraFieldSetting('webform_id');
if ($webform_id != '_none') {
  $webform = Webform::load($webform_id);
  if ($webform) {
    return \Drupal::entityTypeManager()->getViewBuilder('webform')->view($webform);
  }
}
return [];
```

Consequences:

- If `webform_id` is `_none`, or the referenced webform no longer exists, the field renders nothing
  (empty array) — no error.
- The form is rendered by the **standard `webform` view builder**, so it inherits Webform's own
  access checks, open/close scheduling, submission limits, draft/confirmation handling and CSRF
  token — this module adds no access logic of its own around the form.
- The chosen webform is **the same for every entity** of that bundle+view mode. The host entity is
  **not** passed to the webform; there is no source-entity wiring. To record which host the
  submission came from, do it inside the webform (hidden element from a token/query parameter, or a
  handler), not here.

## Placement quick steps

1. `/admin/config/system/webform-extra-field` → tick the bundle(s) → Save.
2. `admin/structure/types/manage/<bundle>/display` (or the equivalent Manage Display for the entity
   type, per view mode) → drag **Webform** out of *Disabled* → gear/settings → pick the webform →
   Update → Save.
