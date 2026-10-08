<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The Advertising context field & targeting collection

Lets content (nodes, terms) contribute provider-agnostic targeting/behavior to ads shown on the
same page.

## Field type / widget

- Field type `ad_entity_context` (`src/Plugin/Field/FieldType/ContextItem.php`): a serialized
  `blob` column `context` holding a map of `context_plugin_id`, `context_settings`
  (only the chosen plugin's settings are kept), `apply_on` (ad ids to scope to, empty = all).
  Default widget/formatter `ad_entity_context`.
- Widget `ContextWidget` builds its sub-form through `AdContextElementBuilder`
  (`src/Form/AdContextElementBuilder.php`), which offers a context-plugin `<select>`, the plugin's
  own `settingsForm()`, and an "Apply on ads" multiselect. Add the field to a bundle with
  **unlimited cardinality** to allow several contexts.

## Formatters (appliance)

Base `ContextFormatterBase` (`src/Plugin/Field/FieldFormatter/`). Settings:
`appliance_mode` (`backend` / `frontend` (deprecated) / `both`) and `targeting.bundle_label`
(add `bundle: label` targeting). `backend` appliance is enforced when
`tweaks.force_backend_appliance` is on. `includeForAppliance()` clones the item list, fires
`hook_ad_context_include`, and — **only when `$entity->access('view', currentUser)`** — either
renders frontend context elements or calls `addItemToContextData()` on the manager.

Concrete formatters resolve targeting from related content:
`EntityContextFormatter`, `EntityWithReferencesContextFormatter`,
`NodeWithTermsContextFormatter`, `NodeWithTreeAggregationContextFormatter`,
`NodeWithTreeOverrideContextFormatter`, plus taxonomy-tree variants
(`TaxonomyContextFormatterBase`, `TreeAggregationContextFormatter`, `TreeOverrideContextFormatter`).
Place the field into the **content** region on *Manage display* to deliver its context.

## TargetingCollection (`src/TargetingCollection.php`)

The provider-neutral targeting model.

- Construct from an array or JSON string; `add()/set()/remove()` keep values unique
  (scalar when one value, array when many).
- `collectFromUserInput("pos: top, category: a, category: b")` parses the admin textfield format;
  `toUserOutput()` renders it back. `collectFromCollection()` / `collectFromJson()` merge.
- **Output escaping:** `toJson()` uses `json_encode(..., JSON_HEX_TAG|JSON_HEX_APOS|JSON_HEX_QUOT|
  JSON_UNESCAPED_UNICODE)`. `filter($format_id = null)` runs each key/value through the configured
  filter format (`ad_entity.settings:process_targeting_output`) or, by default,
  `Xss::filter(strip_tags($text))`. Templates that print targeting/context call `filter()` first,
  so the JSON blob attached to each ad container is sanitized.

## How context reaches an ad

1. A context field's formatter (backend mode) pushes its items into `AdContextManager` via
   `addContextData()` while the host entity is rendered.
2. `AdEntity::getTargetingFromContextData()` collects the `targeting` context for that ad,
   filters it, and `template_preprocess_ad_entity()` emits it as `data-ad-entity-targeting` JSON.
3. Site-wide defaults come from `ad_entity.settings:site_wide_context` +
   `behavior_on_context_reset` (see [../config/settings.md](../config/settings.md)); a `turnoff`
   context suppresses the ad entirely (`AdEntityViewBuilder::view()`).
