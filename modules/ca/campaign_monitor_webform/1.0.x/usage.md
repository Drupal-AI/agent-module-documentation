<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Campaign Monitor webform handler

## What it is / when to use

- Adds a Webform handler that pushes submitted data to Campaign Monitor as a subscriber.
- Use to wire a signup/contact webform to a Campaign Monitor subscriber list.
- Maps webform fields to Campaign Monitor customer fields and custom fields.

---

## Install & configure

- Requires the `campaign_monitor_rest_client` module (which holds the API key/credentials) and `webform`.
- Add the "Campaign Monitor" handler to a webform (Webform > Settings > Emails/Handlers).
- Select the subscriber list, an optional triggering field, and map webform elements to `email`, `firstName`, `lastName`, `mobileNumber`, and custom fields.
- Authentication and TLS are handled by the `campaign_monitor_rest_client` service, not this module.

---

## Usage & API notes

- Implemented as a `@WebformHandler` plugin (`WebformCampaignMonitorHandler`), cardinality unlimited.
- On `preSave` it builds a subscriber payload and POSTs to `subscribers/<listID>.json` through the REST client.
- The payload hardcodes `ConsentToTrack => "Yes"`, `Resubscribe => TRUE`, and restart of autoresponders.
- A "trigger" field can gate submission: data is only sent when that field has a value (or "Always").
- List options are fetched live from `clients.json` and each client's `lists.json` via the REST client.
- Custom (non-standard) mapped fields are sent in the `CustomFields` array.
- The handler logs the Campaign Monitor response with `print_r` at info level — this can write subscriber PII (email/name) to the Drupal log; consider lowering verbosity on production.
- On a client exception it shows a warning message to the user.
- Field mapping supports composite sub-elements (`key__subkey`).
- No routes, blocks, or permissions are added by this module.
- All outbound HTTP goes through `campaign_monitor_rest_client`; review that module for TLS/key handling.
- The "trigger" default `0` means "Always" send.
- Email address is taken from the mapped `email` field of the raw submission.
- Name is concatenated from mapped first/last name values.
- The handler runs on every matching submission (results processed).
- To change mapping, edit the handler settings on the webform.
