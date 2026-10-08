# Checkout pane plugin

Plugin type `commerce_checkout.checkout_pane` — one piece of the checkout form (contact info,
billing address, order summary, payment, completion message, or your own).

- Manager: `plugin.manager.commerce_checkout_pane`
  (`Drupal\commerce_checkout\CheckoutPaneManager`).
- Attribute: `#[CommerceCheckoutPane]` (id, label, default_step, wrapper_element). Base class
  `Drupal\commerce_checkout\Plugin\Commerce\CheckoutPane\CheckoutPaneBase`. Place in
  `src/Plugin/Commerce/CheckoutPane/`.
- Key methods: `buildPaneForm(array $pane_form, FormStateInterface $form_state, array &$complete_form)`,
  `validatePaneForm()`, `submitPaneForm()`, `isVisible()`, `defaultConfiguration()` +
  `buildConfigurationForm()`/`submitConfigurationForm()` for per-pane settings shown in the
  flow UI.

The plugin operates on the checkout order (`$this->order`). Panes are placed into steps in
the checkout-flow admin UI ([../configure/flows.md](../configure/flows.md)).

There is also a **checkout flow** plugin type (`commerce_checkout.checkout_flow`, manager
`CheckoutFlowManager`, attribute `#[CommerceCheckoutFlow]`) for defining whole step
structures (e.g. multistep vs. single-page); most sites configure an existing flow rather
than writing one.
