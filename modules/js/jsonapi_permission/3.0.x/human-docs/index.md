# JSON:API Permission — manual setup guide

**JSON:API Permission** (`jsonapi_permission`) adds a single **`Access JSON:API`**
permission, so you can allow or deny the API to a whole role. Core's JSON:API has
no on/off switch of its own: it is on when the module is on, and access is decided
entirely per entity. That is correct in principle, but it leaves a gap — there is
no way to say "this role does not use the API at all." A site that exposes JSON:API
for a decoupled front end has, by default, also exposed it to every authenticated
visitor with a browser.

This module supplies the missing coarse control: one permission, checked before the
request reaches JSON:API's own handling. Understand what it is and is not — it is a
**gate in front of** the API, not a replacement for entity access. Everything
JSON:API already enforces still applies to whoever passes the gate; what the
permission adds is the ability to keep whole roles out, reducing the surface an
anonymous or ordinary authenticated user can probe.

Because it is a gate, the direction of a mistake matters. Denying it to a role that
includes your decoupled front end's service account breaks the site; granting it to
anonymous restores the pre-module behavior. Set it deliberately, and after any
change **test both** the front end and an anonymous browser. And keep the general
point in mind: JSON:API exposes your content model, so a resource enabled for the
front end is a resource enumerable by anyone who can reach it — pair this coarse
gate with per-resource and entity access controls.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable the
   module, and assign the permission.

There is **no settings form** for this module — its entire configuration is the one
permission, granted on the standard permissions page (described below).

## Where it lives in the admin menu

The module adds no settings page. Its one control, **`Access JSON:API`**, lives at
**People → Permissions** (`/admin/people/permissions`).

## How to use it

1. Go to **People → Permissions** (`/admin/people/permissions`) and find the
   **`Access JSON:API`** permission.
2. Grant it to the roles that legitimately use the API — for example your decoupled
   front end's service-account role — and leave it **unchecked** for roles that
   should not reach JSON:API at all (often including Anonymous user).
3. Save permissions, then test: confirm the front end still works with its granted
   role, and confirm an anonymous browser is now blocked from JSON:API if that was
   your intent.

Remember that entity access still governs what a role that passes the gate can
actually read or write — this permission only decides whether the request reaches
JSON:API in the first place.
