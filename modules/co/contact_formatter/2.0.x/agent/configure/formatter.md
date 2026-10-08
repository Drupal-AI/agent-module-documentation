<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Render a contact form inline with `contact_field_formatter`

The module has **no configure route** (`configure: null`) and no settings. You use it by
choosing the formatter on an entity-reference field that points at a contact form.

## Requirements

- Core `contact` module enabled and at least one contact form entity (e.g. the default
  `feedback` form, or any `contact.form.*`).
- A fieldable entity/bundle with an **`entity_reference` field whose `target_type` is
  `contact_form`**.

## UI steps

1. Add an entity-reference field to a bundle: *Manage fields → Add field → Reference →
   Other* (or "Contact form"), setting the reference type to **Contact form**.
2. Populate the field on an entity with the contact form(s) you want to show.
3. On the bundle's **Manage display**, set that field's **Format** to
   **"Rendered Contact Form"** (`contact_field_formatter`), then *Save*. There are no
   formatter settings to configure.

## Scriptable (drush php:eval)

```php
use Drupal\field\Entity\FieldStorageConfig;
use Drupal\field\Entity\FieldConfig;

FieldStorageConfig::create([
  'field_name' => 'field_contact', 'entity_type' => 'node',
  'type' => 'entity_reference', 'settings' => ['target_type' => 'contact_form'],
])->save();
FieldConfig::create([
  'field_name' => 'field_contact', 'entity_type' => 'node',
  'bundle' => 'page', 'label' => 'Contact form',
])->save();

// Choose the formatter on the view display.
$vd = \Drupal::entityTypeManager()->getStorage('entity_view_display')->load('node.page.default');
$vd->setComponent('field_contact', ['type' => 'contact_field_formatter', 'region' => 'content'])->save();
```

Then set the field's value on a node to a contact form id (e.g. `personal` is skipped;
use `feedback` or a custom form) and view the node — the form renders inline.

## Behaviour notes

- One rendered form is output per referenced form (per field delta).
- **Personal** contact forms render nothing (`ContactMessage::isPersonal()` guard).
- The formatter renders the standard `contact_message` add form, so submissions go through
  core contact handling (recipients, autoreply, flood control) exactly as normal.
