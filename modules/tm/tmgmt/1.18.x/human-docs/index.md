# Translation Management Core — manual setup guide

**Translation Management Core** (`tmgmt`) — better known as **TMGMT**, the
Translation Management Tool — is a framework for translating a Drupal site in an
organised, reviewable way. Instead of editing translations one field at a time, you
collect the text you want translated into **jobs**, send each job to a translation
**provider**, and then review the returned translations side-by-side before they go
live.

The clever part is that TMGMT separates *what* gets translated from *who* translates
it. **Sources** expose translatable text — content entities, configuration, or
interface strings. **Providers** (also called translators) take that text and hand
back a translation, whether that's an automatic machine-translation API, a file you
export and send to an agency, or an in-house human translator working inside Drupal.
Because both sides are pluggable, you can mix and match: a machine translator for
rough drafts, humans for final copy.

Every request creates one job per target language, each holding job items (one per
thing being translated). Jobs move through states — unprocessed, active, finished —
and a built-in **review UI** lets editors compare source and translation segment by
segment, tweak the wording, request a revision, or accept. A message log records
every event along the way.

The base module is the framework; the real work happens in submodules you enable as
needed — sources for content, configuration and locale strings, and translators for
file export/import and local human translation. TMGMT depends on core's **Language**,
**Views**, **Block**, and **Options** modules.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent — the Translator and Source
plugin types, the Job/JobItem entity API, and the checkout hooks — read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer, enable
   it, and pick the source and translator submodules you need.
2. [Configuration](configuration/index.md) — set up a provider, request a
   translation job, and use the review UI, plus the global settings.

## Where it lives in the admin menu

Everything TMGMT does is gathered under **Translation** in the admin menu
(`/admin/tmgmt`). Key screens:

- **Providers** — `/admin/tmgmt/translators`
- **Sources** (request a translation) — `/admin/tmgmt/sources`
- **Jobs** — `/admin/tmgmt/jobs`
- **Cart** — `/admin/tmgmt/cart`
- **Settings** — `/admin/tmgmt/settings`
