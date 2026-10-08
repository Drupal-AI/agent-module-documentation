<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Define and enable Paragraphs Sets

## The `paragraphs_set` config entity

A set is a config entity (`Drupal\paragraphs_sets\Entity\ParagraphsSet`, config name
`paragraphs_sets.set.<id>`). Exported keys (config_export order): `id`, `label`, `icon_uuid`,
`description`, `paragraphs`. The `paragraphs` value is an **ordered list** of
`{bundle: <paragraph_type>, data: <field defaults>}`.

**3.1.x storage detail:** each item's `data` is stored as a **YAML-encoded string** (config schema
`config/schema/paragraphs_sets.schema.yml` → `data: type: text`, `nullable: true`), which makes it
translatable through the Config Translation UI. Read code always sees a native array again:
`ParagraphsSet::getParagraphs()` and `ParagraphsSets::getSets()` run every item through
`ParagraphsSets::decodeSetItemData()`, and `ParagraphsSet::preSave()` runs it through
`encodeSetItemData()` before storage. `update_9002` re-saves existing sets to migrate the old
nested-array `data` to the string form. Both helpers are idempotent (an already-decoded array or
already-encoded string is returned unchanged).

### Admin UI

Managed at **Structure → Paragraphs sets** (`/admin/structure/paragraphs_set`, route
`entity.paragraphs_set.collection`; add form route `paragraphs_sets.set_add`). Every route
(collection, add, `entity.paragraphs_set.edit_form`, `entity.paragraphs_set.delete_form`) requires
the `administer paragraphs sets` permission.

![Paragraphs sets listing](../../../../../../../screenshots/paragraphs_sets/3.1.x/paragraphs-sets-list.png)

The add/edit form (`Form\ParagraphsSetForm`) has: **Label**, **machine name** (`id`, max 32 chars,
locked after create), **Paragraphs set icon** (`managed_file`, uploads to
`public://paragraphs_set_icon/`, extensions `png jpg svg webp gif`), **Description** (textarea), and
a **Paragraphs configuration** YAML textarea (`data-yaml-editor`; suggests the YAML Editor contrib
module if absent) plus a collapsible **Example configuration**. On submit, `validateForm()` decodes
the YAML, verifies each `bundle` exists in `paragraphs_type_get_types()` (else "Unknown paragraph
bundle …"), and stores the icon file UUID in `icon_uuid`.

![Add Paragraphs set form](../../../../../../../screenshots/paragraphs_sets/3.1.x/paragraphs-set-add-form.png)

Example paragraphs-configuration YAML (as typed into the textarea):

```yaml
paragraphs:
  - bundle: text_block
    data:
      field_body: '<p>Welcome to our product.</p>'
  - bundle: cta
    data:
      field_body: '<p>Sign up today!</p>'
```

Create the config entity from code (pass `data` as a native array — `preSave()` encodes it):

```php
\Drupal\paragraphs_sets\Entity\ParagraphsSet::create([
  'id' => 'landing_intro',
  'label' => 'Landing intro',
  'description' => 'A hero text block followed by a call to action.',
  'paragraphs' => [
    ['bundle' => 'text_block', 'data' => ['field_body' => '<p>Welcome.</p>']],
    ['bundle' => 'cta', 'data' => ['field_body' => '<p>Sign up today!</p>']],
  ],
])->save();
```

```bash
drush php:eval 'foreach(\Drupal::entityTypeManager()->getStorage("paragraphs_set")->loadMultiple() as $id=>$s){print "$id: ".$s->label()."\n";}'
```

Icon files are tracked as file usage (`ParagraphsSet::postSave()`) and added as config
dependencies (`calculateDependencies()`); a module can override the shown icon URI via
`hook_paragraphs_sets_set_static_icon_uri_alter()` (see [../hooks/data-alter.md](../hooks/data-alter.md)).

`data` sets default field values on each paragraph (primitive fields work out of the box; for
complex values use the [alter hooks](../hooks/data-alter.md)).

## Enable sets on a Paragraphs field (widget settings)

Paragraphs Sets adds three settings to the **Paragraphs** (stable `paragraphs`) widget on an
entity's *Manage form display* (they appear on the `entity_reference_revisions` field's widget cog,
only for the `paragraphs` widget — not the legacy `entity_reference_paragraphs` widget), via
`Hook\FieldHooks::fieldWidgetThirdPartySettingsForm()`:

| Setting | Key | Meaning |
|---|---|---|
| Enable Paragraphs Sets | `use_paragraphs_sets` | Show the set selector on the widget. |
| Limit sets to | `sets_allowed` | Restrict which sets are offered on this field (checkboxes; unchecked = all allowed). |
| Default set | `default_set` | Use this set as the field's default value on new entities (requires the widget's "Default paragraph type" = "- None -"). |

They are stored as **third-party settings** on that field's component in the form-display config,
**double-nested** (provider key `paragraphs_sets`, then element key `paragraphs_sets`) — matching
`config/schema/paragraphs_sets.schema.yml` and `WidgetInterface::getThirdPartySetting('paragraphs_sets', 'paragraphs_sets')`:

```
core.entity_form_display.<entity>.<bundle>.<mode>
  -> content.<field>.third_party_settings.paragraphs_sets.paragraphs_sets.use_paragraphs_sets: true
  -> ... .paragraphs_sets.paragraphs_sets.sets_allowed: {landing_intro: landing_intro}
  -> ... .paragraphs_sets.paragraphs_sets.default_set: _none
```

Set them in code with the form-display component's `third_party_settings`:

```php
$fd = \Drupal::service('entity_display.repository')->getFormDisplay('node', 'landing_page', 'default');
$component = $fd->getComponent('field_sections');
$component['third_party_settings']['paragraphs_sets']['paragraphs_sets'] = [
  'use_paragraphs_sets' => TRUE,
  'sets_allowed' => ['landing_intro' => 'landing_intro'],
  'default_set' => '_none',
];
$fd->setComponent('field_sections', $component)->save();
```

The empty/`- None -` sentinel value is `ParagraphsSets::PARAGRAPHS_SETS_DEFAULT_EMPTY_VALUE` (`'_none'`).

When enabled, editors get a set `<select>` plus **Select set** (replaces the field's paragraphs
with the set) and, once the field has items, **Append set** buttons; both run through the static
Form API callbacks `ParagraphsSets::setSetSubmit()` / `setSetAjax()`. Choosing a set makes
`Hook\FormHooks::fieldWidgetCompleteFormAlter()` build the set's paragraphs pre-filled with its
`data`. In the Paragraphs "modal" add mode, each set is also rendered as an append button in the
`paragraphs_sets_add_dialog` template.

![Set selector on a node form](../../../../../../../screenshots/paragraphs_sets/3.1.x/set-picker-node-form.png)

Sets are only offered when every paragraph type in the set is allowed by the field and the set does
not exceed the field's cardinality (`ParagraphsSets::getSets()` / `getSetsOptions()`). Runtime
discovery uses those helpers.

Uninstalling the module removes the `third_party_settings.paragraphs_sets` key from all
`entity_form_display` components (`paragraphs_sets_uninstall()`).
