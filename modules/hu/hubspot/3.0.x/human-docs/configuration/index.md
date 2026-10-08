# Configuration

Setting up HubSpot integration is three steps: enter your HubSpot app credentials,
connect via OAuth, and then add the HubSpot handler to a webform. Optionally, you
can also switch on site‑wide tracking.

## 1. Open the settings form

1. Log in as a user with the **Administer site configuration** permission.
2. Go to **Configuration → Web services → HubSpot**
   (`/admin/config/services/hubspot`).

### The settings, field by field

- **HubSpot Portal ID** (`hubspot_portal_id`) — your HubSpot Hub/Portal ID
  (required). This is also the ID used by the tracking script.
- **Client ID** (`hubspot_client_id`) — the Client ID of your HubSpot OAuth app
  (required).
- **Client Secret** (`hubspot_client_secret`) — the Client Secret of your OAuth
  app. Treat this as sensitive.
- **Scope** (`hubspot_scope`) — the space‑separated list of OAuth scopes to
  request. Defaults to `crm.objects.contacts.write forms oauth`. Make sure the
  scopes here match what your HubSpot app is granted (you'll typically need
  `forms` and, for file uploads, file/contacts scopes).
- **Debug mode** (`hubspot_debug_on`) — when on, HubSpot API errors are emailed to
  the address below instead of only being logged.
- **Debug email** (`hubspot_debug_email`) — the recipient for those debug error
  emails.
- **Tracking code** (`tracking_code_on`) — when on, the HubSpot JavaScript
  tracking script (`https://js.hs-scripts.com/<portal id>.js`) is attached to
  every page automatically — no template edits needed.

Click **Save configuration**.

## 2. Connect your HubSpot account (OAuth)

Once a Portal ID is saved, the settings page shows a **Connect HubSpot Account**
button.

1. Click **Connect HubSpot Account**. You're redirected to HubSpot's authorize
   screen.
2. Approve the requested scopes. HubSpot redirects you back to Drupal, which
   exchanges the code for access and refresh tokens and stores them.
3. Back on the settings page the button now reads **Disconnect HubSpot Account** —
   that's how you know you're connected. Click it any time to revoke the stored
   token.

The access token is refreshed automatically when it expires; you only need to
reconnect if you disconnect or the refresh token is revoked on HubSpot's side.

> **Note on tokens:** the OAuth tokens are stored in Drupal's *state*, not in
> exported configuration, so they don't travel with a config export between
> environments — you connect OAuth per environment.

## 3. Add the HubSpot handler to a webform

This is how form submissions actually reach HubSpot.

1. Edit the webform you want to connect and go to **Settings → Handlers**.
2. Click **Add handler** and choose **HubSpot Webform Handler**.
3. If the site isn't connected to HubSpot yet, the form shows only a notice
   linking back to the settings page — connect OAuth first (step 2).
4. **Choose a HubSpot form** — a dropdown populated live from your HubSpot
   account. The HubSpot form must already exist.
5. **Map fields** — for each HubSpot field, pick the webform element that should
   feed it. (Non‑submittable elements like markup and page breaks are excluded.)
6. Optionally configure **Legal consent** (GDPR) — *never*, *always*, or driven by
   a consent checkbox in the form — and **Subscriptions**, mapping webform values
   to HubSpot email subscription types.
7. Save the handler.

You can add more than one HubSpot handler to a single webform if you need to send
to multiple HubSpot forms. On submission the handler uploads any files to HubSpot,
converts entity references to labels, joins multi‑value fields with semicolons, and
attaches the visitor's IP, referring page, and HubSpot tracking cookie.

## The recent‑leads block (optional)

The module provides a block that displays recent HubSpot leads. Place it from
**Structure → Block layout**. Because it exposes CRM contact data, viewing it is
gated by the restricted **View recent HubSpot leads** permission — grant it only to
trusted roles.

## Setting values without the UI

Credentials can be set with Drush, though you still complete the OAuth connect step
in the browser:

```bash
drush cset hubspot.settings hubspot_portal_id 1234567 -y
drush cset hubspot.settings tracking_code_on 1 -y
```

## A note on the legacy per‑node tab

Older versions had a per‑node "HubSpot" mapping tab at
`/node/{node}/webform/hubspot`. In this 3.0.x release that tab's form class is not
shipped, so the tab is non‑functional — **use the Webform handler above** to map
fields.
