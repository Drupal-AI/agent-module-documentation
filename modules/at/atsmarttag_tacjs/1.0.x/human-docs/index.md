# AT Internet SmartTag for TacJS — manual setup guide

**AT Internet SmartTag for TacJS** (`atsmarttag_tacjs`) is a small "glue" module
that registers the **AT Internet** (Piano) SmartTag tracker as a **consent‑managed
tag** inside the **TacJS** tag‑and‑consent manager. Its whole purpose is to make
AT Internet analytics load only *after* a visitor has granted consent, so you can
meet GDPR‑style opt‑in requirements.

It connects two existing modules: it declares an `atinternet_smarttag` entry in
TacJS's *analytic* group (so the SmartTag appears in the consent banner's list of
services), and it attaches the relevant JavaScript on non‑admin pages. The tracker's
actual site id and tracking options come from the **AT Internet SmartTag**
(`atsmarttag`) module; the consent behaviour comes from **TacJS**. It runs on Drupal
9.5, 10, and 11.

This module has **no routes, permissions, or configuration of its own**, and it
holds no secrets and makes no server‑side external calls — it only wires the
client‑side tag loading through the consent layer. You configure the tracker itself
in `atsmarttag`, and the consent banner in TacJS.

This guide is written for a **human** setting the module up. If you want terse,
token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it (alongside TacJS and AT Internet SmartTag).

## Where it lives in the admin menu

Nowhere of its own. Because it has no configuration, you manage the two sides it
bridges elsewhere: the tracker settings in **AT Internet SmartTag** (Configuration →
System → AT Internet SmartTag settings) and the consent banner / service list in
**TacJS**.

## How to use it

1. Install and enable TacJS, AT Internet SmartTag, and this module (see
   [Installation](installation/index.md)).
2. Configure the AT Internet SmartTag tracker (site id, collection domains) in the
   `atsmarttag` module.
3. Configure your TacJS consent banner. The AT Internet SmartTag now appears in the
   TacJS *analytics* group, and its tracking only fires once a visitor accepts
   analytics consent.
