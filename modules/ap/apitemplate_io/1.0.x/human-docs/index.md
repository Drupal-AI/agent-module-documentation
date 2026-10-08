# APITemplate — manual setup guide

**APITemplate** (`apitemplate_io`) is a Drupal client for the
[APITemplate.io](https://apitemplate.io) REST API, which generates PDFs from
server-side templates. With it, your modules and site builders can create PDFs
from a template, merge several PDFs together, list the templates in your
APITemplate.io account, and serve the results as downloads — driving documents
like invoices or certificates from Drupal data.

Under the hood the module wraps APITemplate.io's `/v2` endpoints in a service
(`apitemplate_io.client`) and authenticates by sending your API key in an
`X-API-KEY` header. An admin settings form holds the API endpoint and key, and a
**Test Tool** form lets an administrator render a template and preview the
returned PDF before wiring it into a workflow.

All of the module's routes — the settings form, the test tool and the admin menu
block — require the **`administer apitemplate_io configuration`** permission, so
there are no anonymous or public endpoints. Requests use Guzzle's default TLS
verification (no disabled certificate checking).

**On the API key.** APITemplate.io is an external, paid service, so you supply an
API key. This module stores that key as **plaintext in configuration** (an
ordinary text field, not a Key entity), which means it can end up in config
exports — so exclude it from public exports or feed it in from the environment
(see the configuration page). One further note: the client's `serveFile()` helper
can fetch an arbitrary URL server-side when asked to, but it is only reached from
the admin-gated flows, so keep those callers administrator-only.

This guide is written for a **human** setting the module up. If you want terse,
token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.
2. [Configuration](configuration/index.md) — enter your APITemplate.io endpoint
   and API key, set a default template, and use the Test Tool.

## Where it lives in the admin menu

The settings form is at **Configuration → System → APITemplate.io**
(`/admin/config/system/apitemplate-io`). The permission is set at
**People → Permissions** (`/admin/people/permissions`).
