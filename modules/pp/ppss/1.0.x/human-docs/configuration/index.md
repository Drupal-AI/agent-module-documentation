# Configuration

Configuring PPSS is a matter of connecting it to a payment gateway and deciding
where the pay button appears and where visitors land afterwards. You need the
**`administer ppss`** permission to reach the settings.

## The settings you fill in

- **Payment gateway** — choose which gateway PPSS should use to take payments.
- **Content types** — select the content types on which the pay button should be
  enabled, so the button only appears where you sell something.
- **Return URL on success** — the page a visitor is sent to after a payment
  completes successfully (for example a thank-you or confirmation page).
- **Return URL on error** — the page a visitor is sent to if the payment fails or
  is cancelled, so they can try again or get help.

## Storing the gateway credentials securely

The gateway's API key/secret is a **secret**. Never paste it into configuration
that gets exported to code and committed to version control. Instead, store the
value in an environment variable and reference it from Drupal.

With DDEV, save the secret into the project's env file and restart so the container
picks it up:

```bash
ddev dotenv set .ddev/.env --ppss-gateway-secret=<value>
ddev restart
```

Keep `.ddev/.env` out of version control. Where the module (or your gateway
integration) supports a **Key** entity, create a Key backed by the environment
variable rather than storing the raw secret — install the
[Key](https://www.drupal.org/project/key) module if it is not already enabled and
create an env-provider key that reads that variable. This keeps the secret out of
your configuration and your repository.

## Save and place the button

Save the settings, then place the pay button through **Structure → Block layout**,
positioning it in a region on the pages where you sell your plans. Make sure the
roles that should see it hold the **`view ppss button`** permission.

## Test before going live

Because this module processes real payments and is not covered by Drupal's
security advisory policy, test the full flow in your gateway's sandbox/test mode
first — a successful payment, a failed payment, and both return URLs — before
accepting live payments.
