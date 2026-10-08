<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Enabling "Required on Publish" on a field

There is **no admin settings page**. You enable the behavior per field on the field's *Field
configuration* edit form.

## Via the UI

1. Go to the field's config edit form, e.g. Article body:
   `/admin/structure/types/manage/article/fields/node.article.<field>`.
2. Tick **Required on Publish** (added by `hook_form_field_config_edit_form_alter`, weight -4).
3. Optionally tick **Warning on Empty** (only visible when Required on Publish is checked).
4. Save. (The checkboxes only appear for fields on publishable entity types — those
   implementing `EntityPublishedInterface`, e.g. nodes.)

## Where it is stored

Third-party settings on the `FieldConfig` config entity
`field.field.<entity_type>.<bundle>.<field_name>`:

```yaml
third_party_settings:
  require_on_publish:
    require_on_publish: true
    warn_on_empty: true        # optional; only kept when require_on_publish is true
```

Schema: `field.field.*.*.*.third_party.require_on_publish` → booleans `require_on_publish`,
`warn_on_empty`.

## Scriptable (drush php:eval)

```php
$fc = \Drupal::entityTypeManager()->getStorage('field_config')->load('node.article.field_meta_desc');
$fc->setThirdPartySetting('require_on_publish', 'require_on_publish', TRUE);
$fc->setThirdPartySetting('require_on_publish', 'warn_on_empty', FALSE); // optional
$fc->save();
```

Turn it off by unsetting the settings:
```php
$fc->unsetThirdPartySetting('require_on_publish', 'require_on_publish');
$fc->unsetThirdPartySetting('require_on_publish', 'warn_on_empty');
$fc->save();
```

## Read it back

```bash
drush cget field.field.node.article.field_meta_desc third_party_settings.require_on_publish
```

## The two flags

- **`require_on_publish`** — when the entity is **published** and this field is empty, saving is
  **blocked** with "<label> field is required when publishing." (a validation violation).
- **`warn_on_empty`** — when the entity is **unpublished** and the field is empty, a non-blocking
  warning message is shown ("<label> field can not be empty on publication"). No effect unless
  `require_on_publish` is also true.
