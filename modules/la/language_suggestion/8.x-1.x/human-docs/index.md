# Language Suggestion — manual setup guide

**Language Suggestion** (`language_suggestion`) helps visitors of a multilingual
site find content in their own language — without ever forcing a switch. It reads
the visitor's browser language, checks which translations your site actually has
enabled, and, if the browser language differs from the current one and a matching
translation exists, shows a friendly, non‑intrusive suggestion box offering to
switch. The visitor stays in control: nothing is redirected against their will
unless you deliberately turn on the auto‑redirect option.

Under the hood it detects language from the browser (and, experimentally, from an
HTTP header), and can optionally use a MaxMind GeoIP2 Country database. You map
which browser languages should trigger which suggestions, and you can tailor the
prompt message and timing per language. Because it only *suggests*, it has no
content or access‑control role — it is purely a multilingual UX aid.

A handful of behaviours are configurable: which page container the box attaches
to, whether to always redirect based on a previous choice, how long to wait
before showing the box, how long to keep it hidden after a dismissal, and the
browser‑language‑to‑site‑language mapping that decides when a suggestion appears
at all.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable it.
2. [Configuration](configuration/index.md) — the settings form, field by field.

## Where it lives in the admin menu

Once enabled, the settings form sits at **Configuration → Regional and language →
Language Suggestion** (`/admin/config/regional/language-suggestion`).
