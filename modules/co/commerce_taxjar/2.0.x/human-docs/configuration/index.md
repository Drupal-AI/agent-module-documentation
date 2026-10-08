# Configuration

You configure Commerce TaxJar by adding a **TaxJar tax type** in Commerce and
connecting it to your TaxJar account with an API token.

## Get your TaxJar API token

Log in at [app.taxjar.com](https://app.taxjar.com) and go to **Account → API
Access** to generate an API token. Keep this token confidential — anyone who has it
can query your TaxJar account. You enter it directly on the tax-type form
(described below), and it is stored in that tax type's Commerce configuration, so
restrict who can administer tax types and treat any configuration export of the
site as sensitive.

## Add and configure the TaxJar tax type

1. Go to **Commerce → Configuration → Tax types**
   (`/admin/commerce/config/tax-types`) and click **Add tax type**.
2. Choose the **TaxJar** plugin.
3. **API mode** — choose **Production** or **Sandbox**. (Sandbox mode requires a
   TaxJar Plus plan.)
4. Enter your **TaxJar API token** in the *API Token* field. In Sandbox mode a
   separate *Sandbox API Token* field appears — enter your sandbox token there.
5. **Use TaxJar for sales tax reporting** (on by default) — leave enabled to have
   completed orders recorded to TaxJar's transactions API for automated reporting
   and filing; uncheck it to use TaxJar only to calculate tax at checkout.
6. **Sync Product Tax Categories** — on first save the module fetches TaxJar's
   product tax categories into the *TaxJar Categories* taxonomy. Check this box
   later to re-fetch if TaxJar adds a category you want to use.
7. Save the tax type.

Your **nexus** — the states/jurisdictions where you must collect sales tax — is
configured in your **TaxJar account**, not on this form; TaxJar applies it when it
answers each tax request.

## Origin address and product categories

- **Store origin address** — each Commerce store gains a *TaxJar Origin Address*
  setting (edit the store): *Use store address* (the default — TaxJar computes tax
  from the store's physical address) or *Use address on file with TaxJar*. A
  physical from-address is required for accurate tax even for non-shipped
  (digital) orders.
- **Per-product tax code** — product variations gain a *TaxJar Category Code*
  field. Reference one of the synced *TaxJar Categories* terms on products that are
  exempt or taxed at a reduced rate; leave it empty for standard-rated products.

## Test vs live

Use **Sandbox** mode with a sandbox token while you set things up, then switch to
**Production** with your live token. Always place a **test order** and confirm the
calculated tax — including for a shipping charge and a discounted order — matches
what TaxJar reports before you go live.

## Security recap

- The module **sends order addresses and amounts to TaxJar** to compute tax — this
  external egress is how the service works. The tax rate and amount come back from
  TaxJar and are applied to the order server-side.
- The API host is fixed to TaxJar (production or sandbox); the connection is over
  HTTPS.
- Keep the **API token** confidential: restrict tax-type administration and treat
  configuration exports of the site as sensitive.
