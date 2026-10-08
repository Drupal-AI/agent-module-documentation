# Consent Management — manual setup guide

**Consent Management** (`consent_management`) lets you publish data policies and
record each user's consent to them — the GDPR‑style building block where a site
presents a policy document (a privacy policy, terms of use, a data‑processing
notice), asks the user to agree, and keeps a record of who agreed to which
**version** and when. When a policy changes, it can re‑prompt users so their
consent stays current. It depends on core's **Block** and **Path Alias** modules
and provides its own permissions for the admin side.

The heart of the module is the **consent record**: a stored, per‑user, versioned
statement that "this person agreed to this policy at this time." That record is the
compliance artifact — the thing you can point to if anyone asks whether consent was
obtained — so it matters that it is retained, protected, and auditable.

**Data‑handling note.** Consent records are personal data tied to identifiable
users. Retain and expose them only in line with your own privacy policy, keep them
protected, and make sure the people who can view or export them are limited to
those who need to. This module gates its own admin functions behind its permission
and otherwise layers on top of Drupal's normal access — it does not loosen anything
by itself. Note the project is **not covered by Drupal's security advisory
policy**.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module and its core dependencies.
2. [Configuration](configuration/index.md) — create data policies and set up the
   consent prompts.

## Where it lives in the admin menu

Consent Management adds admin screens for defining data policies and reviewing
consent, and provides its own permission to reach them. After enabling, check
**People → Permissions** to see the permissions it defines, and see
[Configuration](configuration/index.md) for creating your first policy.
