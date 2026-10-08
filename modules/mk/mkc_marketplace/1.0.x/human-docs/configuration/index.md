# Configuration

Configuration falls into three parts: the marketplace settings (commissions and
payouts), the Stripe Connect connection (which needs secrets stored safely), and
the ongoing vendor/product/dispute workflow you run from the admin screens.

## Open the settings

Go to **Commerce → Marketplace → Settings**
(`/admin/commerce/marketplace/settings`), with the dashboard at
`/admin/commerce/marketplace`. Here you set:

- **Commission rates** — a percentage or flat fee taken per sale, which the
  commission calculator applies to each vendor order.
- **Payout schedule** — when and how vendor earnings are paid out.

Save to apply.

## Connect Stripe Connect (store the keys as secrets)

Vendor payouts run through **Stripe Connect**: vendors onboard to Stripe Express or
Standard accounts via OAuth, and earnings are transferred to them automatically on
order fulfilment. This needs your Stripe API keys and Connect settings.

Keep those credentials out of committed configuration. With DDEV, save them as
environment variables and reference them from the module's settings (or a Key entity
where supported):

```bash
ddev dotenv set .ddev/.env --stripe-secret-key=<value>
ddev restart
```

Confirm the variable is set without printing it:

```bash
ddev exec 'test -n "$STRIPE_SECRET_KEY"'   # exit status 0 means it is set
```

The OAuth callback is served at `/marketplace/stripe/connect/callback`, and Stripe
webhooks are handled for payout failures and dispute notifications — make sure your
Stripe dashboard points at the correct callback/webhook URLs for your site.

## Access control

The admin screens are gated by dedicated permissions — **manage marketplace**,
**manage vendors** and **manage payouts** — so grant these (under **People →
Permissions**) only to the staff who should administer the marketplace. The vendor
storefront reads (the public vendor/product listings) are public by design.

## Run the vendor workflow

- **Vendors** (`/admin/commerce/marketplace/vendors`) — approve, reject or suspend
  vendors who register at `/marketplace/register`.
- **Vendor products** (`/vendor-products`) — review products vendors submit before
  they publish.
- **Commissions** and **Payouts** — review the commission ledger and create payout
  batches.
- **Disputes** — work the three-party (customer ↔ vendor ↔ platform) resolution
  flow.

Vendors manage their own catalog, orders, payouts and shipping methods from the
vendor portal at `/vendor/dashboard`.

## Test it

Register a test vendor, approve them, complete their Stripe Connect onboarding in
test mode, place a multi-vendor order and confirm it splits into per-vendor
sub-orders, then confirm the commission is calculated and a payout can be created.
