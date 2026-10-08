# Neuraflow — manual setup guide

**Neuraflow** (`neuraflow`) provides Drupal integrations for the AI products from
**Neuraflow GmbH**. In this release the headline feature is the **neurabot
integration** — embedding Neuraflow's AI assistant into your site — with room for
further Neuraflow product integrations over time. It is the bridge layer between
Drupal and Neuraflow's AI/automation platform.

To run the neurabot integration you need a valid **assistant ID** from Neuraflow,
which requires an active contract with Neuraflow GmbH. Once you have that, you enter
it in the module's settings and configure how the assistant displays on your site.
Because the assistant is powered by Neuraflow's service, treat this as an external
AI integration: visitor interactions are handled by Neuraflow, which is a
data-egress and privacy consideration you should be comfortable with and disclose
where required.

The module gates its administration behind the `administer neuraflow` permission,
and any API credentials should be stored securely rather than committed. It depends
on Drupal core only and runs on Drupal 10.3 and 11.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — enter your Neuraflow assistant ID and
   set up display settings.

## Where it lives in the admin menu

The settings form is at **Configuration → Web services → Neuraflow**
(`/admin/config/services/neuraflow`). Administration is controlled by the
`administer neuraflow` permission, granted at **People → Permissions**
(`/admin/people/permissions`).
