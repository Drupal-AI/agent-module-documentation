<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Webform Authorize.Net

Adds a **"Webform Authorize.Net Handler"** that turns a webform submission into an
Authorize.Net payment using **Accept Hosted**. After the form is submitted the module
requests a hosted-payment-page token from Authorize.Net, redirects the user to an
intermediate checkout form and then to Authorize.Net's hosted page. On return, the module
marks the submission's payment status. Requires the `authorizenet/authorizenet` PHP SDK and
two string webform elements the admin must add: `anet_payment_status` and
`anet_transaction_reference`.

---

## Summary

The `AuthorizeNetHandler` (`id: webform_authorizenet`) stores API Login ID, Transaction Key,
mode (sandbox/production), transaction type (auth-only / auth-capture), item price, item-count
element, and customer/billing element mappings. On `postSave` of a completed submission,
`authorizeNetPost()` calls `getAnAcceptPaymentPage()` which builds a
`GetHostedPaymentPageRequest` via the SDK (amount from the
`[webform_submission:webform_authorizenet_total_amount]` token = price × quantity), sets the
return URL to `webform_authorizenet.validation` with a `tid` query equal to a server-generated
`ref{time()}`, and redirects the user through `HostedPaymentCheckoutForm` to the hosted page.

Three routes (all `_access: TRUE`):
`/webform-authorizenet/validate/{sid}` (GET) marks a submission **success** if the URL `tid`
equals the stored reference; `/webform-authorizenet/webhook` (POST) marks a submission
**complete** by `payload.merchantReferenceId`; `/webform-authorizenet/hosted-payment-checkout/{data}`
renders the interstitial checkout form.

---

## Use cases

- Accept a fixed-price payment (donation, fee, ticket) at the end of a webform.
- Charge price × a quantity element chosen by the submitter.
- Use Authorize.Net Accept Hosted so card data never touches the Drupal site.
- Run in sandbox mode against test.authorize.net before going live.
- Choose Authorization-only vs Authorization-and-Capture transaction types.
- Pass customer email and billing address from webform elements to Authorize.Net.
- Show a branded interstitial "review amount then Pay" checkout step.
- Record a per-submission transaction reference and payment status on the submission.
- Display a configurable confirmation message after a successful return.
- Localize/token-replace checkout title, content, and done message per submission.
- Collect event registration fees tied to the registrant's webform data.
- Take membership or application fees as part of an application form.
- Sell a small number of items with a single hosted checkout.
- Integrate payment into an existing multi-step webform without a full commerce stack.
- Route post-payment users back to the site front page via the hosted return URL.
