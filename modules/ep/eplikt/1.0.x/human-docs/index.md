# e-Plikt — manual setup guide

**e-Plikt** (`eplikt`) helps organisations meet **legal‑deposit** ("mandatory
delivery") obligations — the requirement, in some countries, to deliver published
digital material to a national library. Developed with the National Library of
Sweden in mind, the module publishes the content covered by those obligations as an
**RSS feed**, with downloadable media attached, so the receiving institution can
harvest it in a standard way.

It works by turning your existing Drupal content into a legal‑deposit feed. Two
**source plugins** ship with the module — **Node** and **Media** — which cover most
cases; if you have a more complex content structure or embedded content that must be
included in the delivery, you can write your own source plugin.

One thing to weigh from the outset: the feed **exposes entity content and
downloadable media** to whoever can read it. If the material is not meant to be
public, restrict who can reach the feed, and make sure only the intended
mandatory‑delivery items are included.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer, pull
   in its Media dependencies, and enable it.
2. [Configuration](configuration/index.md) — the e-Plikt settings page, field by
   field, and choosing your sources.

## Where it lives in the admin menu

e-Plikt is configured at **Configuration → Web services → e-Plikt**
(`/admin/config/services/eplikt`), where you set your publisher identifier, default
access rights, and which content sources to include in the delivery.
