# ReadRemaining — manual setup guide

**ReadRemaining** (`readremaining`) shows your readers how long they still have to
go. It puts a small, unobtrusive gauge on your content that estimates the
remaining reading time, so a visitor landing on a long article can see at a glance
how much is left instead of bouncing. It's a gentle "TL;DR is a thing of the past"
touch that makes lengthy pages feel more approachable.

Under the hood it uses the **ReadRemaining.js** library (MIT‑licensed) to draw the
indicator, and a settings form lets you choose which content types it appears on
and fine‑tune its look and behavior. You pick the content types, optionally adjust
the DOM selector it measures and a few JavaScript options, save, and the gauge
appears when you view a node of a selected type.

This is the **2.2.x** branch, which supports **Drupal 10 and 11**. (The newer
2.3.x branch targets Drupal 11 and 12 and pulls the library in as a normal
Composer dependency; on 2.2.x you add the library's package definition to your
project's `composer.json` yourself, as described in Installation.)

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module and the
   ReadRemaining.js library, then enable it.
2. [Configuration](configuration/index.md) — choose content types and tune the
   gauge's look and behavior.

## Where it lives in the admin menu

The settings form is at **Configuration → System → ReadRemaining**
(`/admin/config/system/readremaining`).

## How to use it

1. Install the module and the ReadRemaining.js library
   ([Installation](installation/index.md)).
2. Enable the module.
3. Open **Configuration → System → ReadRemaining** and select the content types
   the gauge should appear on ([Configuration](configuration/index.md)).
4. Save, then view a node of one of those content types — the reading‑time gauge
   appears.
