# Configuration

All of this module's settings live on the **block** — there is no separate
settings page. You configure PayU credentials each time you place the block.

## Place and configure the PayU block

1. Go to **Structure → Block layout** (`/admin/structure/block`).
2. Click **Place block** next to your chosen region and select **PayU Block**.
3. Fill in the fields:
   - **Environment** — **Production** (`secure`) or **Sandbox**. Use Sandbox while
     testing.
   - **POS ID (pos_id)** — your PayU point-of-sale identifier.
   - **MD5 second key** — the PayU signature (second) key.
   - **OAuth client ID** and **OAuth client secret** — your PayU OAuth
     credentials.
   - **Currency** — an ISO-4217 currency code (for example `PLN`, `EUR`).
   - **Payment description** — the description sent to PayU with the order.
   - **Submit button text** — the label shown on the donate/pay button.
4. Save. The visitor then sees an amount field plus your submit button; the amount
   is validated to contain only numbers.

You can place several PayU blocks with different currencies or descriptions if you
need more than one donation option.

## Treat block configuration as secret material

This is important with this module: the PayU **MD5 signature key** and **OAuth
client secret** are entered as plain text fields and stored **in the block's
configuration**. That means an exported block configuration file contains **live
credentials**. Handle those exports as sensitive:

- Do not commit real production credentials into your repository's config export.
- Restrict who can administer blocks, since block config holds the secrets.
- Because credentials live in block config (not in a Key entity or environment
  variable here), be especially careful with configuration exports and backups.

## How payment works after submit

On submit the block configures the OpenPayU SDK from these settings, builds an
order (the amount is multiplied by 100 into minor units, except for HUF), calls
`OpenPayU_Order::create()`, and — when PayU returns success — redirects the visitor
to PayU's payment page. There is **no inbound notification handler** in this
module, so whether the payment ultimately completes is tracked on PayU's side; the
module itself does not receive or verify a server-to-server confirmation.

## Test before going live

With **Sandbox** selected, run a full test payment and confirm the redirect to PayU
works. Switch to Production only once the sandbox flow works — and remember to keep
the production credentials out of committed configuration.
