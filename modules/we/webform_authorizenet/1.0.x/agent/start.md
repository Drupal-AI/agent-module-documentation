<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Webform Authorize.Net — agent start

**What**: Webform handler (`webform_authorizenet`) for Authorize.Net **Accept Hosted**
payments. Depends on `webform` + `authorizenet/authorizenet` SDK.

## Set up
1. `composer require authorizenet/authorizenet`; `drush en webform_authorizenet -y`.
2. Add two text elements to the webform: `anet_payment_status`, `anet_transaction_reference`
   (admin-only, not user-editable).
3. Add the **Webform Authorize.Net Handler**; enter API Login ID + Transaction Key, mode,
   transaction type, item price, quantity element, and customer/billing element mappings.

## Key facts
- Flow: `postSave` (completed) → `getAnAcceptPaymentPage()` (SDK, gets token) →
  redirect via `HostedPaymentCheckoutForm` → Authorize.Net hosted page → return.
- Amount = token `webform_authorizenet_total_amount` = `item_price × number_of_items`
  (`tokens.inc`, `SubmissionHelper::getConfigurationWithSubmissionContext`).
- Routes (all `_access: TRUE`): `.validation` (GET, marks **success** if `?tid` == stored
  ref), `.webhook` (POST, marks **complete** by `payload.merchantReferenceId`),
  `.hosted_payment_checkout_form`.
- Reference id is `'ref' . time()`.
- Credentials stored in the handler configuration (part of the webform config).
