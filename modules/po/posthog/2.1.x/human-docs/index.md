# PostHog Analytics Integration — manual setup guide

**PostHog Analytics Integration** (`posthog`) connects the
[PostHog](https://posthog.com) product‑analytics and feature‑flag platform to Drupal. It can
track user behaviour both **client‑side** (via PostHog's JavaScript SDK, loaded in visitors'
browsers) and **server‑side** (via the PostHog PHP SDK, sending events from Drupal's backend),
giving you page views, custom events, e‑commerce metrics, form‑submission insight, and more.

An extensive set of optional submodules extends it into specific areas — Drupal Commerce,
Webform, consent management (COOKiES and Klaro), the ECA workflow module, server‑side events and
error tracking, and feature flags. You start with the base module's settings and switch on only
the submodules you need.

> **This is a community module, not an official PostHog product.** It's a community contribution
> (one maintainer is from the PostHog team, but PostHog does not officially support it).

> **Privacy matters here.** This module loads a third‑party analytics tracker and sends
> behavioural data to PostHog (an outbound/egress flow). Disclose the tracking in your privacy
> policy, gate client‑side tracking behind user **consent** (use the COOKiES or Klaro
> submodules), avoid capturing personal data (PII) you don't need, and store your PostHog API
> key as a **secret**.

This guide is written for a **human** clicking through the admin UI. If you want terse,
token‑cheap references for an AI coding agent, read the sibling [`agent/`](../agent/start.md)
docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer, enable it, and pick
   the submodules you need (JS, PHP, consent, Commerce, Webform, …).
2. [Configuration](configuration/index.md) — the settings form (PostHog host, API key, user
   identification, anonymous tracking) and consent, field by field.

## Where it lives in the admin menu

The base settings form is at **Configuration → Web services → PostHog settings**
(`/admin/config/services/posthog`).

## How to use it

1. Create a PostHog project (on PostHog Cloud or your self‑hosted instance) and get its
   **project API key** and **host**.
2. Enter those in the settings form and choose how users should be identified (see
   [Configuration](configuration/index.md)).
3. Enable the submodules for the tracking you want — for example **PostHog JS Tracking** for
   client‑side events, **PostHog PHP SDK** for server‑side events, **PostHog Commerce** for
   e‑commerce events, and **PostHog COOKiES** or **PostHog Klaro** to tie tracking to consent.
4. Verify events are arriving in your PostHog project's dashboard.
