# One Page CRM API — manual setup guide

**One Page CRM API** (`one_page_crm_api`) is a developer‑oriented integration
layer for [OnePageCRM](https://www.onepagecrm.com/), the action‑focused sales
CRM. It wraps the OnePageCRM REST API v3 in a set of injectable Drupal services
so your own modules can work with contacts, companies, deals, notes, calls,
meetings, actions, attachments, relationship types, custom fields, lead sources,
statuses, pipelines, users, filters, countries, notifications, and webhooks —
without writing Guzzle requests, handling authentication, or parsing responses
by hand.

Each resource is exposed as its own service (for example
`one_page_crm_api.contacts` or `one_page_crm_api.deals`), so a custom module can
inject exactly the piece it needs. The module uses Drupal core's own HTTP client
and depends only on core's **Configuration** module — there are no other contrib
dependencies.

Because it is a low‑level bridge, One Page CRM API has **no end‑user features and
no configuration screen of its own** in the base module. It becomes useful when
another module (yours, or the optional *One Page CRM API UI* submodule described
below) calls its services. What it does need is your OnePageCRM API credentials,
which must be stored securely rather than committed to code.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — supply your OnePageCRM API
   credentials and store them securely.

## How to use it

You need an active **OnePageCRM account with API access enabled**. Once you have
your credentials in place (see [Configuration](configuration/index.md)), your own
code injects the resource services it needs, for example the contacts service, and
calls their methods to read and write OnePageCRM data. For the full list of
endpoints and data structures, consult the official OnePageCRM API documentation.

The project also mentions an optional **One Page CRM API UI** submodule that adds
admin forms for testing the endpoints (contacts, companies, deals, actions, and so
on) and viewing the raw request/response data — handy while you are building and
debugging an integration.
