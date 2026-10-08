# Preview Wrapper — manual setup guide

**Preview Wrapper** (`preview_wrapper`) is a site‑builder tool that improves
Drupal's content **preview** so it looks more like the real, rendered page. When an
editor previews an entity, the preview output can be *wrapped* — placed inside the
surrounding regions and layout it will actually appear in — so the preview is a
truer representation of the published result rather than a bare, out‑of‑context
render.

It's aimed squarely at the editorial experience: it doesn't add any front‑end
feature for site visitors and it doesn't change content or access. It simply makes
the "Preview" an editor already uses more accurate. Management of the wrappers is
gated by a dedicated **Manage preview wrappers** permission.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

There is no standalone module settings URL registered, so this guide folds setup
into "How to use it" below.

## How to use it

1. Enable the module (see [Installation](installation/index.md)).
2. Grant the **Manage preview wrappers** permission (under **People →
   Permissions**) to the site‑builder role that should configure how previews are
   wrapped.
3. Configure the preview wrapper(s) so the preview renders inside the regions and
   layout you want editors to see, then use the normal **Preview** button on a
   content edit form — the preview will now appear within that wrapper, closer to
   the real page.

Because it only affects the editorial preview, there is no visitor‑facing behaviour
to test — verify it by previewing a piece of content and confirming the preview now
reflects the surrounding page layout.
