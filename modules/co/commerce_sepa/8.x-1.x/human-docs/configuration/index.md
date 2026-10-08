# Configuration

Commerce SEPA is configured like any Drupal Commerce payment gateway — you add a
gateway entity and fill in its settings.

## Add the payment gateway

1. Go to **Commerce → Configuration → Payment gateways**
   (`/admin/commerce/config/payment-gateways`) and click **Add payment gateway**.
2. Give it a **Name** the customer will recognise (for example "SEPA direct
   debit").
3. Choose the **SEPA** plugin.

## Gateway settings

The SEPA gateway has no separate "creditor identifier" field — the settings you
will see are:

- **Valid countries** — an optional multi-select. If you pick one or more
  countries, a customer's IBAN is accepted only if its country prefix is in the
  list; leave it empty to accept any valid IBAN.
- **Request BIC number on checkout** — a checkbox. When ticked, a BIC field is
  shown at checkout (and validated against the ISO 9362 format).
- **Request account holder on checkout** — a checkbox that adds an "Account
  holder" field to checkout.
- **Send SEPA Direct Debit Mandate** — a checkbox. When ticked, it reveals the
  mandate email settings:
  - **Notification email address** — the "from" address for the mandate email
    (leave empty to use the site email).
  - **Subject** and **Body** — the mandate email. The **Body** comes pre-filled
    with a complete SEPA Direct Debit Mandate letter that contains placeholders
    written as `{{ Creditor Name }}`, `{{ Creditor Identifier }}`, and so on.
    **These are literal text, not tokens — you must edit the body and replace
    them with your own creditor details** (the name and SEPA creditor identifier
    registered with your bank) before you go live. Subject and body also support
    Drupal tokens (order, payment method, profile); use the "Browse available
    tokens" link.
- **Payment instructions** and the customer-facing **display label** — the
  standard Commerce gateway options.

Because SEPA here has no live/test API call at checkout (the module only records
and validates the IBAN and emails the mandate), there is no API credential to
enter — the sensitive part is the customer's IBAN, which the module collects and
validates during checkout.

## Save

Click **Save**. Place a test order to confirm the SEPA method appears at
checkout, the IBAN field validates, and the mandate email is sent.

## Operating it safely

- **An order is not paid just because checkout finished.** SEPA settlement
  happens later through the bank. **Reconcile real settlement out of band** and
  do not treat "processing" as money received.
- The customer's **IBAN and mandate are sensitive bank data** — serve checkout
  over **HTTPS**, restrict who can view orders, and store/transmit the data
  securely.
