<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Clone a bundle or a role (UI)

## Bundle clone — `/admin/config/entity-type-clone`

Route `entity_type_clone.type`, form `CloneEntityTypeForm`, form id `entity_type_clone_form`.
Also reachable from the "Clone *X*" operation on the content type / vocabulary / paragraph type /
profile type listings, which pre-selects the source via the `entity` and `bundle` route params.

Fields:

| Element | Key | Notes |
|---|---|---|
| Select Entity Type | `show[entity_type]` | AJAX-rebuilds the bundle select. |
| of type | `show[type]` | The source bundle. |
| Target bundle name | `clone_bundle` | Human label of the new bundle. |
| Target bundle machine name | `clone_bundle_machine` | Truncated to `EntityTypeInterface::BUNDLE_MAX_LENGTH` (32). Uniqueness callback is per entity type (`NodeType::load`, `Vocabulary::load`, `ParagraphsType::load`, `ProfileType::load`, `StorageType::load`, `BlockContent::load`). |
| Description | `target_description` | Optional. |
| Clone / Reset | `op` | *Reset* just redirects back to the form. |

### Which entity types appear

Built from `ContentEntityType` definitions intersected with a hard-coded list:

- always: `block_content`, `node`, `taxonomy_term`
- `paragraph` when the **paragraphs** module is enabled
- `profile` when the **profile** module is enabled
- `storage` when the **storage** module is enabled

### What happens on submit

A batch is set with `finished` =
`\Drupal\entity_type_clone\CloneEntityType::cloneEntityTypeFinishedCallback`:

1. **`cloneEntityTypeData($values, &$context)`** — creates the target bundle:
   - `node` → `NodeType::load(source)->createDuplicate()`, new uuid, `name`, `type`, `originalId`,
     `description` set, saved.
   - `paragraph` → same via `ParagraphsType`.
   - `block_content` → same via `BlockContentType`.
   - `taxonomy_term` → **`Vocabulary::create(['vid','name','description'])`** — a *fresh*
     vocabulary, so nothing else from the source vocabulary is carried over.
   - `profile` → `ProfileType::create()` copying `registration`, `multiple`, `roles`.
   - `storage` → `StorageType::create()` with id/label/description only.
   Then `setInitExtraFields()` copies extra-field visibility for every existing view mode of the
   source into the corresponding view display of the clone.
2. **`cloneEntityTypeField(['field' => …, 'values' => …], &$context)`**, once per field definition
   returned by `entity_field.manager` for the source bundle that has a target bundle
   (i.e. bundle fields, not base fields) — with taxonomy's `parent` field excluded:
   - duplicates the `FieldConfig` onto the new bundle, unless a field of that name already exists
     there or the definition is not an `EntityInterface` (e.g. Content Moderation's computed field);
   - for **every form mode** returned by `getFormModeOptionsByBundle()` and **every**
     `core.entity_view_display.<entity>.<source_bundle>.*` config, calls
     `EntityTypeCloneController::copyFieldDisplay()`.
3. `cloneEntityTypeFinishedCallback()` prints `"X" type and N field(s) cloned successfuly to "Y".`
   and redirects to `admin/config/entity-type-clone`.

`copyFieldDisplay()` deep-copies the source display array, `str_replace()`-ing the source bundle
machine name with the target one everywhere (that is how `field.field.*` dependency strings and
ids are rewritten), drops `_core`, assigns a new uuid, and saves. Form displays are written
straight through `configFactory()->getEditable()`; view displays go through
`entity_display.repository`, which also copies the source display's `third_party_settings`
(field_group etc.) once per view mode and honours `hidden` entries by removing the component.

Only displays whose `status` is TRUE are copied.

### Caveats the form itself warns about

> "After cloning with **ENTITY TYPE CLONE** please check the cloned entity type before doing config
> export or save any content in it."

Concretely: displays are copied by blind string replacement, so a bundle machine name that is a
substring of other values can corrupt them; extra-field handling only applies to view modes; and
no content is cloned.

## Role clone — `/admin/config/role-clone`

Route `entity_type_clone.role`, form `CloneRole`, form id `entity_clone_role_form`.
Select an existing role, give a new label and machine name, submit:

```php
$new_role = Role::create(['id' => $id, 'label' => $label]);
$new_role->save();
user_role_grant_permissions($new_role->id(), $source_role->getPermissions());
```

So the clone gets **exactly** the source role's permission list. `is_admin`, weight and any other
role properties are **not** copied.

Both forms link to each other via local actions (`entity_type_clone.links.action.yml`).

## Reading results with drush

```bash
drush php:eval 'print implode(",", array_keys(\Drupal::entityTypeManager()->getStorage("node_type")->loadMultiple()))."\n";'
drush php:eval '$f=\Drupal\field\Entity\FieldConfig::loadByName("node","my_clone","field_x"); var_export((bool) $f);'
drush cget core.entity_form_display.node.my_clone.default
drush role:perm:list my_cloned_role
```
