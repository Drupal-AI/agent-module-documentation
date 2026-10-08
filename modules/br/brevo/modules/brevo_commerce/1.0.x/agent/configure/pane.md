# Configure the Brevo Commerce checkout pane

The pane `brevo_lists_subscriber` (`#[CommerceCheckoutPane]`, default step `order_information`) is enabled
and configured on a checkout flow: *Commerce → Configuration → Checkout flows → (flow) → Edit*, then place
and configure the **"Brevo Lists Subscriber"** pane. The Brevo **API key must be set** first
(the form warns and `validateConfigurationForm()` errors otherwise).

## Configuration fields (pane settings)

| Key | Type | Default | Meaning |
|---|---|---|---|
| `enabled_lists` | checkboxes (int list IDs) | `[]` | Which fetched Brevo lists are offered at checkout. **Required.** |
| `checkboxes_title` | string | "Subscribe to newsletters" | Heading above the checkboxes. |
| `checkboxes_description` | string | "Select the newsletters…" | Description under the title. |
| `checkboxes_information_top` | text_format | empty (full_html) | Rich text (token-enabled) above the checkboxes. |
| `checkboxes_information_bottom` | text_format | empty (full_html) | Rich text (token-enabled) below the checkboxes. |
| `enable_double_opt_in` | bool | `true` | Use double opt-in (confirmation email) — recommended, since checkout emails aren't verified. |
| `doi_redirect_url` | string (token-enabled) | `''` | Redirect after DOI confirmation (required when DOI on). |
| `doi_template_id` | int | `null` | Brevo template id for the DOI email (required when DOI on). |
| `fetched_lists` | sequence (`brevo_commerce.list`) | `[]` | Cached lists fetched from Brevo (populated on submit). |

Lists are fetched (`ContactsApiClientHelper::fetchAvailableLists()`) each time the config form is submitted;
if none show, submit once to fetch. The `token` module is optional (adds a token browser; a message tells
you to install it otherwise).

## Runtime behaviour (`submitPaneForm`)

Reads selected list IDs (cast to int, empties filtered) and the **order email**
(`$this->order->getEmail()`), looks up the contact and its current list IDs, then:

- **Double opt-in on:** if the contact has no enabled lists yet, or there are newly selected lists, calls
  `createDoiContact($email, tokenized($doi_redirect_url), $doi_template_id, $mergedLists)`. `createDoiContact`
  always fires (create/update), so it is guarded to only run when there is a genuine new selection.
- **Double opt-in off:** if the contact doesn't exist → `createContact($email, $selectedLists)`; if nothing
  changed → no-op; else `updateContact($email, $mergedLists)`.

In all cases `$mergedLists` = the contact's already-subscribed enabled lists **unioned** with the new
selection, so pre-existing subscriptions (including lists not managed in Drupal) are preserved.

## Pane rendering (`buildPaneForm`)

Renders `checkboxes_information_top` (processed_text, tokens replaced), the list checkboxes
(`getFormattedEnabledLists()`), then `checkboxes_information_bottom`.
