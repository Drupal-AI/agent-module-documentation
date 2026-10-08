# Prevent Multiple Form Submissions — manual setup guide

**Prevent Multiple Form Submissions** (`pmfs`) blocks duplicate submissions of the
same form on the **server**, rather than relying on JavaScript to disable the
submit button. Double submission is one of the oldest problems on the web, and the
usual mitigation — disabling the button with JavaScript — only covers the impatient
double-click. It does nothing about a slow response and a second click with the
script not running, a resubmitted POST after a back-navigation, a flaky connection
where the request arrived but the response was lost, or a deliberate replay. The
consequences are concrete: two orders, two registrations, two payment attempts, two
identical nodes an editor then has to reconcile.

This module adds the server-side check, which is the only kind that reliably works.
For each protected form you set a **timeout** during which a second submission is
rejected, choose a **validation error message** to show when a duplicate is
detected, and optionally allow the timeout to be skipped once the initial request
has finished (so the user does not have to wait needlessly for the next
submission). It also exposes an **API** so custom controllers can use the same
configurable locking mechanism to keep a single processing operation per session.

Two things are worth understanding. First, the right primitive for "the same
submission" is a token per rendered form, which distinguishes a genuine second
submission from a resubmission of the same one. Second, this is **not a rate
limiter** — its goal is idempotency for one form render, not throttling abuse. A
form that needs protection from automated flooding still needs core's flood control
or a protection layer in front of the site.

A note on the release: version 2.0.0 was packaged in 2023 but still declares
`^10 || ^11`. It is an older release, so verify its behavior on your Drupal version
rather than assuming ongoing maintenance.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — the settings form, where you choose
   which forms to protect and how long the lock lasts.

## Where it lives in the admin menu

The settings form is at **Configuration → System → Prevent Multiple Form
Submissions** (`/admin/config/system/pmfs`).
