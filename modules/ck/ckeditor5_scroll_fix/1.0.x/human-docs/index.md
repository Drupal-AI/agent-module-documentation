# CKEditor 5 Scroll Fix — manual setup guide

**CKEditor 5 Scroll Fix** (`ckeditor5_scroll_fix`) fixes a well-known annoyance in
Drupal 10+ where the page scroll locks up or jumps unexpectedly after you focus an
image or widget inside CKEditor 5. It attaches a small, lightweight JavaScript
behaviour that watches for page scrolling while the editor has focus and quietly
simulates a "click away" to restore normal scrolling — so editing long content
stays smooth.

The best part is there's nothing to configure. The module hooks into form alters
and attaches its fix **only** to forms that use CKEditor 5 — node and entity edit
forms, block forms, and so on — so it does its job automatically the moment it's
enabled. There's no toolbar button, no settings form, no per-format setup. It's
designed as a drop-in solution for the behaviour discussed in Drupal core issues
[#3410598](https://www.drupal.org/project/drupal/issues/3410598) and
[#3401231](https://www.drupal.org/project/drupal/issues/3401231).

It depends only on Drupal core's CKEditor 5 and targets Drupal 10 (tested with
10.2+ and themes like Claro and Olivero). It defines no permissions and is not
covered by Drupal's security advisory policy.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

There is **no configuration page** and nothing to set up — the fix works
automatically once enabled.

## How to use it

Just enable the module (see [Installation](installation/index.md)). The fix applies
globally to all CKEditor 5 instances on relevant forms; no admin settings are
needed. If you build custom forms with CKEditor 5, developers can extend the
module's form-alter hook to cover those too, but that's optional.
