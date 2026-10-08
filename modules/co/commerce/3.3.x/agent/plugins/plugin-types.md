# Plugin types defined by base Commerce

Declared in `commerce.plugin_type.yml` (+ a third registered in code). Implement with the
matching attribute in `src/Attribute/` (or legacy annotation in `src/Annotation/`).

## commerce.condition — reusable boolean rules
- Manager: `plugin.manager.commerce_condition` (`Drupal\commerce\ConditionManager`).
- Attribute: `#[CommerceCondition]` (`src/Attribute/CommerceCondition.php`); base class
  `Drupal\commerce\Plugin\Commerce\Condition\ConditionBase` implementing
  `ConditionInterface::evaluate(EntityInterface $entity)`.
- Used by promotions, payment, shipping to gate applicability (order total, product,
  customer, etc.). Place plugins in `src/Plugin/Commerce/Condition/`.

## commerce.entity_trait — opt-in field/behavior bundles
- Manager: `plugin.manager.commerce_entity_trait` (`Drupal\commerce\EntityTraitManager`).
- Attribute: `#[CommerceEntityTrait]`. A trait declares fields/behavior a site builder can
  toggle on a commerce entity bundle (e.g. "purchasable entity"). Place in
  `src/Plugin/Commerce/EntityTrait/`.

## commerce.inline_form — embeddable sub-forms
- Manager: `plugin.manager.commerce_inline_form` (`Drupal\commerce\InlineFormManager`).
- Attribute: `#[CommerceInlineForm]`. Reusable form fragments (customer profile/address,
  payment method) embedded in bigger forms. Place in `src/Plugin/Commerce/InlineForm/`.
- Alterable via `hook_commerce_inline_form_alter()` / `hook_commerce_inline_form_PLUGIN_ID_alter()`
  (see [../hooks/hooks.md](../hooks/hooks.md)).

Submodules define further plugin types (payment gateways, checkout panes, tax types,
adjustment types, promotion offers) — see each submodule's docs.
