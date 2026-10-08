# Configuration

All configuration is done **per webform**, by adding the Campaign Monitor handler to
the form you want to feed into a subscriber list.

## Add the handler to a webform

1. Go to **Structure → Webforms** and open the form you want to connect.
2. Open **Settings → Emails / Handlers**.
3. Click **Add handler** and choose **Campaign Monitor**.

You can add the handler to a webform more than once (its cardinality is unlimited),
for example to feed different lists under different conditions.

## Handler settings

- **Subscriber list** — pick the Campaign Monitor list submissions should be added
  to. The list options are fetched live from Campaign Monitor (your clients, and
  each client's lists) through the REST client, so the API key must already be set
  up in that module.
- **Trigger field** *(optional)* — choose a webform element that gates sending. Data
  is only sent to Campaign Monitor when that field has a value. Leaving it at the
  default (**Always**) sends on every matching submission.
- **Field mapping** — map your webform elements onto the Campaign Monitor subscriber
  fields: `email`, `firstName`, `lastName`, `mobileNumber`, and any custom fields on
  the list. Composite sub‑elements are supported using the `key__subkey` notation.
  Anything you map that isn't one of the standard fields is sent in Campaign
  Monitor's `CustomFields` array.

When a submission is saved, the handler builds the subscriber payload and posts it
to the chosen list through the REST client. The payload always sets
`ConsentToTrack` to **Yes**, resubscribes the address, and restarts any
autoresponders — keep that in mind for your consent wording.

## A note on logging

The handler writes the full Campaign Monitor API response to the Drupal log (at
*info* level) for each send. That response can include the subscriber's email and
name, so personal data may land in your logs. On production, consider lowering the
log verbosity or pruning these entries to avoid retaining subscriber PII in the
watchdog log.

## Credentials

This module never holds your API key. Authentication and TLS are entirely the job
of the **Campaign Monitor REST Client** module — configure the key there, keeping it
in an environment variable rather than committed configuration.
