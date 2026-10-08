# Flag Anonymous — manual setup guide

**Flag Anonymous** (`flag_anon`) turns a Flag that anonymous visitors *can't* use
into a sign-up prompt. Normally, when a guest doesn't have permission to use a
flag (bookmark, like, favorite, follow, wishlist…), Drupal just hides the flag
link — the visitor sees nothing. This module replaces that empty space with a
configurable call-to-action such as *"Login or Register to use this flag,"* where
"Login" and "Register" are links to the sign-in and registration forms. It's a
neat way to convert would-be flaggers into registered users.

The experience is smooth: you can keep the original flag label and only pop the
message up when a guest clicks it, or replace the label with the message outright;
you can open the login/registration forms in a modal dialog so the visitor never
leaves the page; and — the nice touch — after the visitor authenticates, the flag
they originally clicked is applied **automatically**, and they land back on the
page they came from. Every message and link label is per-flag and translatable, so
"Sign in to bookmark this" and "Join to follow" can differ across flags.

It's an add-on for the contrib **Flag** module and configured **per flag**, right
in the flag's own edit form — there's no separate settings page (`configure:
null`). One important precondition: the CTA only appears for anonymous users who
*lack* permission to use that flag, so you must remove the anonymous role's
flag/unflag permission for it (covered in [Configuration](configuration/index.md)).
This guide is written for a **human** clicking through the admin UI; if you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead. The module depends on the **Flag**
module, has no submodules, and adds no third-party libraries.

## Contents

1. [Installation](installation/index.md) — install with Composer (it needs the
   Flag module) and enable it.
2. [Configuration](configuration/index.md) — the per-flag "Anonymous settings"
   section, field by field, plus the required permission step.

## Where it lives in the admin menu

Flag Anonymous has no page of its own. It adds an **Anonymous settings** section to
each flag's edit form under **Structure → Flags**
(`/admin/structure/flags/manage/<flag>`). You'll also visit **People →
Permissions** to remove the anonymous role's permission on the flag so the CTA
actually shows.

## How to use it

In short: enable the module, edit the flag you want to gate, turn on the
**Anonymous settings**, write your message, and remove the anonymous role's
permission for that flag. The full walkthrough is in
[Configuration](configuration/index.md).
