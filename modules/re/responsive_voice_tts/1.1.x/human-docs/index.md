# Responsive Voice Text to Audio — manual setup guide

**Responsive Voice Text to Audio** (`responsive_voice_tts`) adds **text‑to‑speech
("read aloud")** to your content using the third‑party **ResponsiveVoice**
service and its JavaScript library. Administrators choose which content types show
a **"Listen to this content"** button, and visitors can then have the page's text
read out with play and stop controls. It's aimed at accessibility and
convenience — helpful for visually impaired or dyslexic users, multilingual
audiences, and content like blogs, news, or educational articles where an audio
option improves the experience.

The button supports multiple **voices** (languages and accents) and keyboard
shortcuts — **Shift + P** to play and **Shift + S** to stop or resume. You place
its block in any theme region for flexible, site‑wide or page‑specific placement,
and you can customize the button text.

> **Third‑party service and privacy.** This module loads the **ResponsiveVoice.js**
> library from ResponsiveVoice and uses their service to synthesize speech, which
> means page/node text is sent to that external service. Treat this as an
> **egress and consent** consideration: review ResponsiveVoice's terms and
> licensing, be mindful of sending sensitive content off‑site, and consider
> whether you need to disclose this to your users. You will also need an **API
> key** from ResponsiveVoice (see below). The module reads content the user can
> already see and has **no access‑control role**.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — choose content types, set the button
   text and voice, enter your ResponsiveVoice API key, and place the block.

## Where it lives in the admin menu

The module's settings live at **Configuration → Web Services → Responsive Voice
TTS Settings**. The "Listen to this content" button is delivered through the
**Responsive Voice TTS** block, placed at **Structure → Block layout**. See
[Configuration](configuration/index.md) for the full walk‑through.
