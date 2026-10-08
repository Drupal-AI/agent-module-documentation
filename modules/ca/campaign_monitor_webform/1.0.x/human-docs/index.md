# Campaign Monitor webform handler — manual setup guide

**Campaign Monitor webform handler** (`campaign_monitor_webform`) adds a
[Webform](https://www.drupal.org/project/webform) handler that turns webform
submissions into Campaign Monitor subscribers. Use it to wire a signup or contact
form to a Campaign Monitor subscriber list: when someone submits the form, their
details are pushed to Campaign Monitor as a subscriber.

You add the handler to any webform and then map its fields onto the standard
Campaign Monitor subscriber fields — `email`, `firstName`, `lastName`,
`mobileNumber` — plus any custom fields on your list. An optional "trigger" field
lets you gate whether a given submission is sent at all.

This module does none of the talking to Campaign Monitor itself. It relies entirely
on the [Campaign Monitor REST Client](https://www.drupal.org/project/campaign_monitor_rest_client)
module, which holds the API key and performs the actual HTTPS calls. So your API
credentials are configured over there, not here.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it (with its two dependencies).
2. [Configuration](configuration/index.md) — adding the handler to a webform and
   mapping fields.

## Where it lives in the admin menu

This module adds no admin pages, routes, blocks, or permissions of its own. All of
its configuration happens **per webform**, on the handler you add to that form
under **Structure → Webforms → [your form] → Settings → Emails / Handlers**.
