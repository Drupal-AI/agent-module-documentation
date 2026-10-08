# Salesforce Web-to-Lead Webform Integration — manual setup guide

**Salesforce Web-to-Lead Webform Data Integration** (`sfweb2lead_webform`) adds a
[Webform](https://www.drupal.org/project/webform) handler that posts webform
submissions straight to a **Salesforce.com Web-to-Lead** endpoint, mapping your
webform fields to standard Salesforce lead fields so each submission becomes a new
lead in your Salesforce org. It is the standard way to feed Drupal contact,
newsletter, and quote‑request forms into a Salesforce lead pipeline without writing
custom API code.

The module provides one Webform handler, **Salesforce Web-to-Lead post**
(`sfweb2lead_post`), which extends Webform's built‑in Remote Post handler. You add
it to any webform and configure two Salesforce values — the **Web-to-Lead URL**
and your org's **OID** — then map each webform element to a Salesforce campaign
field (description, email, first name, last name, lead source, phone). When a
submission completes, the handler builds the payload and POSTs it to Salesforce as
`x-www-form-urlencoded`. Because it uses Salesforce's public **Web-to-Lead**
feature, authentication is just the org's OID — a public identifier, not an API key
or secret — so there are no credentials to store. Submissions still flow through
Webform's normal workflow, so results are also saved locally as usual.

Being built on Webform's Remote Post handler, it inherits request/response logging,
error handling, and a **debug** option. It also dispatches a
`sfweb2lead_webform.submit` event so a custom module can enrich the outgoing lead
(for example adding a campaign ID or UTM source) before it is posted. The module
requires the **Webform** module, ships no settings page, permissions, or Drush
commands of its own, and has no submodules — everything is configured inside each
webform's handler settings.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent — including the payload‑alter
event — read the sibling [`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer (including the
   required Webform dependency) and enable the module.
2. [Configuration](configuration/index.md) — add the handler to a webform and set
   the Salesforce URL, OID, field mapping, and options.

## Where it lives in the admin menu

There is no dedicated admin page. The **Salesforce Web-to-Lead post** handler is
added per webform under **Structure → Webforms → [your form] → Settings →
Emails / Handlers**.
