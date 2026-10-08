# IDNA Convert — manual setup guide

**IDNA Convert** (`idna`) is a small developer utility that provides an **IDNA /
Punycode conversion service**. Internationalized domain names — those containing
non‑ASCII characters, such as `münchen.example` — are represented in ASCII as
*Punycode* for DNS. Converting between the two forms is what you need when
validating or displaying such domains, and this module wraps that conversion in a
tidy Drupal service so other code can depend on it cleanly.

It exposes an `idna` service with `encode()` and `decode()` methods, plus a small
demo page at `/idna` where you can try a conversion by hand. It's a primitive for
developers to build on rather than a feature you configure — there is no settings
form and nothing to set up beyond enabling it.

One thing to keep in mind: IDN handling is relevant to **phishing**, because
lookalike Unicode domains (homograph attacks) can impersonate a real domain. This
module gives you the conversion primitive; it is not itself a phishing defense, so
any code that validates or displays domains should stay aware of that.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

This module has **no configuration page** — it provides a service and a demo
page, described below.

## Where it lives in the admin menu

IDNA Convert adds no admin settings page. It provides:

- A **service** (`idna`) for developers, used in code as
  `\Drupal::service('idna')->encode($input)` and
  `\Drupal::service('idna')->decode($input)`.
- A **demo page** at `/idna` where you can test conversions in the browser.

## How to use it

- To convert a Unicode domain to Punycode in code, call
  `\Drupal::service('idna')->encode($input)`; to convert Punycode back to
  Unicode, call `\Drupal::service('idna')->decode($input)`. (Injecting the
  `idna` service is preferable to the static call in real code.)
- To try it interactively, visit `/idna` and enter a value.
