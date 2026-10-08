# Configuration

Setting up Commerce TrustedShops involves creating a **Shop** entity with your
Trusted Shops credentials, displaying the Trustbadge, enabling the review collector,
and choosing how review invitations are sent.

## Handle your API credentials as secrets

Your Trusted Shops **API credentials** are secrets. Rather than committing them,
store them in an environment variable and expose them through a Key entity on a
DDEV project:

1. Save the credential into DDEV's environment file (never commit `.ddev/.env`):

   ```bash
   ddev dotenv set .ddev/.env --trustedshops-api-secret=YOUR_SECRET_HERE
   ddev restart
   ```

2. Confirm it is set **without printing its value**:

   ```bash
   ddev exec 'test -n "$TRUSTEDSHOPS_API_SECRET"'   # exit 0 means set
   ```

3. Install **Key** if needed and create a Key that reads the variable:

   ```bash
   ddev composer require drupal/key
   ddev drush en key -y
   ddev drush key:save trustedshops_api_secret --label='Trusted Shops API Secret' \
     --key-type=authentication --key-provider=env \
     --key-provider-settings='{"env_variable":"TRUSTEDSHOPS_API_SECRET","base64_encoded":false,"strip_line_breaks":true}' \
     --key-input=none -y
   ```

Where the Shop form only offers a plain text field, reference the variable from
`settings.php` via `getenv('TRUSTEDSHOPS_API_SECRET')` instead of committing it.

## Create the Shop entity

1. Go to **Commerce → Configuration → TrustedShops**
   (`/admin/commerce/config/trustedshops`) and add a **Shop**.
2. Enter your **TSID** and the API credentials for that shop.
3. Save. If you run multiple stores, create one Shop entity per Trusted Shops
   account — the module's chain resolver picks the correct shop for each order.

## Module settings

Open **Settings** (`/admin/commerce/config/trustedshops/settings`). This is where
you configure overall behavior, including whether the module runs in **Production
or QA mode**. Use QA mode while testing so you don't send live review invitations
or record test data against your production Trusted Shops account.

## Place the Trustbadge block

Go to **Structure → Block layout** and place the **Trustbadge** block in the region
and theme where you want the badge to appear (it uses the resolved TSID). The badge
template can be customized in Twig if you need to.

## Enable the Review Collector pane

Add the **Review Collector** checkout pane to your checkout flow at **Commerce →
Configuration → Checkout flows** (`/admin/commerce/config/checkout-flows`). When an
order completes, the pane outputs the review‑collector snippet so Trusted Shops can
gather ratings. The order language is chosen automatically for multilingual sites,
and the collector template can be customized.

## Review invitations

- **Manual:** from an order, use the **Send invitation to write a review** action
  (`/admin/commerce/orders/{order}/trustedshops/invite_review_confirm`). A bundled
  view also lets you send invitations from order listings and track which orders
  have had one sent. This action requires the **send invite review commerce
  trustedshops** permission.
- **Automatic:** configure invitations to be sent when an order reaches a given
  state (for example, order completed).

Developers can adjust the product data sent to Trusted Shops by subscribing to the
`AlterProductDataEvent`.

## Permissions

At **People → Permissions**, grant:

- **Administer commerce trustedshops** — to store administrators; controls the Shop
  admin and settings form.
- **Send invite review commerce trustedshops** — to the staff/agents who should be
  able to send review invitations from orders.

## Verify

Switch settings to QA mode, place a **test order**, and confirm the Trustbadge
renders on the storefront and the review collector fires on completion. Try sending
a manual invitation from the order to confirm your credentials and permissions are
correct, then switch to Production mode for go‑live.
