# b24 — manual setup guide

**b24** (`b24`) connects Drupal to **Bitrix24 CRM**. It gives you the tools to talk to
the Bitrix24 API so data captured on your site — leads, contacts, orders — can flow
into your CRM. A set of submodules wires this into the specific places that data comes
from: Commerce orders, contact forms, user accounts, UTM tracking, and Webform
submissions. It runs on Drupal 9, 10 and 11 and sits in the `bitrix24` package.

The core module holds the connection to Bitrix24 and defines its own permission; the
submodules are optional add‑ons you enable only for the integrations you actually use.

To reach Bitrix24 the module authenticates with API credentials — a **webhook URL** or
**OAuth** credentials. Store those as secrets rather than in exported configuration,
and operate over HTTPS. Bear in mind that the data you push (contact and lead PII) is
sent to a third‑party service, which is a privacy consideration for consent and
handling. See [Configuration](configuration/index.md).

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable the base
   module and the submodules you need.
2. [Configuration](configuration/index.md) — enter the Bitrix24 credentials and map
   your data.

## Where it lives in the admin menu

The Bitrix24 credentials are configured at the module's credentials form (route
`b24.credentials`). Each submodule adds its own configuration for the source it
integrates (Commerce, contact, user, UTM, Webform).
