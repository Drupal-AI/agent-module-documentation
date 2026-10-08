# Configuration

There's no traditional settings form here — configuring Ecwid means **connecting
your Ecwid store** through an OAuth authorization flow, after which you manage
everything from Ecwid's own control panel.

## Step 1 — connect your store

1. Log in as an administrator.
2. Go to **`/admin/ec-store-connect`**.
3. Click through to **authorize with Ecwid**. You'll be sent to Ecwid to log in
   and grant access to your store.
4. Ecwid redirects back to the callback at `/admin/ec-store-connect/token`, which
   exchanges the OAuth code and saves your **store ID** and access token into the
   module's configuration (`ecwid.config`).

Once that completes, your site is linked to your Ecwid store.

## Step 2 — manage the store

Open **`/admin/ec-store`** to load the Ecwid **control‑panel iframe**. This is the
full Ecwid admin, signed in via SSO, embedded inside your Drupal admin — add
products, categories, set up payment and shipping, and so on, without leaving your
site.

## Step 3 — show the storefront

The public shop renders at **`/store`**. The module injects Ecwid's storefront
JavaScript keyed to your store ID, and the embed adapts to your theme's layout and
the visitor's screen size. Drupal's current language is passed through to Ecwid so
the storefront follows the site language.

## Before production

- **Treat `ecwid.config` as sensitive.** It holds the store ID and access token
  that grant API access to your connected store. Keep configuration exports out of
  public repositories, or they will leak your credentials.
- **Test the connect flow against a staging Ecwid account first**, before pointing
  a production site at a live store.

## Turning it off

Disabling the module removes the routes and the storefront embed, but the stored
`ecwid.config` values remain until you fully uninstall the module. Uninstall if
you want the credentials cleared.
