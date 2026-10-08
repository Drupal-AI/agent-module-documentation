# Salesforce Messaging for Web — manual setup guide

**Salesforce Messaging for Web** (`salesforce_mfw`) embeds Salesforce's "Messaging
for Web" live-chat utility into your Drupal site through a configurable **block**.
It lets you offer real-time customer support chat on your pages, with pre-chat
fields you define, multilingual support, and the ability to pass context (from
tokens, cookies or local storage) into the chat before it opens.

You place the block wherever you want chat to appear, then fill in the public
Salesforce embed parameters — organization ID, config name, and the site, snippet
and utility-bootstrap URLs Salesforce gives you — plus a language and a table of
pre-chat fields. Those values are handed to the browser as `drupalSettings`, and
the module fires a JavaScript event so a developer can adjust the configuration
client-side before the chat loads. Optional token replacement (via the required
**Token** module) can expand tokens in your pre-chat default values, and a
path-override option keeps a chat session alive as the visitor moves between pages.

The module needs configuration to do anything — an empty block shows no chat. It
depends on the **Token** module, has no submodules, and requires no third-party PHP
libraries. It does, of course, require a Salesforce account on a service tier that
includes Messaging for Web.

This guide is written for a **human** using the admin UI. If you are an AI coding
agent, read the sibling [`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — Composer, the Token dependency, and
   enabling the module.
2. [Configuration](configuration/index.md) — placing the block and filling in its
   Salesforce parameters and pre-chat fields.

## Where it lives in the admin menu

There is no central settings page; configuration happens on the block itself. Place
the **Salesforce MFW** block through **Structure → Block layout**
(`/admin/structure/block`) and configure it there. Block administration is
protected by the **Administer salesforce_mfw blocks** permission (marked as a
restricted permission).

## Security, in plain terms

The values you enter are **public Salesforce embed identifiers, not secret API
keys** — Messaging for Web is designed to run in the browser. The module makes no
server-side calls to Salesforce and provides no anonymous submission endpoint: chat
messages go directly from the visitor's browser to Salesforce. The one thing to be
careful about is token replacement — any token you use in a pre-chat default value
is resolved and serialized into the client-visible `drupalSettings`, so do **not**
map tokens that resolve to sensitive data.
