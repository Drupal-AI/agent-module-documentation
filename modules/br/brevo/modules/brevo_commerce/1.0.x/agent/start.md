# Brevo Commerce — agent index

Submodule of `brevo`. One Commerce **checkout pane**, `brevo_lists_subscriber` (`BrevoListsSubscriber`),
letting customers opt in to Brevo lists during checkout (using the order email), with optional double
opt-in. Depends on `commerce_checkout` + `brevo`; needs the Brevo API key set. No settings page of its own
(`configure` null) — configured on the checkout flow's pane settings. Config schema present. No permissions,
no Drush.

- **The pane, its config fields, single vs double opt-in behaviour** →
  [configure/pane.md](configure/pane.md)

Key facts:
- Pane id `brevo_lists_subscriber`, default step `order_information`.
- Config form fetches lists via `ContactsApiClientHelper::fetchAvailableLists()`; pick `enabled_lists`.
- On submit uses the **order email**: `createDoiContact()` (double opt-in) or `createContact()` /
  `updateContact()`; merges already-subscribed lists so existing subscriptions are kept.
- Double opt-in on by default (`enable_double_opt_in`), with `doi_redirect_url` + `doi_template_id`.
