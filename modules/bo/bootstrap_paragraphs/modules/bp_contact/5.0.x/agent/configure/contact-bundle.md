<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The `bp_contact` bundle — fields, wiring, and the D11 situation

No settings form (`configure: null`). Everything is config, shipped in **`config/install/`**.

## Why it will not install on Drupal 11

```yaml
# bp_contact.info.yml
core_version_requirement: ^8 || ^9 || ^10
dependencies:
  - bootstrap_paragraphs:bootstrap_paragraphs
  - contact_formatter:contact_formatter
  - drupal:contact
  - paragraphs:paragraphs
```

Two blockers: the core constraint excludes `^11`, and `contact_formatter` is a separate
contrib project (`drupal/contact_formatter`) that `drupal/bootstrap_paragraphs` does not pull
in. Observed failure on the D11 documentation site:

```
Unable to install modules: module 'bp_contact' is missing its dependency module contact_formatter.
```

## Config objects it would install

| Config name | What it is |
|---|---|
| `paragraphs.paragraphs_type.bp_contact` | the bundle — `id: bp_contact`, `label: 'Contact Form'` |
| `field.storage.paragraph.bp_contact` | `entity_reference` → `contact_form`, cardinality 1 |
| `field.field.paragraph.bp_contact.bp_contact` | the reference instance |
| `field.field.paragraph.bp_contact.bp_background` | shared list field |
| `field.field.paragraph.bp_contact.bp_width` | shared list field |
| `core.entity_form_display.paragraph.bp_contact.default` | form display |
| `core.entity_view_display.paragraph.bp_contact.default` | view display |

Note the bundle YAML is minimal — it has **no `icon_uuid`, `description` or
`behavior_plugins` keys**, unlike the newer sibling bundles.

## Fields

| Field | Type | Target | Notes |
|---|---|---|---|
| `bp_contact` | `entity_reference` | **`contact_form`** (core config entity) | cardinality 1 |
| `bp_background` | `list_string` | — | storage owned by parent, 58 values |
| `bp_width` | `list_string` | — | storage owned by parent, 5 values |

`field.field.paragraph.bp_contact.bp_contact`:

```yaml
settings:
  handler: 'default:contact_form'
  handler_settings:
    target_bundles: null      # any contact form on the site
    auto_create: false
```

`target_bundles: null` means every `contact_form` entity is selectable — including core's
`personal` form. Restrict it by setting an explicit map.

## Form display

All three fields use `options_select`; `bp_background` weight 0, `bp_width` 1, `bp_contact` 2.
Hidden: `created`, `status`, `uid`.

## View display — where `contact_formatter` is used

```yaml
content:
  bp_background: { type: list_key, label: hidden, weight: 0 }
  bp_width:      { type: list_key, label: hidden, weight: 1 }
  bp_contact:    { type: contact_field_formatter, label: hidden, weight: 2 }
dependencies:
  module: [contact_formatter, options]
```

`contact_field_formatter` comes from the `contact_formatter` project and renders the
referenced contact form as a **real, submittable form**. Without it the field would fall back
to a label. There is no `paragraph--bp-contact.html.twig` — output uses the generic paragraph
template.

## Recreating the bundle on Drupal 11

The shipped YAML is a usable blueprint. Minimum viable equivalent, without `contact_formatter`:

```php
use Drupal\paragraphs\Entity\ParagraphsType;
use Drupal\field\Entity\FieldStorageConfig;
use Drupal\field\Entity\FieldConfig;

ParagraphsType::create(['id' => 'my_contact', 'label' => 'Contact Form'])->save();

FieldStorageConfig::create([
  'field_name' => 'field_my_contact',
  'entity_type' => 'paragraph',
  'type' => 'entity_reference',
  'cardinality' => 1,
  'settings' => ['target_type' => 'contact_form'],
])->save();

$fc = FieldConfig::create([
  'field_name' => 'field_my_contact',
  'entity_type' => 'paragraph',
  'bundle' => 'my_contact',
  'label' => 'Contact Form',
]);
$fc->setSetting('handler', 'default:contact_form');
$fc->setSetting('handler_settings', ['target_bundles' => NULL, 'auto_create' => FALSE]);
$fc->save();
```

Then choose how to render it: install a D11-compatible contact-form formatter, or render the
form yourself from a preprocess/controller with
`\Drupal::service('entity.form_builder')->getForm($message)` where `$message` is a
`contact_message` entity created for the referenced form.

## Read the shipped config without installing

```bash
cat web/modules/contrib/bootstrap_paragraphs/modules/bp_contact/config/install/paragraphs.paragraphs_type.bp_contact.yml
cat web/modules/contrib/bootstrap_paragraphs/modules/bp_contact/config/install/field.field.paragraph.bp_contact.bp_contact.yml
```
