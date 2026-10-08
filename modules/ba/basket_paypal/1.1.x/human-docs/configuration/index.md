# Configuration

Basket PayPal is configured as a payment method inside the **Basket** store. The
main task is giving it your PayPal REST API credentials.

## Enter your PayPal credentials

You need two values from the PayPal Developer Dashboard:

- **Client ID** — identifies your PayPal app. Not especially sensitive.
- **Client secret** — a credential that lets your server authenticate to PayPal.
  **Treat this like a password.**

PayPal issues separate credentials for its **sandbox** (testing) and **live**
environments. Use the sandbox pair while you test the checkout end to end, then
switch to the live pair when you go into production.

## Keep the client secret out of committed config

Do **not** paste the client secret into configuration that gets exported and
committed to Git. Instead store it in an environment variable and reference it
from Drupal:

- With DDEV, save it into the container's environment (never commit `.ddev/.env`):

  ```bash
  ddev dotenv set .ddev/.env --paypal-client-secret='<your secret>'
  ddev restart
  ```

  This makes the value available as `PAYPAL_CLIENT_SECRET` inside the container.

- Feed that variable to the module through a **Key** entity (using the Key
  module's environment provider) where the module supports a Key, or otherwise
  read it in `settings.php` with `getenv('PAYPAL_CLIENT_SECRET')`.

The client ID is not secret and can live in ordinary configuration.

## Always use HTTPS

Run the whole checkout over HTTPS. The buyer's approval and your server's
capture call both depend on a secure connection.

## Why you don't have to trust the browser

Worth knowing, because it explains why this integration is safe: the order is
created on your server with the correct amount, and the payment is captured on
your server. The module reads the capture **status from PayPal's own API
response** and only marks the order fulfilled when that status is `COMPLETED`. A
buyer's browser cannot declare an order "paid" or change the amount — those
decisions are made server‑side against PayPal directly.
