# Outbound — manual setup guide

**Outbound** (`outbound`) is a **link‑field formatter** that routes clicks on your
external links through an intermediate "you are about to leave this site" page
before sending the visitor on to the external destination. This kind of
interstitial disclaimer is common on government and institutional sites, where
policy requires warning users when they're leaving the official site.

It builds on core's **Link** field: instead of linking straight to the external
URL, you choose the Outbound formatter on the link field's display, and Drupal
renders the link so that clicking it lands the visitor on the interstitial page
first, then continues to the destination.

> **Good to know:** the destination is whatever URL the editor entered in the link
> field. That's normally editor‑trusted content, but if less‑trusted users can set
> link fields on your site, treat the eventual redirect as you would any
> user‑supplied URL.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

There is **no configuration page** — Outbound is a field formatter you select on a
link field's display. How to use it is described below.

## How to use it

1. Make sure you have a **Link** field on the content type (or other entity) whose
   external links you want to route through the interstitial.
2. Go to **Structure → Content types → *(type)* → Manage display**.
3. For the link field, set its **Format** to the **Outbound** formatter and save.
4. Now, when that link is rendered, clicking it takes the visitor to the
   "leaving the site" interstitial page before continuing to the external URL.
