# Configuration

This module is configured per webform by adding its handler — there is no global
settings page.

## Add the handler to a webform

1. Go to **Structure → Webforms** and edit the form you want to send to Salesforce.
2. Open **Settings → Emails / Handlers**.
3. Click **Add handler** and choose **Salesforce Web-to-Lead post**.
4. Fill in the settings below and save.

You can add the handler more than once on a single webform (for example to post to
several orgs or endpoints), and you can add it to as many webforms as you like.

## The handler settings, field by field

- **Salesforce URL** (`salesforce_url`, required) — the full Salesforce Web-to-Lead
  POST URL, e.g.
  `https://www.salesforce.com/servlet/servlet.WebToLead?encoding=UTF-8`. You can
  point this at a sandbox URL in staging and the production URL in production.
- **Salesforce OID** (`salesforce_oid`, required) — your Salesforce org's OID,
  sent as the `oid` field. This is a public identifier, not a secret.
- **Webform to Salesforce mapping** (`salesforce_mapping`) — a table that maps each
  webform element to a Salesforce campaign field. The standard destinations are
  **description**, **email**, **first name**, **last name**, **lead source**, and
  **phone**; the destination is an "other" select, so you can also type a custom
  Salesforce field name. Composite element sub‑fields (for example the phone part
  of an address element) appear as their own mappable sources. **Only mapped fields
  are sent** — anything you don't map is excluded.
- **Custom data** (`custom_data`) — optional YAML for extra values included in
  every post. It supports tokens, so you can add static or dynamic metadata (for
  example a campaign ID or a fixed lead source).
- **Debug** (`debug`, off by default) — when ticked, the posted submission is
  displayed on screen. **Important:** the handler's own help text warns this shows
  the posted data *to all users*, which includes the submitter's name, email, and
  phone plus the org OID. Only turn it on temporarily while testing on a
  non‑public/staging environment, and never leave it enabled in production.

Because the handler is built on Webform's Remote Post handler, it also exposes that
handler's inherited options (such as excluded data and content type) and its
request/response logging.

## How the lead is sent

When a submission reaches the **completed** state, the handler assembles the
payload — the `oid`, your mapped Salesforce fields, and any custom data — and POSTs
it as `x-www-form-urlencoded` to the Salesforce URL. Just before sending, it fires
the `sfweb2lead_webform.submit` event, so a custom module can add or change fields
(see the [`agent/`](../agent/start.md) API docs for an example subscriber).

## A note on the POST destination

The Salesforce URL is a free‑form field, so anyone who can configure webform
handlers can point submissions at an arbitrary URL. That is standard Remote Post
behaviour and requires a privileged role, but it's worth keeping handler
configuration restricted to trusted administrators.
