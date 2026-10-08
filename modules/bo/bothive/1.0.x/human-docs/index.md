# Bothive Chatbot — manual setup guide

**Bothive Chatbot** (`bothive`) embeds the [Bothive](https://bothive.be) chatbot
widget on your Drupal site. Bothive is a third-party service (popular with Belgian
and accountancy sites) that provides an automated assistant for support and lead
capture; this module loads the Bothive widget so visitors can chat with that
assistant on your pages.

The widget works by loading Bothive's own third-party JavaScript into your site.
That means visitor interactions flow to Bothive, so review their privacy and
data-handling terms before turning it on, and account for it in your site's
privacy notice. Configuration is gated by the `administer bothive configuration`
permission, so only trusted administrators can change how the widget is wired up.

Because the widget connects your site to a Bothive account, treat any account
credential it needs (an API token or key) as a **secret**: keep it in an
environment variable rather than committed configuration. See
[Configuration](configuration/index.md) for the credential-handling steps.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.
2. [Configuration](configuration/index.md) — connect your Bothive account, set
   the permission, and handle credentials safely.

## Where it lives in the admin menu

Bothive adds a settings form for its configuration, reachable by users with the
**administer bothive configuration** permission (set under **People →
Permissions**). See [Configuration](configuration/index.md).

## How to use it

1. Install and enable the module (see [Installation](installation/index.md)).
2. Grant `administer bothive configuration` to the right role.
3. Enter the Bothive account details the widget needs, keeping any secret token in
   an environment variable rather than in committed config.
4. Load a front-end page and confirm the Bothive chatbot widget appears and
   connects.
