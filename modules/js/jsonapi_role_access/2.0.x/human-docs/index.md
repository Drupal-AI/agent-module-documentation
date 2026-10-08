# JSON:API Role Access — manual setup guide

**JSON:API Role Access** (`jsonapi_role_access`) puts a simple, site‑wide,
role‑based gate in front of Drupal core's **JSON:API**. With it enabled, whether
a request to any `jsonapi.*` route is allowed through depends on the roles the
current user holds. It's a quick way to say "only logged‑in users may use the
API" or "only this service role may reach JSON:API" without writing any custom
access code.

The gate works in one of two modes, which you pick on the settings form:

- **Allow mode** (the default) — only users who hold at least one of the roles
  you selected may use JSON:API; everyone else gets a `403`.
- **Restrict mode** — users who hold any of the selected roles are the ones
  blocked, and everyone else passes.

Out of the box the module installs in **Allow mode with the *authenticated*
role** selected, which means anonymous visitors are blocked from JSON:API and
logged‑in users are allowed — a sensible "require login for the API" default.

One thing worth understanding: this module can only **tighten** access, never
loosen it. It layers on top of core JSON:API's own entity and field access — it
can add a `403`, but it can never grant access that core would otherwise refuse.
So it's a coarse role overlay, not a replacement for correct JSON:API
permissions.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module (it requires core JSON:API).
2. [Configuration](configuration/index.md) — choose Allow vs Restrict mode and
   the roles the gate applies to.

## Where it lives in the admin menu

The settings form is at **Configuration → Web services → JSON:API → Role Access**
(`/admin/config/services/jsonapi/role_access`), behind the **Access JSON:API role
access settings** permission.

## How to use it

1. Enable the module (core JSON:API must be on).
2. Open the settings form.
3. Choose **Allow** (only selected roles pass) or **Restrict** (selected roles
   are blocked), pick the roles, and save.
