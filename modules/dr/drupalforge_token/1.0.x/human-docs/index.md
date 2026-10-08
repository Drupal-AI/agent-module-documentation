# Drupal Forge Token — manual setup guide

**Drupal Forge Token** (`drupalforge_token`) plugs into Drupal's **Token** system
to provide tokens for embedding **Drupal Forge launch widgets**. Drop one of its
tokens into content or configuration and it renders a "Launch on Drupal Forge"
widget or button — so visitors can start a demo directly from your page instead
of first navigating over to Drupal Forge.

The problem it solves is reducing friction for try‑it links. If you write
documentation, landing pages, or module pages and want a one‑click way for people
to spin up a live demo on Drupal Forge, you would otherwise hand‑craft the launch
markup each time. This module exposes reusable tokens that render the widget for
you, anywhere Drupal's token replacement runs.

> **Note:** despite the name, these are Drupal **Token‑system placeholders** for
> embedding a launch widget — not a secret API token or credential. There is
> nothing sensitive to store.

It supports Drupal 8 through 11 and has no configuration UI of its own — enabling
it makes the tokens available.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

There is **no configuration page** for this module — it registers tokens and has
no settings form of its own.

## How to use it

Once enabled, the module's Drupal Forge tokens become available wherever token
replacement is supported — for example in text fields and text formats that run
tokens, or in any module that offers a token browser. Insert the appropriate
Drupal Forge token into your content, and on render it is replaced with the
"Launch on Drupal Forge" widget/button. Look for the Drupal Forge group in a
**token browser** (the "Browse available tokens" link near supported fields) to
see the exact token names provided.
