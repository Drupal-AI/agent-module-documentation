# Admin UI: create a group from the current page

This submodule adds no settings form and no config of its own. It adds an **authoring flow** for the
parent module's `block_visibility_group` config entity, plus a menu link and a helper route.

## Routes (`block_visibility_groups_admin.routing.yml`)

| Route | Path | Handler | Access |
|---|---|---|---|
| `block_visibility_groups_admin.group_create` | `/admin/structure/block/block-visibility-group-new/{route_name}/{parameters}` | `\Drupal\block_visibility_groups_admin\Form\ConditionCreatorForm` | core `administer blocks` |
| `block_visibility_groups_admin.active_groups` | `/block_visibility_groups_admin/list/{active_group_ids}` | `GroupLister::activeList` | core `access content` |

`{parameters}` defaults to `''` and is a JSON string (decoded with `Json::decode()`); `{route_name}`
is the route the new group's conditions should describe (e.g. the page the builder came from).

## Menu link (`block_visibility_groups_admin.links.menu.yml`)

`block_visibility_groups_admin.settings` — titled "Block visibility groups", parented under
`block.admin_display`, pointing at the parent module's `entity.block_visibility_group.collection`
route. So enabling this submodule surfaces the group list under **Structure → Block layout**.

## The create form (`ConditionCreatorForm`)

Form id `block_visibility_groups_admin_creator`. `buildForm($form, $form_state, $route_name, $parameters)`:

- Adds **Label** (textfield, required) and **Id** (machine_name, uniqueness checked against
  `BlockVisibilityGroup::load`).
- Adds a **Conditions** fieldset built by `conditionOptions()`: it loads every `ConditionCreator`
  definition and, for each, calls `createInstance($id, ['route_name' => ..., 'parameters' => ...])`
  then `createConditionElements()` (skipping any whose `getNewConditionLabel()` is empty).
- Stores `route_name` and decoded `parameters` as hidden `value` elements.

`validateForm()` re-instantiates each creator and requires **at least one** condition to be selected
(`itemSelected()`), else sets an error on `conditions`.

`submitForm()` collects the selected creators' `createConditionConfig()` output, then `createGroup()`:
`BlockVisibilityGroup::create(['id'=>…, 'label'=>…])`, `save()`, `addCondition($config)` for each
config, `save()` again — and redirects to `entity.block_visibility_group.edit_form` for that group.

## Active-group listing

`GroupLister::activeList($active_group_ids)` (comma-separated ids) loads those groups and renders,
per group, an edit link plus a **Manage Blocks** link to `block.admin_display_theme` filtered with
`?block_visibility_group={id}`. The `block_visibility_groups_admin.lister` service (`GroupInfo`,
implementing `GroupInfoInterface`) exposes `getActiveGroups()`, which instantiates the parent's
`condition_group` plugin per group and returns only those whose `evaluate()` is TRUE on the current
page. It is built from `@block_visibility_groups.group_evaluator`, `@entity_type.manager` and
`@plugin.manager.condition`.
