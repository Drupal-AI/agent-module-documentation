# Fastly Streamline Access — manual setup guide

**Fastly Streamline Access** (project `fsa`, module `fastly_streamline_access`)
makes it straightforward to add a user's IP address to a **Fastly ACL** when they
authenticate. It exists for the common hosting pattern — Lagoon in particular —
where a non-production environment is shielded at the CDN edge: Fastly holds an
access-control list of permitted addresses and rejects everything else before the
request ever reaches Drupal.

That protects the environment well but makes it awkward to use, because every new
location means someone hand-editing an ACL. This module closes the loop: a user who
holds the `access protected lagoon routes` permission logs in (or visits `/user`),
an event fires, and their address is added to the configured Fastly ACL through the
Fastly API — no VPN and no manual allow-list edit required.

> **Heads-up on the module name.** The Drupal project is **`fsa`** but the module's
> machine name is **`fastly_streamline_access`**. `drush en fsa` will fail — enable
> `fastly_streamline_access` instead (see Installation).

A couple of operational realities are worth knowing before you rely on it. The
Fastly API call is wrapped so that failures are caught and logged rather than
surfaced — so if access is not granted, check the logs. And nothing expires ACL
entries: membership is additive, so a stale allow-listed IP will linger unless you
plan a retention/cleanup process. The **API token is highly sensitive** and should
be stored as a secret (see the configuration guide).

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   correctly-named module.
2. [Configuration](configuration/index.md) — set the ACL names, Fastly service ID,
   and API token, and store the token safely.

## Where it lives in the admin menu

Once enabled, configure the module at **Configuration → Development → Fastly
Streamline Access** (`/admin/config/development/fastly_streamline_access`, config
route `fastly_streamline_access.config_form`). An optional admin submodule adds
manual tagging of IPs for longer TTLs.
