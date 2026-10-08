# Configuration

Simplifying is configured from one form. Everything you tick or list there is
saved into a single config object (`simplifying.settings`), which you can export
and move between environments like any other configuration.

## Open the settings form

1. Log in as a user with the **Access simplifying setting** permission.
2. Go to **Configuration → Development → Simplifying**, or navigate directly to
   `/admin/config/development/simplifying`.

## What you can hide

The form is organized around the different kinds of admin clutter it can remove.

### Toolbar tabs

Turn off individual tabs in the admin toolbar: **Home**, **Administration**,
**Shortcuts**, **User**, **Devel**, **Contextual**, and the administration
**Search**. Ticking a tab here hides it. Out of the box, the **Devel** tab is
hidden by default.

### Admin menu links

Provide a list of admin menu‑link **paths** to remove from the toolbar menu — for
example `admin/modules`, `admin/config`, or a cache‑flush link like
`admin/flush/views`. Each path you list is pruned from the toolbar menu.

### Entity‑form fields

Hide whole field groups on entity edit forms, grouped by entity type:

- **Nodes** — Authoring information, text format, publishing options, revision
  information, URL redirects, menu settings, URL path settings, Simple Sitemap, and
  SEO groups.
- **Users** — text format, status, notify, roles, and path.
- **Comments** — text format.
- **Taxonomy terms** — text format, relations, path, Simple Sitemap, and TVI.
- **Custom blocks** — text format and revision information.

Ticking a group hides it on the matching entity form. This is how you give content
editors a cleaner node form without writing a custom form alter for every field.
(Simplifying deliberately runs its form changes *last*, so it can even hide fields
that other modules add.)

### Local task tabs

Choose local task tabs (the tabs like *Edit*, *Manage fields*, *Results*) to prune
from pages. There's also a **show triggers** option that, when enabled, renders a
small per‑tab hide/show button so editors can toggle individual tabs from the page
via AJAX.

### Contextual links

Select contextual (pencil‑menu) links to remove — for example block or view edit
links — so editors don't see quick‑edit links you'd rather they didn't use.

### Toolbar design

The form also exposes a few look‑and‑feel options for the toolbar: a small‑button
toggle and color settings for the top background, top text color, and submenu
background (the defaults are a green/yellow/light‑grey scheme). These keep the
simplified toolbar themable without custom CSS.

### Basket integration (optional)

If the contrib `basket` e‑commerce module is present, an extra section lets you
reorder or prune its admin settings menu links.

## The "full administration" escape hatch

Because hiding is only a convenience, editors are never truly locked out. When a
browser cookie named `simplifying` is present, all the hiding above is skipped and
the complete admin UI reappears in that browser. The module ships a one‑click
toggle (built on the JS Cookie library) so a user can flip into this **full
administration** mode temporarily and back again. Note this is a per‑browser
convenience, not a server‑side permission — it does not grant any access the user
didn't already have.

## Save

Click **Save configuration**. Your choices take effect across the site
immediately. Since everything lives in `simplifying.settings`, you can also read
and write it with `drush config:get simplifying.settings` /
`drush config:set` and export it into your configuration sync directory to deploy
the same simplified UI elsewhere.
