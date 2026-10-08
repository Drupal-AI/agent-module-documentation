# Configuration

Setting up Commerce Printful has three parts: connect your Printful account,
choose how orders are sent for fulfillment, and import the products you want to
sell. It also registers a fulfillment webhook so Printful can report shipment
updates back to your site (covered at the end).

## Connect your Printful account

1. Log in as a user with the Printful administration permission (grant it at
   **People → Permissions** if needed).
2. Open the module's Printful settings page in the admin UI.
3. Enter your **Printful API key** to connect. This authenticates the module's
   calls to Printful for product data, shipping rates, and order transfer.

### Keep your API key safe

The Printful API key is a credential. Do not commit it to version control. On this
project the recommended pattern is to keep the value in an environment variable
via DDEV's dotenv command and expose it to Drupal through a **Key** entity rather
than typing the raw secret into exportable config:

```bash
ddev dotenv set .ddev/.env --printful-api-key=<value>
ddev restart
```

Reference the Key from the module's settings where supported, and run your site
over **HTTPS**.

## Choose the fulfillment behavior

Decide how completed orders are handed to Printful:

- **Drafts** — orders are transferred to Printful as drafts for you to review and
  confirm before they are produced and shipped. Good while you are getting
  started or want a human check.
- **Fully automated** — orders are transferred and submitted for fulfillment
  automatically on completion, so the process runs hands-off.

## Import Printful products

Bring the Printful products you want to sell into Commerce, either:

- through the module's **import UI**, or
- with the module's **Drush command** (handy for larger catalogues or repeatable
  imports — run `drush list` after enabling to see the exact command name).

Because Printful generates product images dynamically, you do not need to supply
your own product photography.

## How checkout and fulfillment work (good to know)

When a cart contains Printful items, the module consults the Printful API at
checkout to retrieve **shipping costs** for the Printful shipping method. On order
completion it contacts Printful again to **transfer the order** (as a draft or for
automatic fulfillment, per your setting). Printful then produces and ships the
items and bills your card on file; your own payment gateway collects payment from
the customer.

## The fulfillment webhook

When you save a Printful store with webhook events enabled, the module registers a
webhook with Printful pointing at `/commerce-printful/webhooks` on your site.
Printful then calls it to report fulfillment updates: for a `package_shipped` event
the module records the shipment's tracking code, carrier, and shipped time so the
information is available to your customers.

Because this is a machine-to-machine callback, run your site over **HTTPS** and
keep the Printful API key stored as a secret (an environment variable exposed
through a Key entity). For an extra operational layer you can front the webhook
path with a web-server secret or IP allow-list.
