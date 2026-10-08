# PingMe — manual setup guide

**PingMe** (`pingme`) is a **learning / example module** for developers who are
new to Drupal module development. It isn't a feature you install to run a
production site — it's a small, self‑contained sample that demonstrates a set of
common Drupal patterns in one place: defining a custom database schema, doing
insert/update/delete (CRUD) with AJAX, showing records in a paged list, viewing a
single record, opening an AJAX modal popup, and (optionally) sending mail.

When installed, it creates a `pingme` database table and exposes a simple
message workflow: a form to pick a user (via autocomplete) and store a message,
a paged table of stored records with view/edit/delete links, a single‑record
modal view, and a confirm‑form delete. All of it lives under **`/ping-me/records`**,
where you can try each operation. The mail feature is present but commented out in
the code; a developer can uncomment it and rebuild the cache to enable it.

**Important — do not run this on a public or production site as‑is.** PingMe is
deliberately written for tutorial convenience, not for a real access model.
Several of its routes are open to anonymous visitors (they can create, edit, and
delete rows in the `pingme` table), and its list/view routes are gated only by the
"access content" permission, which anonymous users have on a default site — so
they can read stored recipient email addresses and enumerate user accounts. Treat
it strictly as **sample code to study and copy from** (with your own permission
checks added), not as something to deploy.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module (on a development site only).

There is **no configuration page** — the module has no settings form. You explore
it through its pages, described under "How to use it" below.

## Where it lives in the admin menu

PingMe adds no admin settings page. Everything happens at the front‑end path
**`/ping-me/records`**, which lists the stored records with links to view, add,
edit, and delete them.

## How to use it

1. On a **local / development site only**, enable the module (see
   [Installation](installation/index.md)). On enable it creates the `pingme`
   table.
2. Visit **`/ping-me/records`** to see the paged record list.
3. Use the form to pick a user via autocomplete and store a message, then try the
   view (modal popup), edit, and delete actions to see each pattern in action.
4. To study the mail pattern, a developer can uncomment the mail code in the
   ChatForm and rebuild the cache.

Because this is reference code, the most valuable use is reading the source
(schema definition, AJAX modal controller, autocomplete controller, and the CRUD
forms) and adapting the patterns into your own module — while adding the
permission checks and ownership validation the example intentionally leaves out.
