Action Link proofs of concept ships experimental demo State Action plugins (add-to-cart and subscribe) with a page that renders them, as a reference for building your own action links.

---

This experimental Action Link submodule contains proof-of-concept State Action plugins that illustrate non-field actions. `poc_add_to_cart` is a repeatable add/remove counter stored in Drupal's state service; `poc_subscribe` is a subscribe/unsubscribe toggle stored in state, keyed by entity type and id. A controller route `/action_link_poc` renders link sets for any configured action links that use these plugins, using node 1 as the demo operand. The plugins are deliberately incomplete demonstrations (their access and persistence logic are placeholders) and the module is marked experimental, so it is intended as example/reference code rather than a production feature.

---

- Study how a non-entity-field State Action plugin is structured (directions, states, next-state logic).
- See how a repeatable inc/dec action (add/remove from cart) is modelled with `RepeatableGeometryTrait`.
- See how a two-state toggle (subscribe/unsubscribe) is modelled with `ToggleGeometryTrait`.
- Preview action-link link sets on the bundled `/action_link_poc` demo page.
- Use `poc_add_to_cart` / `poc_subscribe` as scaffolding to copy when writing a real custom plugin.
- Learn how dynamic parameters (entity, or entity_type + entity_id) are declared and passed.
- Explore how link labels change based on current state (e.g. "Add to cart (2 in cart)").
