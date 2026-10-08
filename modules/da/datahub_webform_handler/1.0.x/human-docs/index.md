# Webform Datahub — manual setup guide

**Webform Datahub** (`datahub_webform_handler`) adds a **Webform handler** that
sends webform submissions to an external "Datahub" registration API the moment a
form is submitted. It is built for event sites: attach the handler to a
registration webform, map the form's fields to the API's attendee fields, and
each submission is pushed straight into the Datahub CRM as a registered attendee.

Under the hood the handler does three things when a submission is saved: it
fetches an access token from the Datahub token endpoint, builds an attendee
payload from your field mapping, and POSTs that payload to the Datahub
registration endpoint with the token attached. You tell it where the API lives
and how to authenticate on a single global settings form; the per-webform field
mapping is configured on the webform itself. The only module dependency is
**Webform**.

The module does not work "on enable" — it needs configuration before it does
anything. You must (1) fill in the global settings form with the Datahub endpoint
URL and credentials, and (2) add and map the handler on each webform you want to
sync.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## A note on credentials and TLS

The handler authenticates with a username and password that you enter on the
settings form. Be aware of two things before you go live. First, always enter an
`https://` endpoint URL — the form only checks that *a* protocol is present, and
the outbound API calls use Drupal's default HTTP client, so TLS protection
depends entirely on you supplying a secure URL. Second, the username and password
are stored in plain module configuration (not a Key entity) and full API
request/response bodies are written to Drupal's log for debugging. Treat the
credentials accordingly and limit who can read your logs and configuration.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it alongside Webform.
2. [Configuration](configuration/index.md) — the global Datahub settings form and
   how to attach and map the handler on a webform.

## Where it lives in the admin menu

The global settings form sits at **Configuration → Web services → Webform
Datahub** (`/admin/config/services/webform_datahub-config`), reachable by any user
with the **Access administration pages** permission. The per-webform handler is
added from each webform's own **Settings → Emails / Handlers** tab under
**Structure → Webforms**.
