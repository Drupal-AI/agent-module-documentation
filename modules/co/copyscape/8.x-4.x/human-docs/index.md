# Copyscape — manual setup guide

**Copyscape** (`copyscape`) integrates the [Copyscape](https://www.copyscape.com/)
plagiarism‑detection API into Drupal so you can check whether the content you
publish is original — that is, not partially or entirely copied from somewhere
else on the web. It is aimed at large content sites with multiple editors, where
verifying originality by hand is impractical.

Once configured, the module tests selected long‑text fields whenever a node is
added or edited: the content is submitted to Copyscape's API, which reports back
any matching pages found online. Certain users can bypass the check — user 1
always bypasses it, and you can add more roles to the bypass list.

There is one important prerequisite: **Copyscape's API is a paid service.** You
must purchase a Copyscape (Premium) subscription and obtain API credentials; they
do not expose the API to free accounts. Requests go to Copyscape's fixed API
endpoint over Drupal's HTTP client with standard TLS verification, so your API
credentials travel securely — but treat those credentials as secrets and store
them safely (see [Installation](installation/index.md) for the recommended DDEV +
Key entity pattern).

The module works on Drupal 10 and 11 and has no other module dependencies.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable it, and
   store your Copyscape API credentials securely.
2. [Configuration](configuration/index.md) — enter your account details and choose
   which content‑type fields get checked.

## Where it lives in the admin menu

Copyscape's settings live under **Configuration → Copyscape**:

- Main settings (account/API details): `/admin/config/copyscape/settings`
- Content selection (which fields to check): `/admin/config/copyscape/settings/content`
