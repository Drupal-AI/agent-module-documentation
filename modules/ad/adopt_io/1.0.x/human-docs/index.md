# Adopt.io (GoAdOpt) — manual setup guide

**Adopt.io** (`adopt_io`) integrates the GoAdOpt (Adopt.io) cookie-consent banner
and consent management platform (CMP) into Drupal. Once configured, it adds
GoAdOpt's consent banner to your site so visitors are presented with a compliant
cookie notice and their consent choices are collected and managed by GoAdOpt.

It is a privacy / compliance helper. GoAdOpt is a hosted CMP, so the module loads
**GoAdOpt's third-party CMP script** — that script is what renders the banner,
manages the visitor's consent, and may itself set cookies or contact GoAdOpt.
The point of a CMP is that the visitor's consent decisions then govern whether
other tracking (analytics, advertising, marketing tags) is allowed to run, so the
important follow-up work is wiring your other tags to respect GoAdOpt's consent
signal — the banner alone does not stop other scripts unless they are integrated
with it.

The module has no content or access-control role. It supports a wide core range
(`^8 || ^9 || ^10 || ^11`).

This guide is written for a **human** setting the module up through the admin UI.
If you want terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.
2. [Configuration](configuration/index.md) — enter your GoAdOpt CMP details and
   wire your other tags to the consent signal.

## Where it lives in the admin menu

The module provides a settings form where you enter your GoAdOpt CMP details so the
banner script loads on your site.

## How to use it

Enter your GoAdOpt account / CMP identifier in the settings form and save; the
consent banner then appears on your site. Then do the essential follow-up: connect
your analytics, advertising, and other tracking tags to the CMP so they only run
when the visitor has consented — see [Configuration](configuration/index.md).
