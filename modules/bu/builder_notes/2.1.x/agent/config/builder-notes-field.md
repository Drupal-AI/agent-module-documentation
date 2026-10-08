<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Builder Notes field — mechanism & storage

The whole module is one file: `builder_notes.module` (~60 lines). No routes,
controllers, services, entities, plugins, or permissions of its own.

## How the field is injected

`builder_notes_form_alter(&$form, $form_state, $form_id)` fires on every form
and returns immediately unless `$form_id` is one of this exact allow-list:

- `entity_form_display_edit_form`
- `entity_view_display_edit_form`
- `field_config_edit_form`
- `field_storage_config_edit_form`
- `node_type_edit_form`
- `user_role_form`
- `image_style_edit_form`
- `responsive_image_style_edit_form`

It then guards that `$form_state->getFormObject()` is an `EntityFormInterface`
and that its entity is a `ConfigEntityInterface`; otherwise it bails. So the
textarea only ever attaches to config-entity edit forms (never content forms).

It adds:

- `$form['notes']` — a `#type => details`, `#title` "Builder Notes",
  `#group => 'additional_settings'` (rides the vertical-tabs group these admin
  forms already render).
- `$form['notes']['builder_notes']` — a `#type => textarea` with
  `#parents => ['builder_notes']` and
  `#default_value => $entity->getThirdPartySetting('builder_notes', 'notes')`.

Finally it appends `builder_notes_display_entity_builder` to
`$form['#entity_builders']`.

## How the value is saved

`builder_notes_display_entity_builder($entity_type, ConfigEntityInterface $config_entity, &$form, $form_state)`
runs during the host form's own save pipeline and does:

```
$config_entity->setThirdPartySetting('builder_notes', 'notes', $form_state->getValue('builder_notes'));
```

The note is stored as a **third-party setting** on the config entity itself, so
it lives inside that entity's config object (e.g.
`core.entity_view_display.node.page.default`) and travels with config
export/import and deployments. There is no separate storage table or entity.

## Config schema

`config/schema/builder_notes.schema.yml` defines `builder_notes.notes`
(`mapping` with a single `notes: string`) and maps it onto the
`third_party.builder_notes` key of each supported config type:
`core.entity_view_display.*`, `core.entity_form_display.*`,
`field.storage.*`, `field.field.*`, `node.type.*`, `user.role.*`,
`image.style.*`, `responsive_image.styles.*`.

## Access & operation

- Install: `drush en builder_notes`. Requires `field_ui` (declared dependency).
- No config UI/route of its own — the field appears inline on the eight admin
  forms above. Reaching each form requires that form's normal permission
  (`administer node fields`, `administer node display`,
  `administer node form display`, `administer content types`,
  `administer permissions`, `administer image styles`,
  `administer responsive images`, plus `field_ui`).
- To read a saved note programmatically:
  `$entity->getThirdPartySetting('builder_notes', 'notes')`.
- Notes render only back into the textarea `#default_value`; the module emits no
  other output and adds no theming.

## Extending it

To cover more config entities, add the target form id to the `$matching_forms`
array in `builder_notes_form_alter()` and add the matching
`*.third_party.builder_notes` line to the schema. The README's roadmap notes the
maintainers' intent to eventually cover all config entities.
