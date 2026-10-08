<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configure the autocomplete filter on a Link field

There is **no settings page** (`configure: null`). You configure it per **Link field instance**,
and it is stored as third-party settings on that field's `FieldConfig`.

## Where it is stored

Config entity: `field.field.<entity_type>.<bundle>.<field_name>`
Path within it:

```yaml
third_party_settings:
  link_field_autocomplete_filter:
    negate: false               # false/0 = include the selected; true/1 = exclude the selected
    allowed_content_types:      # node-type ids; empty = all allowed
      article: article
      page: page
```

- `negate` (boolean): `0` = **Include the selected below**, `1` = **Exclude the selected below**.
- `allowed_content_types` (sequence of strings): the checked content-type ids. If **none** are
  set (or all falsy), the module does nothing and all content types are allowed.

## Via the UI

1. Go to the field instance edit form, e.g. **Structure → Content types → <type> → Manage
   fields → <your link field> → Edit** (route `entity.field_config.node_field_edit_form`).
2. The module adds an **"Autocomplete Filter"** fieldset (only for `link`-type fields).
3. Choose **Which content types should be allowed for internal links?** → *Include the selected
   below* or *Exclude the selected below*.
4. Tick the **Content types** you want (checkboxes; "If none are checked, then all are allowed").
5. Save.

## Via drush / PHP

```php
$fc = \Drupal::entityTypeManager()->getStorage('field_config')
  ->load('node.article.field_related');          // <entity>.<bundle>.<field>
$fc->setThirdPartySetting('link_field_autocomplete_filter', 'negate', FALSE);
$fc->setThirdPartySetting('link_field_autocomplete_filter', 'allowed_content_types', [
  'page' => 'page',                              // include only Basic page
]);
$fc->save();
```

Read it back:

```bash
drush cget field.field.node.article.field_related third_party_settings.link_field_autocomplete_filter
```

## Notes

- The setting is per **instance**, so the same base field can filter differently on each bundle.
- Config schema `field.field.*.*.*.third_party.link_field_autocomplete_filter` validates
  `negate` (boolean) and `allowed_content_types` (sequence of strings).
- Changing the allowed types later does not break existing values silently — the widget adds a
  validator that errors if an entered node's type is no longer allowed (see
  [../api/mechanism.md](../api/mechanism.md)).
