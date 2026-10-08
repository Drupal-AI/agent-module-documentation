# Babel Brush — manual setup guide

**Babel Brush** (`babel_brush`) is a housekeeping tool for multilingual sites. It gives
you a search‑and‑management interface for finding and cleaning up translations — the
orphaned, inconsistent or unused translation strings and content that accumulate on a
site that has been translated over time — so your translation data stays tidy.

It builds on core's **Locale** module and runs on Drupal 10 and 11. Access to its
search form is gated by the `administer babel brush search form` permission.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

> **Note on depth:** this is an early‑stage module (1.0.0‑alpha1) and its upstream
> documentation is thin. This guide describes what it does and how to reach it; the
> exact on‑screen layout of its search and cleanup tools may differ from what is
> described here.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable it
   alongside Locale.

## How to use it

Babel Brush is aimed at site maintainers rather than day‑to‑day editors. Once enabled,
grant the `administer babel brush search form` permission to the users who look after
translations, then use the module's search form to locate translation entries you want
to review — for example ones that are orphaned or inconsistent — and clean them up.
Because it works on top of core Locale, it operates on the same translation data Drupal
already stores. As with any bulk cleanup tool, take a database backup before deleting
translations in quantity, and remember this is an alpha release best exercised on a
non‑production copy first.
