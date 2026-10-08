# Views Role Based Global Text — manual setup guide

**Views Role Based Global Text** (`views_role_based_global_text`) adds role‑based
visibility to the Views **"Global: Text area"** handler. Views already lets you
drop a free‑text block into a view's header, footer, or "no results" area; this
module lets you decide *which user roles* see that text. So you can show a
promotional banner only to anonymous visitors, hide an internal note from the
public, or give editors an instruction block that regular users never see —
without duplicating the view.

It works by extending the core text‑area handler, so every **Global: Text area**
you add anywhere gains an extra **Roles** section in its settings. There you tick
the roles that should see the text and, optionally, a **Negate** checkbox to flip
the logic. The rules are simple: if you select no roles, the text shows to
everyone (exactly like core, so existing text areas are unaffected); if you select
roles without negating, only users with one of those roles see the text; if you
select roles *and* negate, everyone except those roles sees it.

The module has no settings page, no permissions, and no config schema of its own —
the role selection is simply stored alongside the text area in the view's own
configuration. Its only dependency is core **Views**.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

## Where it lives in the admin menu

There's no dedicated page. Everything happens inside the Views UI (**Structure →
Views**), on the text‑area handler of whichever view you're editing.

## How to use it

1. Edit a view at **Structure → Views** (`/admin/structure/views`).
2. Add a **Global: Text area** to the display's **Header**, **Footer**, or **No
   results behavior** section (or open an existing one).
3. Enter your text as usual. Below the text you'll now find a **Roles** section:
   - **Select Roles** — tick the roles that should see this text. Leave everything
     unticked to show it to everyone (the default).
   - **Negate** — tick this to *invert* the selection, so the text shows to
     everyone **except** the roles you ticked.
4. Click **Apply**, then **Save** the view.

At render time the module compares the current user's roles against your selection
and either shows the text or renders nothing. You can combine several role‑scoped
text areas to build a header that reads differently for anonymous visitors,
subscribers, and administrators.
