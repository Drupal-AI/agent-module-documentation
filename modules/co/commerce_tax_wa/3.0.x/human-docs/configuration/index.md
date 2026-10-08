# Configuration

You configure Commerce Tax Washington by adding a **tax type** in Commerce. There
is no separate settings page — everything lives on the tax‑type form.

## Add the Washington State tax type

1. Log in as a user who can administer Commerce configuration.
2. Go to **Commerce → Configuration → Tax types**
   (`/admin/commerce/config/tax-types`) and click **Add tax type**.
3. Give it a name (for example "Washington sales tax") and, for the plugin, select
   **Washington State tax service**.

## Fields on the form

- **Default location and default tax rate** — enter a fallback location code and
  rate. This rate is only used if the Department of Revenue's web service is
  temporarily down or returns an error, so the store can still charge *something*
  reasonable rather than failing. Under normal operation the live lookup supplies
  the rate.
- **Taxable product variations** — choose which product variations this tax
  applies to. This lets you have both taxable and non‑taxable variations in the
  same store; only the selected ones are taxed.
- **Store(s)** — restrict the tax type to one or more specific Commerce stores, so
  it only applies where you sell into Washington.

Save the tax type when you are done.

## How it behaves

Once saved, any customer whose **billing/shipping address is in Washington State**
is charged tax on the taxable products, at the destination rate looked up for
their address. The plugin stores the resolved location code and location name with
the order for reference.

## Verify

Place a **test order** with a Washington delivery address and a taxable product,
and confirm the calculated tax matches the expected destination rate. Also test an
out‑of‑state address to confirm no WA tax is applied. Because the rate comes from
an external lookup, keep an eye on the fallback default rate — that is what
customers would be charged if the service is unreachable.
