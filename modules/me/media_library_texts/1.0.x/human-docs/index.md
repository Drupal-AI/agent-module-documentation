# Media Library Widget Texts — manual setup guide

**Media Library Widget Texts** (`media_library_texts`) lets you overwrite the text
shown in the Media Library selection widget. The classic example is changing the
**"Add media"** button to say **"Add image"** — but the same applies to the widget's
labels, help text, and empty‑state wording. You get per‑site phrasing (and clearer
guidance for your editors) without overriding templates or patching core.

It's a small, focused module: it adds a settings form where you type in your
replacement wording, and the Media Library widget then uses your text in place of
the core defaults. It builds on Drupal core's Media Library module and provides its
own permission so you can control who may change the wording.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — the settings form where you enter your
   replacement texts.

## Where it lives in the admin menu

The module adds a settings form for the Media Library widget texts, reached from the
**Configuration → Media** area (you can also follow the module's configuration link
on the **Extend** page). See [Configuration](configuration/index.md) for details.

## How to use it

Enable the module, open its settings form, type the wording you want in place of the
defaults (for example replacing "Add media" with "Add image"), and save. Editors
then see your text throughout the Media Library widget.
