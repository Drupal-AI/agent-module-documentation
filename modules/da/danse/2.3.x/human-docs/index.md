# DANSE — manual setup guide

**DANSE** (`danse`) — **D**rupal **A**udit **N**otification **S**ubscription
**E**vent — is a framework that turns system activity into auditable events,
builds notifications from them, and lets users subscribe to exactly the events
they care about. Its name spells out its architecture: something noticeable
happens (an **Event**), users express what they care about (**Subscriptions**),
and DANSE decides who to tell (**Notifications**) — and because every configured
event is recorded, you get an **Audit** trail for free.

Most notification modules pick one source (content changes, say) and one delivery
(email) and hard‑wire the path between them. DANSE separates those concerns and
makes each pluggable, which is why it ships as a base module plus eight submodules
that supply the event sources and delivery — you enable only the ones you need
rather than turning everything on. Users manage what they follow at
`/user/{user}/subscriptions`, and administrators configure the framework at
**Configuration → System → DANSE** (`/admin/config/system/danse`).

One detail is worth noticing up front: DANSE ships with a **prune form**
(`/admin/config/system/danse/prune`). That's a signal — an event‑recording
framework accumulates rows continuously, so plan your pruning and retention before
enabling broad sources like log or config events on a busy site. This is also a
privacy point: recording who did what, and notifying about it, is exactly the data
a retention policy should cover. DANSE requires **PHP 8.1+** and Drupal 10.3 or 11;
ECA and Push Framework are optional integrations, not hard dependencies.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable the base
   module, and pick the submodules you need.
2. [Configuration](configuration/index.md) — the settings form, the prune form,
   and the per‑user subscriptions page.

## Where it lives in the admin menu

- **Framework settings:** **Configuration → System → DANSE**
  (`/admin/config/system/danse`).
- **Pruning old records:** `/admin/config/system/danse/prune`.
- **Per‑user subscriptions:** each user manages their own at
  `/user/{user}/subscriptions`.

DANSE also ships a reporting UI (Views such as `danse_events`,
`danse_notifications`, `danse_user_notifications`, and a notifications block), so
the audit log and notification lists come with it.
