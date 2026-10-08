<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configure Commerce GMO LinkTypePlus

## 1. Payment gateway
At `/admin/commerce/config/payment-gateways` add the **LinkTypePlus** gateway (`src/Plugin/Commerce/PaymentGateway/LinkTypePlus.php`). Configure the GMO shop credentials, hosted-page (LinkPlus) settings, and the `payment_config` block that supplies redirect targets and messages: `success_url`/`success_message`, `pending_url`/`pending_message`, `failure_url`/`failure_message`, and `cancel_message`. These are read back in `GmoLinkTypePlusController::msgUrl()` / `statusMapper()`.

## 2. Order workflow
At `/admin/commerce/config/order-types`, set the order type's workflow to **`linktypeplus order workflow`** (`order_linktypeplus_validation`: draft → pending → completed/canceled).

## 3. Return / notification routes
Point GMO's LinkTypePlus configuration at:
- `/payment/success/order` — browser return; `responseProcessor` decodes the `result` POST (base64 → JSON), loads the order, creates/updates the `commerce_payment`, and applies the order transition based on `statusMapper` (REQSUCCESS→authorization, PAYSUCCESS→completed/place, ERROR/EXPIRED/INVALID→authorization_expired/cancel, PAYSTART→cancel back to checkout).
- `/payment/response/save` — server-to-server response saver (`responseSaver`) that dispatches `LinkTypePlusEvent` to the fulfilment subscribers.
- `/reccuringcredit/response` — recurring-credit webhook.

## Checkout flow
`commerce_gmo_linktypeplus_commerce_checkout_pane_info_alter` swaps in `GmoPaymentInformation`; `GmoPaymentProcess` + `LinkTypePlusOffsiteForm` redirect the shopper to GMO's hosted page. Fulfilment is handled by `OrderFulfillmentSubscriber` / `LinkTypePlusEventSubscriber`.
