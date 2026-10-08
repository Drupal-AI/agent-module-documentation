# Fixed Text Link Formatter — manual setup guide

**Fixed Text Link Formatter** (`fixed_text_link_formatter`) gives you field
formatters that render a **Link** field (or a **File** field) as a hyperlink whose
visible text is a fixed, admin-set string — "Visit our website", "Download",
"Learn more" — instead of showing the per-item title or the raw URL. It's the tidy
way to get consistent call-to-action link text across every entity of a content
type without asking editors to type a title on every link.

The module ships two formatters and nothing else — no settings page, no permissions,
no Drush. **Link with fixed text** applies to core *link* fields: it forces every
link to use your configured text, optionally adds a CSS class (handy for styling a
link as a button), and can carry the usual rel/target options. It also has an
**Allow override** option so the fixed text is used *only* when a link has no title
of its own — letting editors override it per link when they want to. **Link with a
fixed text** applies to *file* fields: it renders each file as a link to the file
using fixed text, an optional CSS class, and an "open in a new window" toggle.

You choose these formatters per field, per view mode, on an entity's *Manage
display* page, and their settings are saved with the display configuration — so they
export and deploy with the rest of your site. That means you can give the same field
different labels in different contexts (say "Read more" on a teaser and "Details" on
the full view).

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

## Where it lives in the admin menu

There is **no settings page**. You work with it entirely on a bundle's **Manage
display** page, e.g. *Structure → Content types → Article → Manage display*
(`/admin/structure/types/manage/article/display`).

## How to use it

1. Go to the bundle's **Manage display** for the view mode you want (default,
   teaser, and so on).
2. Find your **link** or **file** field's row. In the **Format** column choose:
   - **Link with fixed text** — for a *link* field.
   - **Link with a fixed text** — for a *file* field.
3. Click the gear/cog icon on that row to open the formatter settings and set:
   - **Link text** (required) — the fixed visible text, e.g. "Visit our website" or
     "Download".
   - **Link class** (optional) — a CSS class to add to the `<a>` tag, e.g.
     `btn btn-primary` to style it as a button.
   - For a **link** field: **Allow the title to be overridden** — when on, the fixed
     text is used only for links that have no per-item title; a title an editor
     entered wins. When off, the fixed text always replaces the title. (The core
     link options such as `rel="nofollow"` and open-in-new-window are also
     available.)
   - For a **file** field: **Open in a new window** — adds `target="_blank"`.
4. Click **Update**, then **Save**.

Because the settings live in the display configuration, you can configure a different
fixed label for each view mode, and the whole setup exports with your site's config.
