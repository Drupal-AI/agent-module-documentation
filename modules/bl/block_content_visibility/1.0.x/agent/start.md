<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Block Content Visibility (block_content_visibility) — agent index

Persists core **Condition plugin** visibility rules on a **block_content** entity so they apply
across every placement of that reusable block. Package `Block`. Version **1.0.x** (1.0.0).
Core `^10.3 || ^11 || ^12`, PHP `^8.2`. License GPL-2.0-or-later.

**It changes display, not content access.** The evaluator only ever returns `forbidden` or
`neutral` — it never grants access a viewer would not otherwise have.

Dependencies (both hard): core **`block_content`**, contrib **`block_form_alter`** `^2.0`
(provides `hook_block_type_form_alter`). Ships **no** new Condition plugins — it surfaces the
ones already enabled on the site.

- **Settings form, permission, config object + schema** → [config/settings.md](config/settings.md)
- **The base field, hooks, evaluator, and render-time flow** → [api/evaluation.md](api/evaluation.md)

## What it actually is (from source)

- One base field, `visibility_conditions`, added to `block_content` in
  `BlockContentVisibilityHooks::entityBaseFieldInfo()` (`#[Hook('entity_base_field_info')]`):
  revisionable, single-value **`string_long`** holding a JSON-encoded
  `array<plugin_id, condition_configuration>` — the same shape `BlockForm::submitVisibility()`
  writes to a placement. `string_long` (not `map`) because `MapItem` has no main property name,
  which breaks core's pre-uninstall `hasData()`. Storage is installed in `hook_install()` and
  torn down in `hook_uninstall()` (`block_content_visibility.install`); the hook only declares
  the field once storage is actually installed, keeping uninstall transactional.
- Three services (`block_content_visibility.services.yml`): the logger channel,
  `block_content_visibility.evaluator` (`Access\Evaluator`), and
  `block_content_visibility.form_builder` (`Form\VisibilityFormBuilder`). Hooks live in
  `Hook\BlockContentVisibilityHooks` (attribute-based, registered as a service). The `.module`
  file carries no logic.
- One route/menu/form: `block_content_visibility.settings` at
  `/admin/config/system/block-content-visibility` (`Form\SettingsForm`), gated by the one
  permission `administer block content visibility` (`restrict access: true`).

## Editing UI (from source)

- `#[Hook('block_type_form_alter')]` (fired by `block_form_alter`) adds a **Visibility**
  vertical-tabs group to the block_content add/edit form via `VisibilityFormBuilder::buildForm()`,
  one `details` tab per Condition plugin available in the current context. Gated by the permission
  and, if set, by the `enabled_bundles` config list. Each tab starts with an explicit **"Apply
  this condition"** checkbox; `entityBuilder()` drops any tab not opted into, then delegates
  default-vs-configured filtering to core `ConditionPluginCollection::getConfiguration()` and
  JSON-encodes the result into the field.
- **Known limitation:** Layout Builder inline blocks are honoured at *render* time but the
  Visibility UI does **not** appear in the inline-block dialog (the LB form is not an entity form;
  its sub-element entity builder never runs). Editing works only on the standalone block_content
  form.
- `#[Hook('form_block_form_alter')]` adds a warning to the block *placement* form when the
  underlying block_content has content-level conditions, listing the condition labels (Twig
  autoescaped) and deep-linking to the content edit form. Also permission-gated.

## Render-time flow (from source)

`#[Hook('block_access')]` → for `view` op on `block_content:*` / `inline_block:*` plugins only →
`Evaluator::access()`: resolve the entity (UUID for block_content, `loadRevision(block_revision_id)`
for inline_block), decode the field, build a `ConditionPluginCollection`, apply per-condition
runtime contexts, AND-resolve (`resolveConditions(..., 'and')`), and bubble each condition's cache
metadata onto the `AccessResult`. Missing context → `forbidden`; any exception → `neutral` + log.
