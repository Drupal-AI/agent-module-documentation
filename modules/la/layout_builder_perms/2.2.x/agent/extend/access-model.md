# Runtime access model

How a Layout Builder request is authorized once this module is enabled. Read this to understand
where access is (and is not) enforced.

## 1. Route requirement injection

`RouteSubscriber` (event `RoutingEvents::ALTER`, priority -100) adds a
`_layout_builder_perms_access` requirement to each core Layout Builder route, mapping it to one
operation:

| Route | Operation |
|---|---|
| `layout_builder.move_block(_form)` | `block_reorder` |
| `layout_builder.add_block` / `choose_block` / `choose_inline_block` | `block_add` |
| `layout_builder.update_block` | `block_config` |
| `layout_builder.remove_block` | `block_remove` |
| `layout_builder.add_section` / `choose_section` | `section_add` |
| `layout_builder.configure_section` | `section_edit` |
| `layout_builder.remove_section` | `section_remove` |

This is an **additional** requirement — core's own `_layout_builder_access` requirement remains,
so both must pass.

## 2. `AdvancedAccessCheck` (`access_check.entity.layout_builder_perms_access`)

```php
$access = $section_storage->access($operation, $account, TRUE);           // (a)
if (in_array($operation, AccessManagerInterface::LAYOUT_BUILDER_OPERATIONS)) {
  $access = $this->accessManager->access($operation, $route_match, $section_storage, $account, TRUE); // (b) reassigns
}
if (!$section_storage->getPluginDefinition()->get('handles_permission_check')) {
  $access = $access->andIf(AccessResult::allowedIfHasPermission($account, 'configure any layout')); // (c)
}
```

- (a) computes the section-storage access, then (b) **overwrites** it with the `AccessManager`
  result for the seven operations (so this check's contribution is purely the plugin result).
- (c) only ANDs the powerful core `configure any layout` when the storage does **not** handle its
  own permission check. `defaults` (template) storage does not → template layouts stay gated by
  `configure any layout`. The `overrides` storage is overridden to set
  `handles_permission_check = TRUE` → per-entity overrides are **not** gated by
  `configure any layout`; they rely on step (a)'s override storage check + the plugin result.

## 3. `AccessManager::access()`

- Loads the tempstore section storage, resolves the layout from the route (`getLayoutFromRouteMatch`)
  and the entity from the storage context.
- **If there is no entity context, returns `AccessResult::allowed()` immediately.**
- Otherwise builds a filter (operation/component/action/layout/block_type/entity_type/bundle),
  loads matching `LayoutBuilderPermission` plugins, sets their contexts (operation, layout,
  entity, runtime contexts, plus a `LayoutBuilderPermissionPluginContexts` event for extension),
  and AND-combines the `access()` of every plugin whose `applies()` is TRUE.
- **If no plugin matches, the result stays `AccessResult::allowed()`** (default-allow per
  operation). Because results are AND-combined, plugins can only deny.

## 4. `OverridesSectionStorage` override

Replaces core's overrides storage (`hook_..._section_storage_alter` sets the class). Its
`access()`:

```php
$any = allowedIfHasPermission($account, 'access layout builder page');
$own = allowedIfHasPermission($account, "configure own editable {$bundle} {$entity_type} layout overrides")
         ->andIf($entity->access('update', $account, TRUE));
$result = $any->orIf($own)
   ->andIf(defaultSectionStorage->access(...))       // default layout must allow
   ->andIf(allowedIf(defaultSectionStorage->isOverridable()));
```

So `access layout builder page` **alone** satisfies the base override gate for any overridable
entity (no ownership check) — the ownership-scoped `configure own editable …` path is only one
branch of an OR. Granular per-operation restriction then depends entirely on step 3 (which
defaults to allow when no plugin matches).

## 5. UI filtering (cosmetic)

`LayoutBuilderElement::preRender` (attached via `hook_element_info_alter`) removes add/edit/
remove section links, the add-block link, and block move handles the current user cannot use, by
re-running `access_manager->checkNamedRoute()` for each. `hook_preprocess_links` /
`hook_preprocess_item_list` do the same for the block/layout chooser lists. This is presentation
only; the route requirements above are the real enforcement.

## Extension points

- Add a `LayoutBuilderPermission` plugin (see `plugins/layout-builder-permission.md`).
- Subscribe to `LayoutBuilderPermissionPluginContexts` to inject extra plugin contexts (core's
  `ContentBlockTypePluginContext` subscriber does this to add the `block` context on
  `add_block`).
