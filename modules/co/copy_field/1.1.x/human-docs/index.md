# Copy field machine name — manual setup guide

**Copy field machine name** (`copy_field`) is a small developer‑experience
convenience for site builders. It adds a one‑click **copy** button that puts a
field's machine name onto your clipboard, so you can paste it straight into a
template, some code, or a config file without squinting at the screen and retyping
it by hand.

If you have ever built a custom theme or rendered content‑type data, you know the
routine: you need a field's exact machine name, so you go find it, read it
carefully, and type it out — and a single typo means a field that silently doesn't
render. This module removes that friction by letting you copy the machine name in
one click. Because it is purely a build‑time helper, many teams enable it only in
development environments (for example via Config Split).

The module works on Drupal 9, 10, and 11 and has no other module dependencies. It
does not have a central settings page; instead you switch the copy feature on
per content type, from that content type's own management screen (see "How to use
it" below).

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

There is **no central configuration page** for this module — you enable the copy
feature per content type, described below.

## Where it lives in the admin menu

The copy feature is switched on per content type from **Structure → Content types
→ *(your type)* → Edit** (for example
`/admin/structure/types/manage/article`). Once enabled there, a new **Manage Copy
field** tab appears on that content type's management screen.

## How to use it

1. Go to the content type you want the feature on, e.g. **Structure → Content
   types → Article → Edit** (`/admin/structure/types/manage/article`).
2. Enable (or disable) the copy‑field feature for that content type and save.
3. A **Manage Copy field** tab now appears on that content type
   (`/admin/structure/types/manage/article`). From there you can copy a field's
   machine name to the clipboard with a single click and paste it wherever you
   need it.

Repeat per content type — the feature is opt‑in for each one, so it only appears
where you want it.
