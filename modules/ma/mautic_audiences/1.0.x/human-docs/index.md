# Mautic Audiences — manual setup guide

**Mautic Audiences** (`mautic_audiences`) turns the **segments and tags** a visitor
has in Mautic into a first‑class Drupal primitive, so you can personalise the site
by audience without writing the wiring yourself. A single resolver service works out
which audiences the current visitor belongs to, and every audience‑aware feature on
the site can consult it.

Crucially, it does this **without hitting the Mautic API on the render path**. The
resolver reads from local stores — `user.data` for authenticated users and an
expirable key/value store keyed by the `mtc_id` cookie for anonymous visitors — and
only talks to Mautic on webhook receipt, cron reconciliation, or a manual Drush
sync. Its cache contexts key on the *resolved audience*, not on the cookie, so two
visitors in the same audience share cache entries and you avoid a per‑cookie cache
explosion.

With it in place you can build a lot with no code: **block and Layout Builder
visibility conditions** on a Mautic segment or tag; a **global Views filter** that
hides results unless the visitor's audience matches; **Twig functions**
(`is_in_segment()`, `has_tag()`, `current_audiences()`); **tokens**; and a small
**JavaScript API** backed by a private‑cached `/mautic-audiences/me` endpoint.
Editors can even **preview as an audience** by appending query parameters, and
there's an editorial debug page showing what the resolver sees. Privacy is a design
goal: boolean checks need no allowlist, but any feature that *enumerates* audiences
only ever emits allowlisted segment names, and a consent callback lets you gate the
whole resolver on the visitor's consent state (with an optional Klaro sub‑module).

One setup step matters for security: the module ships with a **webhook endpoint**,
and if you don't set a **webhook secret** the signature check is skipped, letting
anonymous requests trigger contact‑refresh work. The impact is bounded (it only
re‑fetches from Mautic — no data injection), but you should **set a webhook secret**
as part of installation. That's covered in [Configuration](configuration/index.md).

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer along with the
   Advanced Mautic Integration dependency, and enable the module.
2. [Configuration](configuration/index.md) — set the webhook secret, pick an
   identity strategy, and configure the client‑side exposure allowlist.

## Where it lives in the admin menu

The settings form is at **Configuration → Web services → Mautic Audiences**
(`/admin/config/services/mautic-audiences`). An editorial debug/status page lives at
**Reports → Mautic Audiences** (`/admin/reports/mautic-audiences`), where you can
see what the resolver sees for the current viewer, look up other users, force a
refresh, and preview Twig.
