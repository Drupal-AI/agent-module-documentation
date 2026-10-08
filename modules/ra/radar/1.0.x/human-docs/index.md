# Radar — manual setup guide

**Radar** (`radar`) adds a small feedback button to your Drupal site so visitors can
report issues without leaving the page. When someone clicks the radar button, a
dialog form opens where they describe the problem — and Radar automatically captures
a **screenshot** of the current screen and attaches it to the report. Developers and
support teams then get feedback with visual context, which makes reproducing and
fixing issues much easier.

In short, Radar is a lightweight, in‑page issue‑reporting tool: a user‑friendly
button, automatic screenshots, and combined reports (description plus image) that you
can review from an admin log. It is a good fit for gathering bug reports and general
feedback from site users, staging reviewers, or a support audience.

The screenshot capture relies on a **Screenshot API**, and the dialog uses
**jQuery UI**, so those pieces need to be available for the full experience (see
[Installation](installation/index.md)). The Screenshot API needs an API key, which
should be stored as a secret rather than committed — [Configuration](configuration/index.md)
covers that.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable it,
   along with the pieces it relies on for screenshots and the dialog.
2. [Configuration](configuration/index.md) — place and customise the radar button,
   set up the dialog fields, provide the Screenshot API key, and review reports.

## Where it lives in the admin menu

Radar is surfaced through **Structure → Block layout** (you place and enable the
radar button as a block) and it stores incoming reports in a log you review from the
admin area. See [Configuration](configuration/index.md) for the specifics.
