# AB Age Gate — manual setup guide

**AB Age Gate** (`ab_age_gate`) shows visitors an **age-gate splash** — an
interstitial that asks them to confirm their age (or enter a birthdate) before
they can view the site. It is the kind of gate you see on sites for
age-restricted products; the module was originally built for that purpose. Once
a visitor confirms, the gate remembers the "confirmed" state (typically with a
cookie) so they are not asked again on every page.

It is important to understand what this module is and is not. An age gate is a
**cookie-based, client-side compliance measure — not access control**. It
satisfies a legal or UX requirement to ask "have you confirmed your age?", and
nothing more. A determined visitor can bypass it by clearing or setting the
cookie, or by requesting resources directly, so it **must not** be relied on to
protect restricted content or files. Anything that genuinely needs to be
restricted still requires real access control (permissions, private files, and
so on). In the security sense, this module has no access-control role.

With that understood, the module lets you configure the gate's appearance and
its logging, and it can export records of confirmations. It relies on Drupal's
**REST** and **Serialization** modules, and uses **CSV Serialization** and
**Views Data Export** for exporting the log.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

> **Note on this guide.** The upstream documentation for this module is sparse,
> so the steps below describe the general shape of setting it up rather than
> naming exact form fields. Confirm the precise settings screen against your
> installed version.

## Contents

1. [Installation](installation/index.md) — install with Composer, pull in the
   dependencies, and enable the module.
2. [Configuration](configuration/index.md) — the gate's appearance and logging,
   plus the crucial reminder about its security model.

## Where it lives in the admin menu

The module provides a settings area for configuring the age gate's appearance
and logging. Look for it under **Configuration** after enabling the module; the
exact path depends on your installed release.
