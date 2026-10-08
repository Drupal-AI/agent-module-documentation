# Edit field help text (and labels)

Field Help Text edits the **description** (help text) and, on the by-field form, the
**label** of configurable fields directly on their
`field.field.<entity_type>.<bundle>.<field_name>` config entities. There is no separate
settings object and no third-party settings — the text you enter becomes the field's own
`description`/`label`. All three routes require the `use fieldhelptext` permission.

## Landing page — `fieldhelptext` (`/admin/structure/fieldhelptext`)

`FieldhelptextController::main()` renders two link lists (no editing here):

- **Edit by Bundle** — every fieldable entity type / bundle that has at least one non-base
  field, linking to the by-bundle form.
- **Edit by Field** — every configurable field (from the `entity_field.manager` field map),
  linking to the by-field form, labelled `field_name (field_type)`.

Base fields are filtered out everywhere via `array_diff_key($fields, getBaseFieldDefinitions())`.

## By bundle — `fieldhelptext.bundle` (`Form\Bundle`, id `fieldhelptext_bundle`)

Path: `/admin/structure/fieldhelptext/by-bundle/{entity_type}/{bundle}`. One `textarea` per
non-base field on the bundle, pre-filled with the field's current `getDescription()` and
ordered by the default **form** display weight (from `entity_display.repository`). Submit
("Update help text") loops the fields; for each whose textarea differs from the stored
`description` it runs:

```php
$config = $field_definitions[$name]->getConfig($bundle);
$config->set('description', $value);
$config->save();
```

Only changed fields are saved, with a status message per change. Labels are **not** editable
on this form (there is an `@todo` in the source about adding that).

## By field — `fieldhelptext.field` (`Form\Field`, id `fieldhelptext_field`)

Path: `/admin/structure/fieldhelptext/by-field/{entity_type}/{field_name}`. Edits ONE field's
`label` + `description` across **every bundle** it appears on. Controls:

- `label` textfield and `description` textarea, defaulted from the first instance that has a
  non-empty value.
- `apply_to` checkboxes — one per bundle where the field exists, **all checked by default**;
  uncheck a bundle to leave that instance untouched. Each checkbox shows that instance's
  current label and description.

Submit writes, for each checked bundle whose label OR description differs from the entered
values:

```php
$configs[$bundle]->setLabel($label);
$configs[$bundle]->set('description', $description);
$configs[$bundle]->save();
```

This is the "update a reused field everywhere, but exclude the one bundle that needs different
wording" workflow.

## Input format

Both description fields accept the restricted markup core allows for any field description; the
form prints the allowed tag list via `FieldFilteredMarkup::displayAllowedTags()`. The form also
notes that the description supports tokens. Labels are plain text.

## Do it without the UI (drush / PHP)

The forms are thin wrappers over field config, so you can set the same values programmatically:

```php
// One field on one bundle.
$fc = \Drupal::service('entity_field.manager')
  ->getFieldDefinitions('node', 'article')['field_summary']->getConfig('article');
$fc->set('description', 'Shown in listings. Supports <em>basic</em> HTML.')->save();

// Or load the field_config entity directly and set label + description.
$fc = \Drupal::entityTypeManager()->getStorage('field_config')
  ->load('node.article.field_summary');
$fc->setLabel('Summary')->set('description', 'One or two sentences.')->save();
```

Run the same calls via `drush php:eval "…"`. Because these are config entities, edits appear in
`drush config:export` and should be deployed like any other config change (editing directly on
production creates config drift).

## Route parameters / 404 behavior

`{entity_type}`, `{bundle}`, and `{field_name}` are resolved by dedicated converters in
`src/ParamConverter/` (services `fieldhelptext.paramconverter.*`):

| Converter | `type` | Resolves to / returns NULL when |
|---|---|---|
| `EntityTypeConverter` | `entity_type` | the entity-type definition; NULL (404) if `getDefinition()` throws |
| `BundleConverter` | `bundle` | the bundle id if it exists for that entity type; else NULL (404) |
| `FieldNameConverter` | `field_name` | the field name if it has a storage definition; else NULL (404) |

So an unknown entity type, bundle, or field name 404s before a form is built.
