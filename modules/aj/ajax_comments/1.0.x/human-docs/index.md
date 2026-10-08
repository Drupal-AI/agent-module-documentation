# AJAX Comments — manual setup guide

**AJAX Comments** (`ajax_comments`) makes posting, replying to, editing, and
deleting comments happen inline via AJAX, so the page never fully reloads when a
visitor interacts with a comment thread. Instead of a full page refresh after
every action, only the affected part of the comment thread updates in place —
replies appear where they belong, inline edit forms open and close, and deletions
happen through a modal confirmation dialog. The result is a much smoother
commenting experience on busy blogs and discussion-heavy pages, with no custom
JavaScript required.

Enablement works at two levels. AJAX behavior is switched on or off **per comment
field, per view mode** — it is a setting on the comment field's formatter on the
*Manage display* screen, and it defaults to **enabled** on every comment field.
So AJAX commenting is generally on out of the box, and you turn it off on
particular fields or view modes if you don't want it there. Separately, a global
settings form offers three site-wide options that shape the AJAX behavior.

The module depends only on core's **Comment** module and works on Drupal 10.2+
and 11. It defines **no permissions of its own** — access to commenting is still
governed entirely by core comment permissions (*Post comments*, *Edit own
comments*, *Administer comments*, and so on).

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable it.
2. [Configuration](configuration/index.md) — the global settings, plus the
   per-field enable/disable switch.

## Where it lives in the admin menu

The global settings form sits at **Configuration → Content authoring → AJAX
Comments** (`/admin/config/content/ajax_comments`). The per-field switch lives on
each comment field's format settings under **Structure → Content types → [your
type] → Manage display**.

## How to use it

Enable the module and AJAX commenting is immediately active on your comment
fields. Adjust the three global options if you like, and toggle AJAX off on any
comment field or view mode where you don't want it. See
[Configuration](configuration/index.md).
