# ConsentX — manual setup guide

**ConsentX** (`consentx`) connects your Drupal site to the **ConsentX** cloud
consent‑management platform (CMP) to give you a full cookie‑consent banner with
one‑click setup. Unlike a notice‑only banner, ConsentX is a genuine consent
manager: it presents a consent banner, implements **Google Consent Mode v2**, and
**blocks third‑party scripts until the visitor gives consent** — the behaviour that
actually satisfies GDPR / ePrivacy and similar regimes (the vendor also advertises
CCPA/CPRA, LGPD, DPDPA and others). It supports Drupal 9, 10 and 11 and needs no
other modules.

The model is deliberately hands‑off: you connect a **ConsentX account** from the
module's settings, your website is registered with ConsentX automatically, and the
banner becomes active immediately. Because the heavy lifting (cookie scanning,
geo‑aware rules, the consent dashboard, consent logging, banner appearance) happens
in the ConsentX service, most day‑to‑day configuration is done in the ConsentX
console rather than in Drupal — the module is the connector.

**Two things to be clear about.** First, this is a **cloud‑backed** integration: it
requires a ConsentX account and an internet connection so the site can talk to
ConsentX services, and consent data flows through that third‑party platform — a
point to note in your own privacy documentation and vendor assessments. Second,
the connection is set up entirely from the module's settings screen (a 1‑click
handshake, or a **Site key** you paste in): the site key and token it records are
saved in the module's `consentx.settings` configuration. Note the project is
**not covered by Drupal's security advisory policy**.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable it.
2. [Configuration](configuration/index.md) — connect your ConsentX account and
   handle credentials safely.

## Where it lives in the admin menu

ConsentX adds a settings area where you connect your account; it provides its own
permission for reaching it. Once connected, the banner and script‑blocking are
served automatically, and most fine‑tuning happens in the ConsentX console
(documentation at `https://docs.consentx.io`).
