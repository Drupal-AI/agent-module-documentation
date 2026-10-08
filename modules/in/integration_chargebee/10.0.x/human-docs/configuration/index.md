# Configuration

Setting up Integration Chargebee follows a clear order: connect your Chargebee
account, pull in the plans, enable the ones you want to offer, and then surface
the subscribe page to your users.

## Open the settings page

1. Log in as a user with permission to administer the module's settings (an
   administrator by default).
2. Go to **Configuration → System → Chargebee**, or navigate directly to
   `/admin/config/system/chargebee`.

## Step 1 — Connect your Chargebee account

On the settings page, enter:

- **Chargebee site name** — the name of your Chargebee site (the identifier that
  appears in your Chargebee URL).
- **API key** — the API key from your Chargebee account. This is the credential
  the module uses for every call to Chargebee, so keep it secret (see below).

Save the settings.

## Step 2 — Import and enable plans

1. Go to the plans page at `/admin/config/system/chargebee/plans` and **choose the
   plan(s)** you want from your Chargebee plan list.
2. Return to the Chargebee settings page (`/admin/config/system/chargebee`) and
   **enable** the plan(s) you just selected so they become available on the site.

## Step 3 — Present the subscribe page

The per‑user subscribe page is available at `/user/{user}/subscribe-plan`. Link to
it (or place the module's plan block) wherever you want users to access it. From
there a user signs up as a Chargebee customer and pays through Chargebee's
**Hosted Checkout**; after payment they return to your site and the subscription
is recorded against their account.

## Storing the API key securely

The Chargebee API key can create and read billing data, so protect it:

- Never commit it to version control or paste it into exported configuration.
- Prefer an **environment variable** over a hard‑coded value. In **DDEV**, store
  it with `ddev dotenv set .ddev/.env --chargebee-api-key=<value>` (keep
  `.ddev/.env` out of version control) and `ddev restart` so DDEV loads it, then
  reference it when populating the setting.
- Keep all traffic on HTTPS, and rotate the key in Chargebee if it is ever
  exposed.

## Verify it worked

Visit a test user's `/user/{user}/subscribe-plan` page — you should see the plan(s)
you enabled and be able to start a Hosted Checkout flow. Confirm the completed
subscription then shows against the correct user account.
