# Moderation State Form Knockout — manual setup guide

**Moderation State Form Knockout** (`moderation_state_form_knockout`) shows the
Content Moderation state widget on node add/edit forms but **disables interaction
with it**. Editors can *see* the current moderation state right on the edit form,
but they cannot change it there — the widget is styled as disabled and its
non-draft options are removed. This suits sites where "edit the content" and
"change the workflow state" are meant to be two separate actions on two different
paths (for example, moving state from the "Latest version" moderation controls
instead of the edit form).

The module solves a subtle problem. Simply removing the moderation widget from
the form turned out to be inadequate, because saving an edit to a published node
would keep it published; and setting the field to disabled via other means either
hid the next state or caused Drupal to reject the submission as an invalid
transition. This module's form alter threads that needle: it keeps the widget
visible and read-only while still submitting a valid value.

It depends on core Content Moderation and assumes a **`draft`** workflow state
exists. It works on Drupal 10 and 11 and requires **no configuration** — once
enabled, it disables interaction with the moderation state widget on node
add/edit forms for all content types.

> **Important — this is a UI measure, not access control.** Disabling the widget
> only removes the inline control; it does **not** enforce which state
> transitions a user may perform. The authority over transitions is (and must
> remain) Content Moderation's own transition permissions. Treat this module as
> presentation, not as a security boundary — a user with permission to transition
> content can still do so through other means (such as the moderation controls on
> the latest-version display).

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

There is **no configuration page** for this module, and no settings — it works
automatically once enabled.

## Where it lives in the admin menu

Moderation State Form Knockout adds no admin page and no settings. Its effect is
visible on **node add/edit forms**, where the moderation state widget now appears
disabled.

## How to use it

1. Confirm your site uses core **Content Moderation** with a workflow (including a
   `draft` state) applied to your content types.
2. Enable the module (see [Installation](installation/index.md)).
3. Open any node's add or edit form — the **moderation state** widget is now
   shown but disabled, so editors can read the state without changing it inline.
4. Continue to manage actual state transitions through Content Moderation's
   normal controls (for example the "Latest version" tab), governed by the usual
   transition permissions.
