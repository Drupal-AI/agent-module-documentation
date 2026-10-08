# Iframe Consent — manual setup guide

**Iframe Consent** (`iframe_consent`) keeps third‑party iframes from loading
until the visitor has actually agreed to them. Embeds like YouTube videos, Google
Maps, or social‑media widgets often set cookies and phone home the moment they
render — which, without consent, is a GDPR problem. This module holds those
iframes back and only loads them once the visitor has granted the matching
consent group from your cookie banner.

The privacy purpose is the whole point: by deferring the embed until consent,
you avoid third‑party tracking *before* the visitor has said yes. In place of a
blocked iframe, the module shows a customizable placeholder — a message or design
that tells visitors the content needs their consent — so the page doesn't just
show an empty gap.

Iframe Consent does **not** ship its own cookie banner. It's designed to work
alongside an existing consent mechanism — an external banner such as OneTrust, or
a Drupal module like EU Cookie Compliance that doesn't block iframe content on
its own. You configure iframe behavior globally to line up with your
domain‑level consent settings, and a single iframe type can be assigned more than
one consent group for flexibility. It depends on core's **Options** module and
provides its own permission.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — map consent groups to iframe types,
   set global/domain behavior, and customize the placeholder.

## Where it lives in the admin menu

The module's settings — global iframe behavior, the consent groups assigned to
each iframe type, and the placeholder shown for blocked content — live on its
configuration form under **Configuration**. See
[Configuration](configuration/index.md).
