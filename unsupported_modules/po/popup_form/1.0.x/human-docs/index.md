# Popup Entity (with integration) — manual setup guide

**Popup Entity** (`popup_form`) — distributed as the Drupal project
`popup_entity_with_integration` — lets you define configurable **popup entities** that display
as modals over the page, with built‑in integration for **Webform**, **Paragraphs**, and
**Block** content. In other words, a popup's contents can be a webform, a paragraph, or a
block, which makes it a flexible way to run announcements, sign‑up forms, and promotions.

Popups are ordered by a weight field, so when more than one is eligible to appear you control
the sequence. The module depends only on Drupal core's **Block** and **System** modules and
supports Drupal 10 and 11.

This guide is written for a **human** clicking through the admin UI. If you want terse,
token‑cheap references for an AI coding agent, read the sibling [`agent/`](../agent/start.md)
docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and enable it.

This module has no central settings form; you create and order popup entities directly and
give each one its content (a webform, paragraph, or block). See "How to use it" below.

## How to use it

1. Create one or more **popup entities**, giving each the content you want to show — a
   Webform, a Paragraph, or a Block.
2. Set each popup's **weight** to control the order in which eligible popups appear.
3. Publish the popups; they render as modals over the page for the audiences you configure.

Because the content comes from Webform, Paragraphs, or Block, build those pieces first (for
example, create the webform you want to embed) and then reference them from the popup.
