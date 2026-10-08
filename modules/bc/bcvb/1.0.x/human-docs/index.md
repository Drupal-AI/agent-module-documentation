# Bypass Core View Builder (BCVB) — manual setup guide

**Bypass Core View Builder** (`bcvb`) is a developer/display module. It lets you
skip Drupal core's standard entity view display — the field-by-field rendering
you configure under *Manage display* — for selected entities, and render them a
custom, lighter way instead. People reach for it for performance, or when they
want fully custom output that the normal view display can't produce.

The important thing to understand is what you give up by bypassing the view
builder. The core view display is not just formatting: it also applies
**field-level access checks** and the **field formatters** that sanitize output.
When you bypass it, those protections do **not** run automatically. A custom
render path therefore has to re-apply field and entity access and sanitize
values itself — otherwise it can leak restricted fields or open an XSS hole by
printing raw field values. The module has no access-control role of its own
beyond the permission it provides; the safety of the custom rendering is your
responsibility.

Because of that trade-off this is a module for developers who know exactly why
they are bypassing core, not a general display convenience. Its upstream docs are
thin (an early **1.0.0-beta1** release).

This guide is written for a **human**. If you want terse, token-cheap references
for an AI coding agent — including the security notes in condensed form — read
the sibling [`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

## Where it lives in the admin menu

BCVB provides its own permission, which you grant under **People → Permissions**
(`/admin/people/permissions`) to the roles that may control the bypass. It has no
central settings page documented; you choose which entities bypass the view
builder and supply the custom render path in code.

## How to use it

1. Enable the module and grant its permission to the appropriate role.
2. Configure which entities should bypass the core view builder.
3. Provide the custom render path for those entities — and, critically,
   **re-apply field/entity access and sanitize every value** in that path. Do
   not output raw field values unfiltered.
4. Test with a user who should *not* see restricted fields to confirm nothing
   leaks, since the core access checks are no longer doing that for you.
