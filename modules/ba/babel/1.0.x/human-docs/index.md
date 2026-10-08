# Babel — manual setup guide

**Babel** (`babel`) helps you translate the Drupal **user interface** — the built‑in
and module‑provided text that makes up the admin and site chrome (button labels, field
descriptions, messages, and so on). It gives translators a more efficient way to work
through these interface strings than core's stock *Translate interface* screen, which
matters on multilingual sites with a lot of UI text to localise.

It builds on core's **Locale** module (Drupal's interface‑translation system) rather
than replacing it, so your translations live in the same place core stores them. It
defines its own permission for managing translations and runs on Drupal 10.4+, 11.1+
and 12.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

> **Note on depth:** this is an early‑stage module (1.0.0‑alpha11) and its upstream
> documentation is thin. This guide describes what it does and how to reach it; the
> exact on‑screen layout of its translation tools may differ from what is described
> here.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable it
   alongside Locale.

## How to use it

Babel is a translator's tool, so the workflow is: make sure your site has more than one
language and Locale enabled, then use Babel's interface to work through the untranslated
UI strings for your target language. Because it builds on Locale, the translations you
make are stored as core interface translations and take effect across the site the same
way any interface translation does. Managing translations through Babel is gated by its
own permission, so grant that to the users who do translation work.
