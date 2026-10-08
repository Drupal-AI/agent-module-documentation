# ReadRemaining — manual setup guide

**ReadRemaining** (`readremaining`) shows your readers how long they still have to
go. It puts a small, scroll‑driven gauge on your content that estimates the
remaining reading time, so a visitor landing on a long article can see at a glance
how much is left instead of bouncing. It's a gentle "TL;DR is a thing of the past"
touch that makes lengthy pages feel more approachable.

Under the hood it integrates the **aerolab/readremaining.js** library to draw the
indicator, and it attaches that library only on nodes of the content types you
choose. A settings form lets you pick those content types, switch between a dark
and light look, and tune the JavaScript behavior in detail — the element it
measures, when the gauge appears, thresholds for showing it, offsets, the time
format, and more.

This is the **2.3.x** branch, which requires **Drupal 11 or 12** and pulls the
library in as a normal Composer dependency (`aerolab/readremaining`). It also adds
a dedicated **Administer ReadRemaining** permission so you can hand the settings
form to a trusted role without granting broader admin rights. (The older 2.2.x
branch supports Drupal 10/11 and installs the library via a `composer.json`
repositories snippet instead.)

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module and the
   aerolab/readremaining.js library, then enable it.
2. [Configuration](configuration/index.md) — choose content types and tune the
   gauge's look and behavior, field by field.

## Where it lives in the admin menu

The settings form is at **Configuration → System → ReadRemaining**
(`/admin/config/system/readremaining`), gated by the **Administer ReadRemaining**
permission.

## How to use it

1. Install the module and the aerolab/readremaining.js library
   ([Installation](installation/index.md)).
2. Enable the module and grant **Administer ReadRemaining** to the roles that
   should manage it.
3. Open **Configuration → System → ReadRemaining** and select the content types
   the gauge should appear on ([Configuration](configuration/index.md)).
4. Save, then view a node of one of those content types — the reading‑time gauge
   appears.
