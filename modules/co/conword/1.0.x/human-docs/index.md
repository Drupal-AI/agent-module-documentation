# Conword — manual setup guide

**Conword** (`conword`) integrates Drupal with **Conword**, a DeepL‑based
translation and content‑collaboration service from Conword GmbH. It lets your site
exchange content with the Conword platform for translation or collaborative
editing, wiring the external service into your content workflows.

The module works against a hosted commercial service, so it does not do anything
useful until you configure it: you need a valid **customer ID**, which requires a
contract with Conword GmbH. Once you enter your customer ID and choose your display
settings on the module's settings form, the integration is active. Administration
is gated by a dedicated **`administer conword`** permission, so only trusted users
can change the connection.

Because Conword **exchanges your content with an external service**, review what
content is sent, disclose the integration where appropriate, and store any API
credentials as environment‑backed secrets rather than in exported configuration.
The customer ID itself is an account identifier (configuration), not a secret.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.
2. [Configuration](configuration/index.md) — enter your customer ID and set the
   display options.

## Where it lives in the admin menu

Once enabled, configure the module at **Configuration → Web services → Conword**
(`/admin/config/services/conword`).
