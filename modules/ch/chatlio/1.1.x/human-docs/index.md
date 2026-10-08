# Chatlio — manual setup guide

**Chatlio** (`chatlio`) embeds the [Chatlio](https://chatlio.com/) live‑chat widget
into your Drupal site. Chatlio is a hosted live‑chat service that connects your
website visitors to your team through Slack — visitors start a chat from a widget on
your pages, and your team answers from within Slack. This module is the simple
bridge that drops Chatlio's embed code into Drupal.

Setup is straightforward: you create a Chatlio account, copy the embed snippet from
your Chatlio dashboard, and paste it into the module's settings form. You can
optionally add visibility rules to control where the widget appears. There are no
other module dependencies and no libraries to install manually — the widget's
JavaScript loads from Chatlio.

Two things to be aware of. Because the widget loads Chatlio's third‑party
JavaScript, **visitor data goes to Chatlio** — review the privacy implications for
your site. And this module is minimally maintained (maintenance fixes only). It has
no content or access role of its own; it simply places the widget.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.
2. [Configuration](configuration/index.md) — paste the Chatlio embed code and set
   optional visibility.

## Where it lives in the admin menu

The settings form is at **Configuration → Web services → Chatlio**
(`/admin/config/services/chatlio`).
