# Patreon — manual setup guide

**Patreon** (`patreon`) links a Drupal site to the
[Patreon](https://www.patreon.com/) API using Patreon's official PHP library. With
it, a creator can pull data about their account, their patrons, and their campaigns
into Drupal and make it available to Drupal code. On its own, the base module is an
**API client and an admin authorisation flow**: you register a Patreon OAuth
application, enter its client ID and secret, authorise the site against your
creator account, and the module fetches and stores your creator ID and campaigns.

Two optional submodules build on top of that:

- **Patreon User** (`patreon_user`) lets patrons **log in to your Drupal site with
  their Patreon account**, creating a matching Drupal account, and can assign
  Drupal roles based on their patron/pledge data — the basis for gating content by
  membership tier.
- **Patreon Extras** (`patreon_extras`) adds tokens and helper functionality on
  top, so Patreon data can be surfaced elsewhere on the site.

Because this module handles OAuth credentials and (via Patreon User) can log people
in, it has a real security posture worth understanding before you deploy it — see
the [Configuration](configuration/index.md) guide, which covers where the client
secret should live and an important caveat about the patron‑login callback.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer
   (required, because of the API library), enable it, and choose the submodules
   you need.
2. [Configuration](configuration/index.md) — register a Patreon OAuth client,
   enter and safely store the client ID/secret, authorise the site, and configure
   patron login — plus the security notes that matter.

## Where it lives in the admin menu

The base settings form is at **Configuration → Web services → Patreon → Settings**
(`/admin/config/services/patreon/settings`), gated by the **`administer patreon`**
permission. The module also exposes an admin OAuth callback at `patreon/oauth`
(also `administer patreon`); if you enable Patreon User, it adds a public patron
login callback at `/patreon_user/oauth`.
