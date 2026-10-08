<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Subscribe Newsletter provides a simple email-subscription form (as a route and a block) that pushes the submitted email address to an admin-configured external newsletter API endpoint.
---
The form (`SubscribeNewsletterForm`) is a single required email field validated with the core email validator; on submit it reads config `subscribenewsletter.subscribeendpoints`, builds `endpoint_url . '&' . API_Key`, and POSTs `{"EMAIL": <address>}` via `\Drupal::httpClient()->post()`, logging the serialized response. The admin form (`EndpointForm`, `/admin/config/newsletter/api`, `administer site configuration`) configures the block title/description, the endpoint URL, the `X API Key`, and a logo image. A companion `SubscribeNewsletterBlock` renders the form with the configured title/description/logo. The public form route `/subscribenewsletter` is gated by `access content`.

Security/operational notes accurate to this code: the public submit route uses `_permission: 'access content'`, i.e. it is effectively available to anonymous visitors, so anyone can trigger an outbound API POST with an arbitrary email (the form is a Drupal `FormBase` so it does carry the standard CSRF token). There is **no confirmation/double-opt-in token** — submission goes straight to the external endpoint. The API key is stored in plain module config and concatenated onto the endpoint URL (`endpoint_url . '&' . API_Key`) rather than sent as a header, so it travels in the request URL; ensure the endpoint is HTTPS. The response is logged via `serialize()` to watchdog. Setup: configure the endpoint URL and API key on the admin form, place the block or link to `/subscribenewsletter`.
---
- Configure the newsletter endpoint URL and X API Key at `/admin/config/newsletter/api`.
- Set the subscribe block's title and description.
- Upload a logo image for the subscribe block.
- Place the Subscribe Newsletter block in a region.
- Link visitors to the `/subscribenewsletter` form.
- Let visitors submit their email to subscribe.
- Validate the submitted email with the core validator.
- POST the email as `{"EMAIL": …}` to the external API.
- Push subscriptions to a third-party ESP endpoint.
- Show a success message after subscribing.
- Redirect subscribers back to the front page.
- Restrict the admin form to `administer site configuration`.
- Ensure the endpoint URL is HTTPS since the API key rides in the URL.
- Rotate the API key if the endpoint URL may have been exposed.
- Add anti-spam (CAPTCHA/honeypot) since the form is anonymous.
- Review watchdog logs of the serialized API response.
- Change the endpoint without code changes via config.
- Theme the block via the `block--subscribenewsletter` template.
- Collect newsletter signups site-wide.
- Confirm no double-opt-in step is expected by your ESP.
