# Button Field — manual setup guide

**Button Field** (`button_field`) adds a new field type to Drupal: a field that,
when displayed on an entity, renders a button that triggers an event when it is
clicked. It lets site builders drop an interactive button onto a content type,
media type, or other entity through the normal field UI, without writing custom
code to place the markup.

You add it like any other field: on a bundle's **Manage fields** screen you add a
field of the Button Field type, then it appears on the entity's display. It
depends only on Drupal core's Field module and works on Drupal 10.3 and 11. There
is no settings page — everything is done through the standard field forms.

An important security note: the button is only a *trigger*. Whatever action the
click ultimately performs must enforce its own access control and be protected
against forged requests (CSRF), because a button on a page can be activated by
anyone who can see it. The field itself carries no access-control role — the
security lives in the handler behind the action.

This guide is written for a **human** clicking through the admin UI. If you want
a terse, token-cheap reference for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

## Where it lives in the admin menu

Button Field adds no configuration page of its own. You work with it on each
bundle's field screens — for a content type, that is **Structure → Content types
→ [type] → Manage fields** (`/admin/structure/types`).

## How to use it

1. Install and enable the module (see [Installation](installation/index.md)).
2. Go to the **Manage fields** screen of the bundle where you want the button
   (for example a content type).
3. Add a new field and choose the **Button Field** type.
4. Save, then check the button appears on the entity's display via **Manage
   display**.
5. Make sure the action the button triggers checks access and is CSRF-protected —
   the button is only the trigger, not the guard.
