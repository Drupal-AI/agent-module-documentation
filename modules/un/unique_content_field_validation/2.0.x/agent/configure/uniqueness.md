<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configuring uniqueness

No admin settings page. You toggle uniqueness inline on a field, a content type, or a
vocabulary; the choice is stored as a **third-party setting** and read at validation time.

## 1. Unique field value (per bundle)

- **UI:** *Structure → Content types → <type> → Manage fields → <field> → Edit* (the field
  settings / `field_config_edit_form`). A **"Unique"** fieldset appears with:
  - **Unique** checkbox → `unique`
  - **Unique message validation** textarea → `unique_text` (supports `%label`, `%value`)
  - For **multi-value** fields also: **Do not allow same value** (`unique_multivalue`) +
    **Multi value field message** (`unique_multivalue_text`).
- **Config location** — `field.field.<entity_type>.<bundle>.<field_name>`:
  ```yaml
  third_party_settings:
    unique_content_field_validation:
      unique: true
      unique_text: '%label "%value" already exists.'
      # multi-value only:
      unique_multivalue: true
      unique_multivalue_text: 'Each %label value must be different.'
  ```
- Only offered for these field types: `email`, `link`, `decimal`, `float`, `integer`,
  `list_float`, `list_integer`, `entity_reference`, `list_string`, `text`, `text_long`,
  `text_with_summary`, `string`, `string_long`, `webform`.
- **Enforcement:** an `#element_validate` callback (`unique_content_field_validation_validate_unique`)
  runs an `entityQuery` on value + bundle + langcode, excluding the current entity id; a match
  sets a form error. Multi-value uniqueness is checked within the submitted values.

## 2. Unique node title (per content type)

- **UI:** *Structure → Content types → <type> → Edit* — a **"Unique"** fieldset under
  Submission form settings toggles the **title**.
- **Config location** — `node.type.<bundle>`:
  ```yaml
  third_party_settings:
    unique_content_field_validation:
      unique: true
      unique_text: 'A page titled "%value" already exists.'
  ```
- **Enforcement:** the `UniqueContentTitle` constraint is added to every node `title` base
  field (`hook_entity_base_field_info_alter`, plus `hook_entity_bundle_field_info_alter` for
  types whose title label was renamed). The validator only fires when the node type's
  `unique` third-party setting is `true`.

## 3. Unique taxonomy term name (per vocabulary)

- **UI:** *Structure → Taxonomy → <vocabulary> → Edit* — a **"Unique"** fieldset toggles the
  term **name**.
- **Config location** — `taxonomy.vocabulary.<vid>`:
  ```yaml
  third_party_settings:
    unique_content_field_validation:
      unique: true
      unique_text: '...'
  ```
- **Enforcement:** same `UniqueContentTitle` constraint added to the term `name` base field.

## Drush / programmatic

```php
// Make Article titles unique:
$t = \Drupal\node\Entity\NodeType::load('article');
$t->setThirdPartySetting('unique_content_field_validation', 'unique', TRUE);
$t->setThirdPartySetting('unique_content_field_validation', 'unique_text', 'Duplicate!');
$t->save();

// Make a field unique:
$f = \Drupal\field\Entity\FieldConfig::loadByName('node', 'article', 'field_code');
$f->setThirdPartySetting('unique_content_field_validation', 'unique', TRUE);
$f->save();
```

Read it back:
```bash
drush cget node.type.article third_party_settings.unique_content_field_validation
drush cget field.field.node.article.field_code third_party_settings.unique_content_field_validation
```

## Notes

- Uniqueness is **per bundle and per language**; editing and re-saving the same entity is
  allowed (the current entity id is excluded).
- Removing uniqueness = uncheck the box (or unset the third-party setting) — there is no
  global switch.
