# Bigin CRM — manual setup guide

**Bigin CRM** (`bigin_crm`) integrates Drupal with Zoho Bigin, the small-business CRM
from Zoho. It syncs contacts and leads — for example, people who submit a form on
your site — into Bigin, so your sales pipeline is fed automatically from your
website rather than by manual copy-paste.

It is an integration feature. The module defines its own permissions to control who
may manage it, but it has no access-control role beyond that. Its job is to move
contact and lead data from Drupal into Zoho Bigin through the Bigin API.

Two things deserve care. First, the module **sends contact and lead data — personal
information — to an external service (Zoho Bigin)**. That outbound data flow should
be disclosed in your privacy policy. Second, it authenticates to Zoho with **OAuth
credentials**, which are secrets: store them in the environment (and reference them
through a Key entity or `getenv()`), never in plain committed configuration, and
connect over HTTPS. The [Configuration](configuration/index.md) guide covers the
secure-credential steps.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — store the Zoho Bigin OAuth
   credentials securely and connect the CRM.

## Where it lives in the admin menu

The module defines its own permissions (set them under **People → Permissions**,
`/admin/people/permissions`) and stores the Zoho OAuth credentials it needs to reach
the Bigin API.

## How to use it

1. Install and enable the module (see [Installation](installation/index.md)).
2. Register an application in Zoho, obtain the OAuth credentials, store them
   securely, and connect the module (see [Configuration](configuration/index.md)).
3. Grant the module's permission to the appropriate roles, then let contacts and
   leads from your site sync into Zoho Bigin — remembering to disclose the data
   transfer in your privacy policy.
