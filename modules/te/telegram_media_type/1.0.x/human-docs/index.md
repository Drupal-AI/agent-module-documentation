# Telegram Media Type — manual setup guide

**Telegram Media Type** (`telegram_media_type`) plugs Telegram into Drupal's core
Media system. It provides a **media source** for Telegram, so once you create a
matching media type your editors can add Telegram posts and videos the same way
they add any other managed media — through an entity form or the core **Media
Library**. They paste a Telegram URL and the module generates the embed for you.

The problem it solves is consistency: rather than hand‑pasting Telegram embed
snippets into body fields, you get first‑class media entities you can reference
from fields, reuse across content, and manage centrally. The module's codebase
was modelled on how the Media Entity Twitter and Media Entity Facebook modules
were written, so it follows the familiar Drupal media‑source pattern.

This module does **not** work purely on‑enable: after installing it you must create
a Telegram media type and point it at the Telegram media source (see below). It
depends only on Drupal core's **Media** module, and there are no submodules.

Be aware that a Telegram embed pulls external content into the visitor's browser
via an iframe, which loads Telegram's third‑party cookies. In regions with consent
laws (for example the EU) you generally cannot load non‑essential cookies until the
visitor has agreed, so plan for a cookie‑consent solution if that applies to you.

This guide is written for a **human** setting the module up through the admin UI.
If you want terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.
2. [Configuration](configuration/index.md) — create the Telegram media type, set
   its formatter, and grant permissions.

## How to use it

Once the media type exists, editors create Telegram media at
`/media/add/telegram` (or through the **Media Library** when adding media to a
field): they paste the Telegram URL and the module builds the embed. There is no
central settings page — the module's behaviour is defined entirely by the media
type you create.
