# Configuration

Setting up Commerce Square takes two layers: the shared **application settings**
(your Square account credentials), and a **payment gateway** entity that uses the
Square plugin. Do the settings first, then add the gateway.

> **A word on secrets.** The values on this page — your application secret and
> access tokens — are live payment credentials. Treat them as secrets: keep them
> out of anything you commit to version control, and don't share exported
> configuration that contains them. Production access and refresh tokens are
> stored in Drupal's **state** (not config) precisely so they stay out of your
> exported configuration; keep it that way. Where your workflow supports it,
> supply credentials from environment variables rather than typing them into
> plain, committed configuration.

## Step 1 — Application settings

1. Log in as a user with the **Administer commerce square** permission.
2. Go to **Commerce → Configuration → Payment → Square settings**, or navigate
   directly to `/admin/commerce/config/square`.
3. Fill in the fields, taken from your application in the Square developer
   dashboard:
   - **Application Name** — the name of your Square application (required).
   - **Application Secret** — your Square OAuth application secret, used for the
     production authorization flow.
   - **Sandbox Application ID** — the application ID for Square Sandbox
     (required to test).
   - **Sandbox Access Token** — the Sandbox access token (required to test).
   - **Application ID (production)** — your production application ID; it's used as
     the OAuth `client_id` when connecting a live account.

Sandbox is ready to use straight from these values — no OAuth step is needed for
testing.

### Connecting a production account (OAuth)

When you **save** the settings form with production details, the module redirects
you to Square to authorize the connection (requesting the scopes it needs to read
the merchant profile and read/write payments, customers, and orders). Square then
redirects back to your site's authorization return URL
(`/admin/commerce_square/oauth/obtain`), and the module exchanges the returned
code for an **access token** and **refresh token**. These are stored in Drupal
**state**, not configuration, so they never end up in an exported config file.
Make sure the redirect/return URL is configured correctly on the Square side so
the round trip completes.

## Step 2 — Add the Square payment gateway

1. Go to **Commerce → Configuration → Payment gateways** and add a new gateway.
2. Choose the **Square** plugin.
3. Set the gateway options:
   - **Mode** — **Sandbox** (`test`) for testing or **Production** (`live`) for
     real charges. This is the standard Commerce gateway mode switch.
   - **Location** — the Square location that transactions are attributed to. The
     dropdown is populated **live** from Square's Locations API when you open the
     form, so you need valid credentials and network access for it to fill in.
     There is a separate location for Sandbox and for Production. (If the module
     can't reach Square or the credentials are missing, the select is disabled and
     shows "Not configured" — and the form links you back to the Square settings
     to fix the credentials.)
   - **Enable credit card icons** — on by default; shows card-brand icons at
     checkout.
4. Enable the gateway and save.

You can run a Sandbox gateway and a Production gateway side by side — for example a
sandbox one on staging and a live one on production.

## Step 3 — Test, then go live

- With a **Sandbox** gateway, run a full checkout using Square's sandbox test
  cards to confirm authorization, capture, and refunds all work.
- When you're satisfied, complete the **production** OAuth connection (Step 1) and
  switch (or add) a gateway in **Production** mode with your live location.

At checkout, the Square Web Payments card form tokenizes the card in the browser,
so only a payment nonce reaches Drupal — the card number itself never hits your
server. From the Commerce order screen you can then capture an authorization or
issue a refund.
