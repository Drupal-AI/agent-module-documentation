# Poool — manual setup guide

**Poool** (`poool`) integrates the third-party **Poool Access** paywall and
subscription service (poool.fr) into Drupal. It is aimed at publishers who use Poool
to run metered or premium content: the module marks pages and fields as free,
premium, subscription or registration content, injects Poool's tracker JavaScript
with your Poool **application id**, and lets Poool's widget decide what a visitor
can read.

The single most important thing to understand about this module is **how it
enforces the paywall: it does not.** Enforcement is **client-side only**. The full
protected content is rendered into the page's HTML and merely blurred or truncated
in the browser by Poool's JavaScript. Anyone who disables JavaScript or reads the
page source can see the "protected" content — the module performs no server-side
redaction. This is the nature of Poool's soft-paywall model, not a bug, but you must
not treat it as real access control for anything that genuinely must stay private.

A second thing worth knowing: the Poool **application id is a public key**, not a
secret. It is validated against Poool's key format and then embedded in the page for
the browser to use. The module stores and transmits **no secret API key**, so
there is no credential to protect here — the id is meant to be public. The tracker
script is loaded over HTTPS from `assets.poool.fr`.

Which visitors count as "premium" is decided by an event the module dispatches
(`PooolUserIsPremiumEvent`); by default nobody is premium, and another module or
custom code subscribes to that event to grant premium access (which disables the
widget for that user).

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — enter your Poool application id and set
   your page types, visibility and field rules.

## Where it lives in the admin menu

The settings live at **Configuration → Web services → Poool**
(`/admin/config/services/poool`), behind the core **Administer site configuration**
permission. The module defines no permissions of its own beyond that.
