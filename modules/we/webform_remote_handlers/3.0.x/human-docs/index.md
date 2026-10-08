# Webform Remote Handlers — manual setup guide

**Webform Remote Handlers** (`webform_remote_handlers`) adds two new Webform
handlers — a **REST** handler and a **SOAP** handler — that forward each
completed Webform submission to an external web service. You configure an
endpoint URL, a payload template, and authentication, and every time someone
finishes the form the handler builds a message from the submission and posts it
to your API.

This is the module you reach for when a contact form should create a lead in a
CRM, a support form should open a ticket in another system, or any Webform needs
to push its data into a REST API or a legacy SOAP service. You can build a custom
JSON (or form‑encoded) body using Drupal tokens such as
`[webform_submission:values]`, include individual field values, and even attach
uploaded files as base64. You can attach more than one handler to a single
Webform to fan a submission out to several endpoints at once.

The handlers can also read the remote server's response: parse a nested value
with a dotted path, treat the submission as successful only when a field matches
an expected value, write returned values back into the submission, show the
server's status message to the user, and optionally delete (purge) the submission
after a successful post.

> **Two configuration notes.** First, certificate verification is an opt-in
> setting: tick the SSL verification option (REST) or leave the "bypass SSL"
> option unticked (SOAP) in production. Second, **debug mode prints submission
> data to the screen and log** — keep it off in production. Store any endpoint
> passwords, API keys, or OAuth secrets in environment variables rather than
> committing them.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module (it requires the Webform module and PHP 8.1+).
2. [Configuration](configuration/index.md) — add a REST or SOAP handler to a
   Webform and set its endpoint, payload, authentication, and response handling.

## Where it lives in the admin menu

There is no global settings page (`configure` is `null`). Instead, each handler
is configured on an individual Webform, at **Structure → Webforms → *your
webform* → Settings → Emails / Handlers → Add handler**, where **REST** and
**SOAP** now appear alongside the built‑in handlers.

## How to use it

1. Build or open a Webform.
2. Go to its **Settings → Emails / Handlers** tab and click **Add handler**.
3. Choose **REST** (for JSON/HTTP APIs) or **SOAP** (for WSDL‑based services).
4. Fill in the endpoint, the request/payload template, and authentication, then
   turn on SSL verification. Save.
5. Submit the form to test; enable debug temporarily if you need to see exactly
   what is sent and received.
