# Hooks

Documented in `commerce.api.php`. The base module invites hooks for altering inline forms:

| Hook | Purpose |
|---|---|
| `hook_commerce_inline_form_alter(array &$inline_form, FormStateInterface $form_state, array &$complete_form)` | Alter any Commerce inline form (address, payment method, etc.) before it renders. |
| `hook_commerce_inline_form_PLUGIN_ID_alter(array &$inline_form, FormStateInterface $form_state, array &$complete_form)` | Alter a specific inline form by its plugin id (e.g. `customer_profile`). |

Beyond these, most extension points are **plugins** and **events** rather than hooks:
implement `commerce.condition` / `commerce.entity_trait` / `commerce.inline_form` plugins
(see [../plugins/plugin-types.md](../plugins/plugin-types.md)), and subscribe to the many
Symfony events dispatched by submodules (order, checkout, payment, cart) via
`EventSubscriberInterface`. Commerce also uses `state_machine` workflow transition events for
order lifecycle changes.
