# Entity Reference Formatter Access Bypass — manual setup guide

**Entity Reference Formatter Access Bypass** (`entityref_formatter_access_bypass`)
adds a rendered‑entity field formatter that **deliberately renders referenced
entities the viewer is not allowed to access**. Where core's normal rendered‑entity
formatter simply hides a referenced entity when the current user lacks `view`
access to it, this formatter instead renders that inaccessible entity anyway —
using a separate, administrator‑chosen **fallback view mode**.

> ## ⚠️ Read this before you enable it
>
> This module is an **intentional access bypass**. When a user (including an
> anonymous visitor) cannot access a referenced entity, the formatter still
> builds output from that entity and shows it, using the fallback view mode you
> configure. **Any field you place in the fallback view mode will be rendered to
> people who are not permitted to see that entity.**
>
> Treat every field in the fallback view mode as **public**. Point the fallback
> at a minimal, safe view mode (for example one that shows only a title or a
> short teaser) — **never** at a full/complete view mode, which would leak the
> restricted content the access check was protecting. The safety of this module
> depends entirely on how carefully you configure that fallback view mode.

This is a deliberate footgun, not a bug. It exists for cases where you genuinely
want a stripped‑down public teaser of otherwise‑restricted content — a "log in to
view" style stub, a titles‑only listing of gated nodes, or catalog rows that
always show *something* for each reference instead of leaving a gap. Recursive
rendering is capped at depth 20.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

There is **no dedicated settings page** for this module. All configuration lives
on the entity reference field's display, described in "How to use it" below.

## Where it lives in the admin menu

This module adds no admin configuration page. You configure it on the reference
field's display under **Structure → *(entity type)* → *(bundle)* → Manage
display**, where the new formatter appears in the field's format list.

## How to use it

1. First, create or identify a **fallback view mode** that contains only fields
   that are safe to show to anyone — for example a view mode with just the title.
   Audit every field in it; whatever is there becomes visible to users who cannot
   access the entity.
2. Go to the host entity's **Manage display** and find your entity reference
   field.
3. Set its format to **Rendered entity with access bypass fallback**.
4. In the formatter settings, choose the **default view mode** (used for entities
   the viewer *can* access) and the **fallback view mode** (used for entities the
   viewer *cannot* access — this defaults to `default`, so change it to your
   safe, minimal view mode).
5. Save the display.

From then on, accessible referenced entities render in the default view mode as
usual, and inaccessible ones render in your fallback view mode — so make sure
that fallback exposes nothing sensitive.
