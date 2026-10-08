# Consent Mode — manual setup guide

**Consent Mode** (`consent_mode`) puts Google's **Consent Mode v2** default state
onto your pages before any Google tag runs. Google expects a
`gtag('consent', 'default', {...})` call to execute *before* your analytics or ads
tags, declaring what the site assumes about a visitor's consent until they choose.
This module does exactly that: it emits that default call at the top of the page,
with the values kept in configuration rather than hard‑coded in a theme template,
and every one of the six consent signals — `ad_storage`, `analytics_storage`,
`ad_user_data`, `ad_personalization`, `functionality_storage`,
`personalization_storage` — defaults to **denied**, which is the correct and safe
default (and what the EEA requires).

The most important thing to understand is what this module **does not** do: it
declares the *default* denial, but it does **not** show a banner and does **not**
capture consent. Something else — a consent management platform (CMP) such as
Usercentrics or Cookiebot, or your own banner — must send the
`gtag('consent', 'update')` call when the visitor makes a choice. Pairing the two
is the normal setup. If you install **only** this module, the site will correctly
deny by default and then never grant, which is compliant but will make your
analytics read close to zero. Always deploy it alongside a consent tool that sends
the update.

It has no dependencies, supports Drupal 8 through 11, and its settings form is
gated by a dedicated `access consent mode config` permission that is deliberately
**not** marked restricted — so you can delegate consent defaults to a marketing
role without handing over full "administer site configuration" rights.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable it.
2. [Configuration](configuration/index.md) — the settings form, signal by signal,
   and how to pair it with a consent banner.

## Where it lives in the admin menu

Once enabled, the settings form is at `/admin/config/consent_mode`. Access is
controlled by the `access consent mode config` permission.
