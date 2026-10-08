<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configuration

The one thing you must configure is **how the webhook authenticates incoming
requests**. By default the endpoint accepts anything, so treat this page as
required setup, not optional tuning.

## Open the settings form

1. Log in as a user with the **Access administration pages** permission.
2. Go to **Configuration → Web services → Dialogflow Webhook**, or navigate
   directly to `/admin/config/service/api_ai_webhook`.

## Choose an authentication mode

The form offers three modes:

- **None** *(the default)* — no authentication. Every request to
  `/api.ai/webhook` is treated as the anonymous user, meaning the endpoint is open
  to anyone who knows the URL. Use this only for quick local testing, never in
  production.
- **Basic** — HTTP Basic authentication. You set a username and password; the
  module compares the username to your configured value and checks the password
  against an HMAC (computed with your site's hash salt) that it stores in Drupal's
  state. Enter the same credentials in your Dialogflow agent's webhook settings.
- **Headers** — the request must include a configured set of header name/value
  pairs, and **all** of them must match for the request to be accepted. Use this
  when Dialogflow (or a proxy in front of it) can send a shared secret header.

## Recommended setup

For any site that Dialogflow reaches over the internet, pick **Basic** or
**Headers** and configure the matching credentials on the Dialogflow side. Because
the endpoint is rate-limited by IP through Drupal's flood service, repeated failed
attempts from one address are throttled — but that is a backstop, not a substitute
for turning authentication on.

## Save

Click **Save configuration**. The new authentication mode takes effect
immediately. Test with a correctly authenticated Dialogflow-shaped POST to
`/api.ai/webhook`, and confirm that an unauthenticated request is now rejected.
