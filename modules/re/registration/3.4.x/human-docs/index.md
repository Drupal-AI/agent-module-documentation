# Registration — manual setup guide

**Registration** (`registration`) lets people sign up for things on your site —
events, sessions, classes, appointments, or anything else you can model as an entity.
You turn a content type (or any fieldable entity bundle) into something registrable by
adding a **Registration** field to it; each sign-up is then tracked as its own
`registration` record, with capacity limits, open and close dates, per-registration
space counts, workflow states, and reminder emails.

The building blocks fit together like this. A **registration type** is a small config
entity that binds a **Workflow** (states such as pending, complete, held, canceled) to
some hold-expiration behaviour, and it can carry its own fields so you can collect
extra data per sign-up (shirt size, dietary needs, and so on). You add a **Registration
field** to a host bundle and tell it which registration type applies. Each host entity
(say, an individual event node) then gains a **Register** tab, a **Manage
registrations** admin list, and a **Registration settings** form where you set that
host's capacity, open/close window, maximum spaces per registration, reminders and
confirmation message. Every individual sign-up is a `registration` entity recording who
registered (a user, another user, or an anonymous email), how many spaces they took,
and its workflow state.

Site-wide behaviour — HTML email, when to queue notifications, filter thresholds,
settings synchronisation across languages — lives in one global settings page. A set of
host-level validation constraints enforces capacity, open/close windows and uniqueness,
and cron takes care of expiring held registrations and sending reminders.

**Nine optional submodules** extend the suite: administrative overrides, cancel-by
deadlines, host changing, confirmation emails, Inline Entity Form editing, automatic
purging, scheduled actions, wait lists, and workflow transition operations. There is
also an official companion module, **Commerce Registration**, if you want to sell
fee-based (paid) registrations.

This guide is written for a **human** setting the module up through the admin UI. If
you want terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable the module,
   and pick the submodules you need.
2. [Configuration](configuration/index.md) — create a registration type, add the
   Registration field to a host bundle, tune each host's settings, set global options,
   and understand the permissions.

## Where it lives in the admin menu

- **Global settings:** **Structure → Registration settings**
  (`/admin/structure/registration-settings`).
- **Registration types:** **Structure → Registration → Registration types**
  (`/admin/structure/registration/type`).
- **All registrations:** `/admin/registrations`.
- **Per-host controls:** each registrable entity gains **Register**, **Manage
  registrations** and **Registration settings** tabs on the entity itself
  (for example `/node/{node}/register`).
