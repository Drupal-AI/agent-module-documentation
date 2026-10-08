# ECA Simplenews — manual setup guide

**ECA Simplenews** (`eca_simplenews`) connects Drupal's no‑code
[ECA](https://www.drupal.org/project/eca) automation engine to the
[Simplenews](https://www.drupal.org/project/simplenews) newsletter module. Out of
the box, Simplenews' subscribe/unsubscribe operations aren't available to ECA
models; this module fills that gap so you can automate newsletter workflows
entirely through Event‑Condition‑Action models.

On installation it adds two actions to the ECA model editor — **Subscribe to
newsletter** and **Unsubscribe from newsletter** — plus three conditions: **User
is currently subscribed**, **User has ever subscribed**, and **Check for
self‑unsubscribes**. A typical use is an ECA model that, on user create/update,
subscribes the user to a named newsletter (for example, the `default`
newsletter), optionally gated by conditions such as the user's role.

One caveat comes straight from the maintainers: Simplenews records the newsletter
id when someone subscribes, but **not** when they unsubscribe. So the "Check for
self‑unsubscribes" condition can only tell you whether a user has previously
unsubscribed from *any* newsletter — not which one. If you rely on it, pair it
with a "Send email" (or similar) action to notify an administrator so they can
check for false positives.

Because these workflows touch **subscriber data (email addresses and other PII)**
and can trigger newsletter sends, handle that data per your privacy policy and
make sure automated subscribing respects consent and opt‑in. The module has no
access‑control role of its own. It depends on ECA and Simplenews and supports
Drupal 10.4 and 11.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it alongside ECA and Simplenews.

There is **no configuration page** for this module. It adds actions and
conditions you use inside ECA models; see "How to use it" below.

## Where it lives in the admin menu

ECA Simplenews adds no admin page of its own. You use it from the **ECA** model
editor (**Administration → Configuration → Workflow → ECA**). Newsletters
themselves are managed under the Simplenews admin pages.

## How to use it

A worked example, straight from the module's own documentation:

1. Create an ECA model with the event **Presave content entity** (Type and
   bundle: *User – any*).
2. Add the action **Subscribe to newsletter** — set the email address to
   `[user:mail]` and choose the newsletter to subscribe to (for example,
   `default`).
3. Save and enable the model. From then on, creating or updating a user
   automatically subscribes them to that newsletter.
4. Add conditions as needed — for example, "role of current user" — to control
   exactly when the subscribe happens. Because these actions send real email and
   handle subscriber PII, test carefully and respect consent before enabling on a
   live site.
