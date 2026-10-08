# COOKiES Telegram Media — manual setup guide

**COOKiES Telegram Media** (`cookies_telegram_media`) is a small "glue" module
that brings embedded Telegram media under the control of the
[COOKiES Consent Management](https://www.drupal.org/project/cookies) cookie
banner. When a page embeds Telegram media (provided by the
[Telegram Media Type](https://www.drupal.org/project/telegram_media_type) module),
this integration blocks that embed until the visitor grants consent through the
COOKiES banner — and then loads it once consent is given. That keeps third‑party
Telegram embeds GDPR‑friendly.

It solves a common privacy problem: a raw third‑party embed can set cookies and
contact an external service the moment the page loads, before the visitor has
agreed to anything. This module defers the Telegram embed behind the consent
decision so nothing loads until consent exists.

Because it is consent glue, it works as soon as it is enabled — there is no
settings form of its own. It depends on both the **COOKiES** module and the
**Telegram Media Type** module, and it works on Drupal 9.3+, 10, and 11.

> **Note:** at the time of writing the project is listed as *seeking a new
> maintainer*, so weigh that when planning long‑term use.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module alongside COOKiES and Telegram Media Type.

There is **no configuration page** for this module. Once COOKiES, Telegram Media
Type, and this module are all enabled, Telegram embeds are gated by consent
automatically. You manage consent categories and the banner from the COOKiES
module's own settings.

## Where it lives in the admin menu

This module adds no admin page of its own. Manage the consent banner and its
categories from the **COOKiES** module's settings; this module simply registers
Telegram media as a consent‑gated service.

## How to use it

1. Install and configure the **COOKiES** consent module and its cookie banner.
2. Install the **Telegram Media Type** module and add your Telegram media as
   usual.
3. Enable this module. From then on, Telegram embeds stay blocked until a visitor
   consents through the COOKiES banner, and load only afterward.
