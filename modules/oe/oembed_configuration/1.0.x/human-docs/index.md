# oEmbed Configuration — manual setup guide

**oEmbed Configuration** (`oembed_configuration`) gives you a settings screen for
fine‑tuning how Drupal's oEmbed media (remote video and other rich embeds) is
displayed. Drupal core can embed content from providers like YouTube and Vimeo, but
it exposes few knobs for *how* those embeds behave. This module adds a UI where you
set provider‑specific parameters — so you can, for example, turn autoplay on or
off, suppress tracking, or hide surrounding chrome — beyond what core offers on its
own.

At the time of writing it supports:

- **YouTube** — autoplay.
- **Vimeo** — autoplay, do‑not‑track, background, and more.
- **X / Twitter** — hide threads, do‑not‑track, theme, and more.
- **Instagram** — omit script, authentication.

For every provider it also offers a **base‑path override** for the embed request,
which makes privacy‑friendly swaps possible — for instance replacing `youtube.com`
with `youtube-nocookie.com`. It depends on core's **Media** module and provides its
own permission.

It's worth remembering that oEmbed embeds load **third‑party content** (as core
oEmbed does); core sandboxes those embeds, and this module doesn't change that, but
you should still only enable providers you trust. The module has no access‑control
role beyond its own permission.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.
2. [Configuration](configuration/index.md) — the per‑provider settings and the
   base‑path override.

## Where it lives in the admin menu

Once enabled, the settings page sits at **Configuration → Media → oEmbed
Configuration**. See [Configuration](configuration/index.md) for a walk through the
options.
