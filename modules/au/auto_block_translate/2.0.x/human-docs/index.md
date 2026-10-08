# Auto Block Translation — manual setup guide

**Auto Block Translation** (`auto_block_translate`) automatically translates
custom (content) blocks using a configured translation service. Instead of
translating each block by hand, you point the module at a translator and let it
create the block translations for you.

Most translation tooling in Drupal focuses on nodes and other content entities;
custom blocks — the reusable chunks you place in regions — are easy to overlook
and tedious to translate one by one. This module fills that gap: it sends a
block's content to the translator you have configured and produces the
translation without manual effort.

Because auto-translation removes the human "should this even be sent?" gate, use
it deliberately. Block content is sent to the configured translation service —
often an external machine-translation provider — which is a data-handling
consideration for anything sensitive. And machine output is a starting point:
auto-created translations may still need review before you rely on them. The
module has no access-control role of its own; what matters is which translator
you choose and which blocks you let it translate.

If your chosen translator talks to an external API, treat its credentials as
secrets — keep them in an environment variable or a Key entity, never in
exported/committed configuration.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.
2. [Configuration](configuration/index.md) — choose the translator and control
   which blocks are translated.

## Where it lives in the admin menu

The module's settings are stored under the `auto_node_translate.settings`
configuration, where you choose the translation service and which blocks it
should translate. See [Configuration](configuration/index.md).
