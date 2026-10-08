Bridges Drupal Commerce and CRM Core: when a customer places an order, it creates or updates a CRM Core Individual from the order's billing profile and email.

---

CRM Core Commerce is a glue module that keeps a CRM Core contact record in sync with Drupal Commerce checkout. It listens for the order `place` workflow transition and, through the `crm_core_commerce.individual_mapper` service, resolves an existing Individual (by linked user account, by an order-attached reference, or by matching the primary email field) or creates a new one, mapping the billing profile's name and address plus the order email onto the configured Individual bundle. It adds a `crm_core_individual` base field to `commerce_order` so each order links to its contact, ships a "CRM Core Individual Orders" view that lists an individual's orders on their full-view page, and exposes a single admin settings form to choose the target Individual type. The data written to the Individual can be customised with a `hook_crm_core_individual_data_alter()` hook or by extending the mapper service. It requires CRM Core (with `crm_core_contact` and `crm_core_user_sync`) and Commerce (`commerce_order`).

---

- Automatically build a CRM contact database from your Commerce customers with no manual data entry.
- Create a CRM Core Individual the first time a customer completes checkout.
- Update an existing Individual's name/address/email when a returning customer places another order.
- Link each `commerce_order` to its CRM Core Individual via the added `crm_core_individual` base field.
- De-duplicate contacts by matching an authenticated customer's linked Individual through `crm_core_user_sync`.
- De-duplicate anonymous customers by matching the Individual whose primary email field equals the order email.
- Choose which CRM Core Individual bundle new orders map to, via the Commerce settings form.
- Show each contact's order history (order number, total price, total paid, state, items) on the Individual's page through the bundled view.
- Map the billing profile's given/family name into the Individual's name field.
- Map the billing profile's address into the Individual type's designated address primary field.
- Store the customer's email in the Individual type's designated email primary field for later matching.
- Alter the mapped data with `hook_crm_core_individual_data_alter(&$data, $order)` to add custom fields (e.g. phone, marketing consent).
- Extend `CrmCoreIndividualMapper` to override `createNewIndividual()` / `updateIndividual()` for bespoke mapping logic.
- Feed a downstream CRM/marketing workflow that keys off CRM Core Individuals whenever an order is placed.
- Report on which orders belong to which contact for customer-service lookups.
- Segment customers in CRM Core based on their Commerce purchase history.
- Keep contact records current as billing details change across repeat purchases.
- Attach the contact reference to orders so other modules and views can join orders to individuals.
- Validate the mapped Individual before saving so malformed contacts abort the checkout transition rather than persisting bad data.
- Provide a single point of configuration (target Individual type) for the order-to-contact mapping.
- Use CRM Core's per-bundle "primary fields" so email/address column mapping follows your Individual type definition.
- Bootstrap a customer-relationship dataset for an existing Commerce store by re-saving historical orders through the place transition.
