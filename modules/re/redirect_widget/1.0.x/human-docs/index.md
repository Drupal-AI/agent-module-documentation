# Redirect Widget — manual setup guide

**Redirect Widget** (`redirect_widget`) gives content editors a simpler way to
redirect the page they're editing. The [Redirect](https://www.drupal.org/project/redirect)
module's "redirect as an entity" approach is powerful, but the sidebar element it
puts on the node edit form can confuse content managers. Teams who liked the
straightforward redirect field from *Rabbit Hole* built this module to combine
that simpler editor experience with the power of Redirect's entities in the back
end.

It replaces the **Redirect URL** sidebar item that the Redirect module provides.
From the node edit form an editor can:

- Create a new redirect **from the page being edited** to a destination they type
  in.
- Edit that redirect later to point somewhere else.
- Have the redirect apply only to the **specific translation** being edited, when
  the node is translatable.
- **Remove** the redirect simply by clearing the field on the node edit page.

So instead of leaving the content form to manage a separate redirect entity, an
editor just fills in (or clears) one field in the sidebar.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module alongside Redirect.

The module has a small settings page but no elaborate configuration — the setup
work happens on a content type's form display, described under "How to use it".

## Where it lives in the admin menu

The widget itself appears in the **sidebar of the node edit form** for content
types you've enabled it on. A settings page lives at
`/admin/config/search/redirect/widget` (**Configuration → Search and metadata →
URL redirects → Widget**).

## How to use it

1. Enable the module (see [Installation](installation/index.md)).
2. Go to the **Manage form display** page of the content type where you want the
   redirect widget (**Structure → Content types → *(your type)* → Manage form
   display**).
3. Make sure the **URL redirects (`url_redirects`)** field is **not** disabled —
   drag it into the visible region if it sits under *Disabled*.
4. Save. The improved redirect sidebar element now appears on the node edit form
   for that content type.
5. Optionally review the settings at `/admin/config/search/redirect/widget` to
   adjust the widget's behavior.

When editing a node you can now type a destination to create a redirect from that
page, change it later, or clear the field to remove the redirect entirely.

> **Requires Redirect 1.12 or newer.** For older Redirect releases, see the
> project's issue queue for a compatible version.
