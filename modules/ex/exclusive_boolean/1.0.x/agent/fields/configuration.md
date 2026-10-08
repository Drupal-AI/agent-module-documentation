<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Enabling exclusivity on a boolean field

All logic lives in `Drupal\exclusive_boolean\Hook\ExclusiveBooleanHooks` (src/Hook/ExclusiveBooleanHooks.php).
Install/enable: `drush en exclusive_boolean -y && drush cr`. Requires core `field` and `node`.

## The opt-in setting

There is **no admin settings form and no config object**. The flag is a **third-party setting** on the
`FieldConfig` entity:

```php
$field_config->getThirdPartySetting('exclusive_boolean', 'exclusive', FALSE); // bool, default FALSE
```

The module ships **no `config/schema/`**, so this third-party setting has no schema definition of its own.

## Where the checkbox comes from

`addExclusiveOption()` (invoked from both `formAlter()` on `field_config_edit_form` and
`formFieldConfigEditFormAlter()`):

1. Resolves the `FieldConfig` from `$form['#entity']` or the form object's `getEntity()`.
2. Bails unless `getType() === 'boolean'` **and** `getTargetEntityTypeId() === 'node'` — so the option only
   ever shows for **boolean fields on node bundles**.
3. Ensures a `third_party_settings` element exists (creates it as a `details` element titled *"Third-party
   settings"*, collapsed, if core hasn't).
4. Adds a `fieldset` **"Exclusive Boolean Settings"** with a single checkbox **"Make this field exclusive"**
   (`$form['third_party_settings']['exclusive_boolean']['exclusive']`), defaulting to the current stored
   value.
5. Appends `exclusive_boolean_field_config_entity_builder` to `$form['#entity_builders']`.

## How the value is saved

`fieldConfigEntityBuilder()` (procedural wrapper `exclusive_boolean_field_config_entity_builder`) runs as an
entity builder: it re-checks boolean+node, reads
`$values['third_party_settings']['exclusive_boolean']['exclusive']`, casts to bool, and calls
`$field_config->setThirdPartySetting('exclusive_boolean', 'exclusive', $exclusive)`.

## UI steps

Structure → Content types → *[type]* → Manage fields → Edit a boolean field → expand **Third-party
settings** → **Exclusive Boolean Settings** → tick **Make this field exclusive** → Save. Clear cache if the
option does not appear (`drush cr`).

## The on-form notice

`addWidgetDescription()` (from `hook_field_widget_form_alter` and
`hook_field_widget_single_element_form_alter`) adds a bold description under the checkbox on **node** edit
forms when the field is exclusive: *"When checked, this field will be automatically unchecked on all other
&lt;type&gt; nodes."* When the current node's field is **unchecked**, it also appends the node that currently
holds the flag (as a link via `$checked_node->toLink()`), or *"No &lt;type&gt; node currently has this field
checked."*. A `#exclusive_description_added` marker prevents the two widget-alter hooks from adding it twice.
`addFieldDescriptions()` is an intentionally empty leftover.
