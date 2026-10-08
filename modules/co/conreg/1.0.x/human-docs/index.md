# ConReg (Convention Registration) — manual setup guide

**ConReg** (`conreg`) is a convention registration system — a sign‑up form and
management back end for registering members of an event, originally built for
science‑fiction conventions. It handles the things convention membership expects:
registering people (including **multiple members together** in one go), offering
different **membership types**, collecting customisable membership **preferences**,
and taking **add‑on payments** for extra charges or optional items. It provides its
own permissions for the management side.

It is worth being honest about the project's maturity: ConReg is an early
release (currently `1.0.0-beta2`) that is being migrated from its original GitHub
home to Drupal.org and modernised over time. Installing now auto‑creates a default
open event for you, and events are managed from an admin UI
(**Configuration → ConReg → Events**). Payments require **Stripe** keys and the
Stripe PHP library. It requires Drupal **11.2+** (or 12) and depends on three
contrib modules — **Key**, **Token** and **Easy Email** — plus the
`stripe/stripe-php` library, all pulled in by Composer. Note the project is **not
covered by Drupal's security advisory policy**.

**Data‑handling note.** ConReg collects **attendee personal data**, and — once you
enable payments — is a financial flow. Expose registration data only to the
organisers who need it, secure the Stripe integration and keys, and handle the
personal data you collect in line with your privacy policy.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, add the Stripe
   library, and enable the module.
2. [Configuration](configuration/index.md) — the post‑install setup: the event
   record, Stripe keys, membership types and preferences.

## Where it lives in the admin menu

ConReg provides its own registration and management screens and its own
permissions. Because the project is early and its routes are still being
modernised, use **People → Permissions** to confirm which roles can manage
registrations, and see [Configuration](configuration/index.md) for the current
setup steps (some of which still involve settings and the database directly).
