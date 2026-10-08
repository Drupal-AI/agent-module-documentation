# Axe Core — manual setup guide

**Axe Core** (`axe_core`) brings the widely‑used
[axe‑core](https://github.com/dequelabs/axe-core) accessibility‑testing engine into
Drupal. With it enabled, developers and editors can run automated accessibility
(a11y) checks against rendered pages and see the violations reported right in the
browser. It is a development and QA aid for catching accessibility regressions
against WCAG guidelines before they reach real users.

It is a front‑end/development integration only — it has no content type, no block,
and no access‑control role of its own. Think of it as a testing tool that
complements manual accessibility audits, not a feature your visitors interact with.
It requires Drupal 10.4 or newer.

This guide is written for a **human** setting the module up. If you want terse,
token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

## How to use it

Once enabled, Axe Core runs the axe engine against the pages you view (for users
with the module's permission) and surfaces any accessibility violations in the
browser, highlighting the problem elements. Use it while building and reviewing
pages to spot issues early — missing labels, poor contrast, invalid ARIA, and the
other checks axe‑core performs — and fix them before they ship. Because it is a
development aid, you would typically use it in development/staging rather than
leaving it on for every visitor.
