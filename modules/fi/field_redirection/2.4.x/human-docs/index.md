# Field Redirection — manual setup guide

**Field Redirection** (`field_redirection`) provides a **"Redirect" field
formatter** that turns an entity's page into a redirect. When the entity is
viewed, the formatter reads a URL out of one of its fields — a link field, an
entity-reference field, or a file field — and sends the browser off to that
destination with an HTTP redirect. It's the simple way to make "redirect" content
(short links, moved pages, event-to-registration forwards) without writing a
controller or reaching for a heavier redirect module.

You attach the formatter on a bundle's **Manage display** page, choose the HTTP
status code (301 permanent by default, or 302, 303, 307, and so on), and the
entity's full page will forward to wherever the field points: a link's URL, a
referenced entity's canonical page, or a file's download URL. Options let you
return a **404 when the field is empty**, and **restrict the redirect to certain
paths** (only listed paths, or everywhere except listed paths), with wildcard and
token support.

It's built to be safe: it never redirects during Drush/CLI rendering, guards
against redirect loops (it won't bounce you to the page you're already on, or to
the front page while on the front page), skips during cron and maintenance mode,
and honours a **`bypass redirection`** permission so editors and admins can
actually reach and edit the source entity instead of being forwarded away. Because
the redirect fires whenever the entity is rendered with this formatter, the
maintainers stress it should be used **only on the Full content view mode**. It
requires no modules beyond core.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

## Where it lives in the admin menu

There's no settings page. You configure it through **Field UI** on a bundle's
**Manage display** tab (for example *Structure → Content types → [type] → Manage
display*), by choosing the **Redirect** formatter for a link, reference, or file
field. Its one permission is set on **People → Permissions**.

## How to use it

**1. Have a URL-bearing field.** On the entity type you want to redirect (say a
"Redirect" content type), add or reuse a **Link**, **Entity reference**, or
**File** field that holds the destination.

**2. Apply the Redirect formatter.** Go to the bundle's **Manage display**, switch
to the **Full content** view mode, and set that field's format to **Redirect**.
(If you pick any other view mode the form warns you — a teaser in a listing would
otherwise trigger the redirect.) Then configure the formatter's settings:

- **HTTP status code** — 300, **301 Moved Permanently** (default), 302 Found, 303
  See Other, 304, 305, or 307 Temporary Redirect. Use 301 for permanent moves and
  302/307 for temporary ones.
- **404 if empty** — when ticked, if the field has no value the page returns a 404
  instead of doing nothing.
- **Page restrictions** — scope where the redirect fires: everywhere; only on a
  list of paths; or everywhere *except* a list of paths.
- **Pages** — one Drupal path per line for the restriction list. `*` is a wildcard
  (`blog/*`), `<front>` is the front page, and tokens like `node/[node:nid]` work.

**3. Let editors bypass it.** Grant trusted roles the **Bypass redirection**
permission (`bypass redirection`) so they are *not* redirected. Instead they see
the source entity with a message explaining the page would redirect and a link to
the destination — which is how they can edit a node whose Full-content view would
otherwise bounce them away:

```bash
drush role:perm:add editor 'bypass redirection'
```

With that in place, visiting a matching entity forwards to the field's URL, while
bypass-holders stay on the page. The redirect also automatically stands down for
Drush/CLI rendering, cron, maintenance mode, and would-be redirect loops.
