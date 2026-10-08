# Configuration

Configuring this module has two parts: setting your Stripe credentials on the
**Stripe base module**, and adding and tuning the payment element on the webforms
that need it.

## 1. Configure Stripe credentials (on the Stripe module)

This module does not have its own keys form — it reads the credentials configured
on the contrib Stripe module. Go to the Stripe module's configuration and add your
Stripe API credentials (publishable key, secret key, and webhook signing secret).

> **Keep secrets out of exported config.** The Stripe module stores these values
> as configuration, which means they can end up in a configuration export. To
> avoid that, keep the **secret key** and **webhook-signing secret** in a Key
> entity or in an environment variable referenced from `settings.php`, rather than
> pasting the raw values into the form. Make sure the webhook endpoint's signing
> secret is set so that forged payment-confirmation callbacks are rejected — the
> Stripe base module is what performs this signature verification.

## 2. Add the Stripe payment element to a webform

1. Open the webform you want to collect payment on and go to its **Build** page.
2. Add a new **Stripe payment** element.
3. The element comes with defaults that work out of the box; adjust the options
   below as needed. Each field's help text on the form explains its advanced use.

### Choosing what to charge

- **Select the source** — choose whether this element charges for an existing
  **Stripe product** or uses a **custom price and amount**.
- **Custom payment** — when not using a product, enter the **Amount** as a decimal
  value (for example `100.00` for $100) and a three-letter **Currency** code (for
  example `usd`).
- **Stripe product** — when using a product, select the Stripe product to
  associate with the form.

### Customers, addresses, and appearance

- **Customer mapping** — optionally map Drupal users to Stripe customers so
  payments are associated with a customer record, which helps with management and
  tracking. Stripe customers can be linked back to Drupal users or visitors.
- **Shipping and billing addresses** — optionally enable Stripe's collection of
  shipping and/or billing addresses for a fuller checkout.
- **Appearance** — style the Stripe payment element so it matches your site's
  design and branding.

### After payment

Succeeded payment-intent values are available as **Webform tokens**, so you can
reference the payment result elsewhere in the form's handlers or confirmation. The
element is fully compatible with Webform's AJAX and supports Stripe 3D Secure.

## A note on PCI scope

Because card data is collected by Stripe.js and sent directly to Stripe, it never
reaches your Drupal server, which keeps your site out of most PCI scope. Preserve
that benefit by not adding any server-side handling of raw card numbers around the
element.

## Save

Save the webform. Test the full payment flow with Stripe's test keys before going
live, and confirm the webhook signing secret is configured on the Stripe base
module so payment confirmations are verified.
