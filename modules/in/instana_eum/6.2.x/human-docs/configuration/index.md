# Configuration

Everything Instana EUM needs is on one settings form. The beacon is only injected
when the module is **enabled** *and* an **API key** is set — so until you complete
this form, nothing is sent to Instana.

## Open the settings form

1. Log in as a user with the **configure instana** permission (an administrator by
   default — see the note on this permission below).
2. Go to **Configuration → System → Instana EUM Configuration**, or navigate
   directly to `/admin/config/services/instana_eum`.

## Find your Instana connection parameters

Before filling in the form, get the two values from Instana:

1. In the Instana dashboard, open **Websites and Mobile Applications** and click
   your application (create one if you don't have it yet).
2. Open the **Configuration** tab and find the **Tracking Script** block. Inside
   it you'll see two lines like:
   - `ineum('reportingUrl', 'YOUR_INSTANA_URL');`
   - `ineum('key', 'YOUR_INSTANA_KEY');`
   Those two values are what the Drupal form asks for.

## The fields

- **Enabled** — the master on/off switch. Untick it to stop monitoring instantly
  (useful during an incident) without uninstalling the module. The beacon only
  injects when this is ticked and a key is present.
- **API Key** *(required)* — the Instana beacon **key** from the tracking script.
  This is an EUM key that Instana intends to be visible in client‑side page source
  (it is emitted in the page for the browser to use), but still treat it as a
  credential you control — see "Storing the key" below.
- **Reporting URL** *(required)* — the Instana **reportingUrl** endpoint your data
  is sent to (the default is `https://eum-green-saas.instana.io`; use whatever URL
  your Instana application shows, including a self‑hosted endpoint).
- **Track individual pages** — reports each page path individually so you can
  analyse per‑page performance.
- **Admin page tracking** — off by default. When on, traffic on `/admin` URLs is
  included; leave it off to keep admin activity out of your monitoring.
- **Advanced settings** — a free‑text box for extra `ineum(...)` calls (for
  example `ineum('meta', 'version', '1.42.3')` or an `ineum('ignoreUrls', [...])`
  rule). **Important:** the contents of this box are executed as JavaScript in
  every visitor's browser, so only put trusted code here, and treat the whole form
  as high‑privilege (see below).

Click **Save configuration**.

## Storing the key

The beacon key is a client‑side EUM key by design, but you should still keep it
out of your repository and manage it deliberately:

- Don't commit it into exported configuration you share publicly; rotate it in
  Instana if it is ever misused.
- If you prefer to keep secrets in the environment, in **DDEV** you can store a
  value with `ddev dotenv set .ddev/.env --instana-eum-key=<value>` (keep
  `.ddev/.env` out of version control) and `ddev restart` so DDEV loads it, then
  reference it when populating configuration.

## A note on the "configure instana" permission

This form controls JavaScript that runs on every page of your site (through the
advanced‑settings field and the injected beacon). Anyone with the **configure
instana** permission can therefore affect what runs in every visitor's browser.
Grant it to trusted administrators only, and don't expose the form to
semi‑trusted roles.

## Verify data is flowing

After saving with **Enabled** ticked and a key in place, browse around the site to
generate some events, then check the Instana dashboard. It can take a few seconds
for events to appear, so don't worry if the numbers aren't immediate.
