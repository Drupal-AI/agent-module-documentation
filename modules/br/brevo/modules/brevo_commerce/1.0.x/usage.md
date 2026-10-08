Brevo Commerce adds a Drupal Commerce checkout pane that lets customers opt in to Brevo contact lists (newsletters) during checkout, using the order email, with optional double opt-in.

---

The submodule provides one Commerce checkout pane, `brevo_lists_subscriber` (`BrevoListsSubscriber`,
default step `order_information`). Its configuration form (on the checkout flow's pane settings) fetches the
account's Brevo lists via the parent module's `ContactsApiClientHelper::fetchAvailableLists()` and lets the
store admin pick which lists to expose (`enabled_lists`), set the checkboxes title/description, add
token-enabled rich-text info blocks above/below, and configure double opt-in (`enable_double_opt_in`,
`doi_redirect_url`, `doi_template_id`). At checkout the pane renders the enabled lists as checkboxes; on
submit it reads the order email and, for double opt-in, calls `createDoiContact()` with a confirmation
template and redirect (only when there are newly selected lists), otherwise `createContact()` /
`updateContact()` — merging the customer's already-subscribed lists so existing subscriptions are preserved.
It depends on `commerce_checkout` and `brevo`, requires the Brevo API key to be set (the form warns/errors
otherwise), and optionally uses the contrib `token` module for a token browser. Config is stored in the
checkout flow config entity (schema `brevo_commerce.list` + pane config).

---

- Let customers subscribe to newsletters during Commerce checkout.
- Expose selected Brevo lists as opt-in checkboxes on the order information step.
- Use double opt-in (confirmation email) for checkout newsletter subscriptions.
- Preserve a customer's existing Brevo list subscriptions when they opt into new ones.
- Create a new Brevo contact from the order email when the customer opts in.
- Update an existing Brevo contact's lists on checkout.
- Add rich-text/legal information above or below the subscription checkboxes.
- Use tokens in the info blocks and the double opt-in redirect URL.
- Set a custom title and description for the subscription checkboxes.
- Choose a Brevo confirmation template and redirect URL for double opt-in.
- Fetch and refresh the account's Brevo lists from the pane configuration form.
- Warn the store admin when the Brevo API key is not configured.
- Scope the subscription pane to a specific checkout flow/step.
- Only fire the double opt-in call when there are genuinely new list selections.
- Comply with opt-in best practice by defaulting double opt-in to on.
- Drive newsletter growth directly from the storefront checkout.
