# Stackla Widget — manual setup guide

**Stackla Widget** (`stackla_widget`) connects a Drupal site to the Stackla
visual-UGC service (now part of Nosto) and lets editors embed Stackla
user-generated-content widgets on their content through a dedicated field.

Stackla is a platform that discovers, manages, and displays user-generated visual
content — social photos and videos, brand assets, and so on — that marketers curate
into "widgets." This module is the bridge: an administrator authorises the site
against a Stackla account over OAuth2, and content authors can then drop a chosen
Stackla widget onto a node (or any fieldable entity) via a field type, widget, and
formatter the module provides. Behind the scenes a small Guzzle-based SDK talks to
the Stackla REST API to list widgets and fetch their embed markup.

Setup has two parts: filling in the settings form (Stack shortname, OAuth2 client
ID and secret, and a few options), and running the OAuth2 authorise flow so Drupal
obtains and stores an access token. After that, editors add the Stackla field to a
content type and pick a widget by id.

A few security points are worth knowing before you go live, because they come from
this module's own code. **Avoid the outbound-proxy option unless you fully trust
the network path:** enabling the proxy also disables TLS certificate verification
in the SDK, which means the OAuth token exchange (carrying your client secret) and
the returned access token could be exposed to a man-in-the-middle. **Leave debug
mode off in production:** with it on, the OAuth callback logs the full client id,
client secret, authorization code, and callback in cleartext to the log. The client
secret is also stored in module configuration and shown in a plain text field. If
debug logs may ever have captured the secret, rotate it. The OAuth callback route
itself is permission-gated (it is not an anonymous endpoint).

The module provides two permissions — `administer stackla` (for the settings and
authorisation) and `use stackla` (for the OAuth callback and editing widgets) —
depends on the `guzzlehttp/guzzle` library, has no submodules, and runs on Drupal 8,
9, and 10.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — enter your Stackla credentials, run
   the OAuth2 authorise flow, and add the widget field.

## Where it lives in the admin menu

The settings form is at **Configuration → Web services → Stackla Widget → Settings**
(`/admin/config/services/stackla_widget/settings`), gated by the `administer
stackla` permission. The OAuth callback lives at
`/admin/config/services/stackla_widget/oauth` (gated by `use stackla`).

## How the feature surfaces

Once the site is authorised, add the **Stackla widget** field to a content type via
**Manage fields**. On an entity's edit form the field lets an author select a
Stackla widget by id, and the formatter renders that widget's embedded UGC content
on the published page. Grant `administer stackla` to configuration administrators
and `use stackla` to the editors who place widgets.
