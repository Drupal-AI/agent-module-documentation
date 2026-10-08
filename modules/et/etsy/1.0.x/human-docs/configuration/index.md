# Configuration

Configuring Etsy API is two steps: enter your Etsy app's OAuth2 credentials in the
**OAuth2 Client** module and authorize access to your shop, then set your **shop id**
(and a cache lifetime) in the Etsy API settings form.

## Before you start

Create an **Etsy developer app** in your Etsy account to obtain your **keystring**
(the API key / OAuth2 Client ID) and **shared secret** (the OAuth2 Client Secret),
and configure a redirect URL. You'll enter these on your site so it can authenticate
to the Etsy API via OAuth2.

## Step 1 — enter credentials in OAuth2 Client

The Etsy keystring and shared secret are stored and managed by the required
**OAuth2 Client** module, not by Etsy API itself. Go to
**/admin/config/system/oauth2-client**, find the OAuth2 Client labelled **etsy**,
and edit it:

- Check **Enabled**.
- Under *Client Settings: Etsy*, put your Etsy **keystring** in **Client ID** and
  your Etsy **shared secret** in **Client Secret**.
- Click **Save and request token** to run the OAuth2 authorization and obtain an
  access token.

The credentials are saved as part of the OAuth2 Client configuration; the access
token the site receives is kept in Drupal's state store, and a scheduled ping keeps
it alive. Grant the OAuth2 Client and Etsy admin permissions only to trusted
administrators.

## Step 2 — the Etsy API settings

Access to the Etsy API settings form (`/admin/config/services/etsy`) is gated by the
**Administer Etsy settings** permission (`administer etsy settings`). Grant it only to
trusted administrators (under **People → Permissions**), then open the form and set:

- **Etsy shop id** — the id of the single Etsy shop this site integrates (required).
- **Cache lifetime** — how long to cache API responses (Disabled, 1/2/6/12/24 hours)
  to stay within Etsy's rate limits.

This form does **not** hold your keystring or secret — those live in OAuth2 Client
(Step 1).

## A note on data and egress

Once authorized, your site makes outbound calls to Etsy's servers (**egress**) and
may pull shop, listing and order data. Keep that in mind for privacy and for any
environment where outbound HTTP is restricted, and always talk to Etsy over HTTPS.

## Save and test

Save the shop id and complete the OAuth2 authorization (Step 1). The Etsy API
settings form is accompanied by a **Testing** tab (`/admin/config/services/etsy/testing-form`)
where you can run calls such as *Ping* to confirm the connection works. A successful
connection means your custom integration (or the companion *Etsy Shop* module) can
then fetch data from your Etsy shop.
