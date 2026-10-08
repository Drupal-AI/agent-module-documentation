<!-- SPDX-License-Identifier: LicenseRef-DXPR-Commercial -->
# Enable the builder on a field + config entities

## Turn a field into a DXPR Builder editor
DXPR Builder is a **field formatter**, `dxpr_builder_text`
(`src/Plugin/Field/FieldFormatter/DxprBuilderFormatter.php`), for field types `text`,
`text_long`, `text_with_summary`. Set it on the field's **view display** component:

- UI: *Structure → Content types → <type> → Manage display* → set the text field's Format to
  **DXPR Builder** → Save.
- Config: `core.entity_view_display.<entity>.<bundle>.<mode>` → `content.<field>.type: dxpr_builder_text`.
- Programmatic:
```php
$vd = \Drupal::entityTypeManager()->getStorage('entity_view_display')->load('node.article.default');
$vd->setComponent('body', ['type' => 'dxpr_builder_text', 'label' => 'hidden', 'weight' => 0])->save();
```
Editing then happens in place for users with `edit with dxpr builder`. The stored field value is
the builder's HTML; the formatter wraps it with the editor when the user may edit.

## Config entity types
All three are ConfigEntities under the `dxpr_builder` provider (schema in
`config/schema/dxpr_builder.schema.yml`):

### `dxpr_builder_profile` (per-role governance)
`src/Entity/DxprBuilderProfile.php`, `config_prefix: dxpr_builder_profile`,
`admin_permission: administer dxpr_builder_profile`. Exported keys:
`id, label, status, dxpr_editor, weight, roles[], elements[], blocks[], views[],
page_templates[], user_templates[], inline_buttons[], modal_buttons[], all_elements,
all_blocks, all_views, all_page_templates, all_user_templates`. A profile binds a set of
**roles** to allow-lists of what those roles can use in the builder (the `all_*` booleans mean
"allow everything of that kind"). Managed at
`/admin/dxpr_studio/dxpr_builder/profile`.
```php
\Drupal\dxpr_builder\Entity\DxprBuilderProfile::create([
  'id' => 'marketers', 'label' => 'Marketers', 'dxpr_editor' => TRUE,
  'weight' => 0, 'roles' => ['editor'], 'all_elements' => TRUE,
])->save();
```

### `dxpr_builder_page_template` — reusable full-page designs
Keys: `id, label, category, template, weight, image (base64), uuid`. Five ship by default.
Managed at `/admin/dxpr_studio/dxpr_builder/page_template`.

### `dxpr_builder_user_template` — user-saved reusable snippets
Keys: `id, label, template, uid, global, image, uuid`. Managed at
`/admin/dxpr_studio/dxpr_builder/user_templates`.

Inspect any of these with `drush config:get dxpr_builder.dxpr_builder_profile.<id>` etc.
(page/user templates use prefixes `dxpr_builder.page_template.<id>` /
`dxpr_builder.user_template.<id>`).
