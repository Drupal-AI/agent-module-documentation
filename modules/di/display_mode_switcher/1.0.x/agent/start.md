<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Display Mode Switcher (display_mode_switcher) — agent index

Rule-based entity **display (view) mode switching at render time**, driven by pluggable condition plugins, with cache metadata propagation. No template overrides or custom code needed. Typical use: paywall / audience-dependent field layouts.

- **Requires:** Drupal core `^11.3`. No contrib dependencies. License GPL-2.0-or-later. Package Contrib.
- **No settings form.** All configuration is `display_mode_switcher_rule` config entities managed at `/admin/structure/display-modes/view/switcher`.
- **Permission:** `administer display mode switcher` (restrict access) gates every route below.

## How it works (mechanism)
- `hook_entity_view_mode_alter()` (in `src/Hook/EntityHooks.php`) calls the resolver, which returns a `DisplayModeResolution`, and rewrites `$view_mode` in place. The resolution is stashed keyed by `"{entity_uuid}:{final_mode}"`.
- `hook_entity_view()` retrieves the stash and merges the resolution's `CacheableMetadata` into `$build['#cache']`, then clears the stash entry.
- Resolution is per-request cached by `"{entity_type}:{entity_id}:{source_mode}"`.

## Config entity
- `display_mode_switcher_rule` (`src/Entity/DisplayModeSwitcherRule.php`) — config entity. Exported keys: `id, label, entity_type, bundle, source_display_mode, target_display_mode, weight, conditions`. Overrides `getCacheContexts/getCacheTags/getCacheMaxAge` to aggregate from its condition plugins; `getCacheTagsToInvalidate()` adds a scope tag. Entity-level constraint `DisplayModeSwitcherValidDisplayMode`.
- Custom storage `DisplayModeSwitcherRuleStorage` provides `loadApplicable(EntityInterface, sourceMode)`: filters enabled rules by entity type + source mode + bundle (empty = any), sorts ascending by weight.

## Plugin type provided
- `display_mode_switcher_condition` condition plugins — discovered from `Plugin/DisplayModeSwitcherCondition/`. Attribute `#[DisplayModeSwitcherCondition]` (`src/Attribute/`), base class `DisplayModeSwitcherConditionPluginBase` (adds `setEntity()` / `$this->entity`). **No condition plugins ship in this project** — the manager delegates to core's condition manager, so all standard/contrib conditions are available automatically.

## Services (`display_mode_switcher.services.yml`)
- `plugin.manager.display_mode_switcher.condition` → `DisplayModeSwitcherConditionManager` — union of own plugins + core condition library; hides `entity_bundle` (duplicated by the rule's bundle field).
- `Drupal\display_mode_switcher\Resolver\DisplayModeResolverInterface` → `DisplayModeResolver` — inject by interface.
- `display_mode_switcher.entity_hooks` → `EntityHooks`.

## Routes (all require `administer display mode switcher`)
- `entity.display_mode_switcher_rule.collection` — `/admin/structure/display-modes/view/switcher`
- `.add_form` / `.edit_form` / `.delete_form` under the same base path.

## Solution docs
- Rules, resolver, and cache model: [agent/concepts/resolution.md](concepts/resolution.md)
- Manage rules (routes, permission, form, config schema, export): [agent/config/rules.md](config/rules.md)
- Add a custom condition plugin: [agent/plugins/conditions.md](plugins/conditions.md)
