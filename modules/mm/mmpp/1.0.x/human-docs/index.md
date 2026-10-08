# Make My Profile Private (MMPP) — manual setup guide

**Make My Profile Private** (`mmpp`) gives each user a simple choice: keep their
profile public or make it private. When a user marks their profile private,
visitors to that user's `/user/{user}` page get an access-denied response instead
of the profile. The toggle lives on the user add/edit form, and — importantly — the
default is **private**: a profile is private unless the user has ticked the option
to make it public.

What makes MMPP trustworthy is *how* it enforces this. Rather than merely hiding
fields on the profile display, it adds a "private" base field and registers a
proper **entity access handler** that governs view access to the user entity
itself. Because enforcement happens at the entity-access layer, it is respected
everywhere Drupal checks entity access — the canonical profile page, but also
**JSON:API, REST and Views** — so a private profile's data does not leak through the
API, which is a common failure this module deliberately avoids.

One thing to understand: MMPP does not *override* the core **View user
information** permission. A public profile is only visible to roles that already
hold that permission — MMPP simply lets an individual user hide their profile even
from those roles. It depends only on core's **User** module and has no settings
screen of its own.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

There is **no configuration page** — MMPP works as soon as it is enabled. The only
control is the per-user public/private toggle on the user form.

## How to use it

1. Enable the module (see [Installation](installation/index.md)).
2. Make sure the roles that should be able to see *public* profiles hold the core
   **View user information** permission (**People → Permissions**) — MMPP does not
   grant this for you.
3. Each user can now open their own **Edit** form (`/user/{user}/edit`) and tick
   the option to make their profile public. Left unticked, the profile stays
   private (the default) and other users get access-denied on that profile page.
