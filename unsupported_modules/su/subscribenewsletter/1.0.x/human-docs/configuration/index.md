# Configuration

All of Subscribe Newsletter's settings live on one admin form. You point the module
at your email service provider, set how the sign-up block looks, then place the
block or link people to the form.

## Open the settings form

1. Log in as a user with the **Administer site configuration** permission (an
   administrator by default).
2. Go to **Configuration → Newsletter → API**, or navigate directly to
   `/admin/config/newsletter/api`.

## The fields

- **Title** — the heading shown on the subscribe block.
- **Description** — the introductory text shown on the block.
- **Endpoint URL** — the URL of your external newsletter API. This is where each
  submitted email is POSTed.
- **X API Key** — the API key for your provider. **Important:** at submit time the
  module appends this key onto the endpoint URL (as `endpoint_url & API_Key`), so
  it travels in the request URL rather than in a header. Always use an **HTTPS**
  endpoint URL so the request (and the key inside it) is encrypted in transit, and
  rotate the key if you suspect the URL has been exposed.
- **Logo** — an image to display on the subscribe block.

Save the form. The settings are stored in the module's configuration.

## What happens when a visitor subscribes

- The visitor enters an email on the block or at `/subscribenewsletter`.
- Drupal validates that it is a well-formed email address.
- The module POSTs `{"EMAIL": <address>}` as JSON to your composed endpoint URL.
- The API's response is logged (serialized) to Drupal's log, a success message is
  shown, and the visitor is redirected to the front page.

There is **no confirmation / double-opt-in token** — the address goes straight to
your ESP on submit. If your provider expects a confirmation step, handle it on the
provider side.

## Place the subscribe block

1. Go to **Structure → Block layout** (`/admin/structure/block`).
2. Click **Place block** in the region you want.
3. Find and place the **Subscribe Newsletter** block; it renders the form with the
   title, description, and logo you configured. (The block can be themed via the
   `block--subscribenewsletter` template if you want to customise its markup.)

Alternatively, simply link visitors to the standalone form at
`/subscribenewsletter`.

## Recommended: lock down abuse

The public sign-up form is reachable by anonymous visitors and each submission
fires an outbound API call, so it is worth hardening:

- Add a **CAPTCHA** or **Honeypot** to the form to stop bots from submitting
  arbitrary emails and driving outbound requests to your ESP.
- Keep the endpoint on **HTTPS** (see the API Key note above).
- Periodically review the logged API responses to confirm submissions are being
  accepted by your provider as expected.
