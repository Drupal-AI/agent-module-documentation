# Configuration

Shopify eCommerce needs to be pointed at your Shopify store before it can sync or
display anything. All of that happens on the module's admin settings page.

## Open the settings form

1. Log in as a user with permission to administer the module (an administrator).
2. Go to the Shopify settings page, registered as the **`shopify.admin`** route
   (reachable from the admin configuration menu once the module is enabled).

## Connect your store

On the settings form you enter the **Shopify API credentials** that let the module
talk to your store's API and pull products and collections into Drupal. Treat these
credentials as secrets:

- Keep the **API key / token** out of version control. Store it in an environment
  variable, or wire it through a **Key** entity, rather than typing a permanent
  secret into a config field that gets exported.
- Serve the site over HTTPS so the credentials are never sent in the clear.

Once the connection is in place, your Shopify products sync into Drupal as product
entities, which you can then place, theme, and field like any other content.

## Webhooks — verify them

If you configure Shopify to send **webhooks** to your site (so product and order
changes on Shopify push into Drupal automatically), make sure those webhook calls
are **verified**. Shopify signs each webhook with an HMAC signature; the module (or
your handling of it) should check that signature and reject any call whose signature
does not match. This is what stops an attacker from forging a webhook — for example
faking an order or product update — by simply posting to the webhook URL. Confirm
webhook verification is on before you rely on webhook-driven syncing.

## A note on checkout

Checkout itself is not handled in Drupal — customers are taken through Shopify's own
checkout workflow. Drupal's job here is catalog display; Shopify remains the system
of record for orders and payments.
