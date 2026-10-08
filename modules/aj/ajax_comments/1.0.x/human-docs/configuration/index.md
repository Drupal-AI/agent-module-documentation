# Configuration

AJAX Comments has two independent layers of configuration: a small **global
settings form** with three site-wide options, and a **per-field switch** that
decides whether AJAX is used on each comment field.

## Global settings

1. Log in as a user with the **Administer site configuration** permission.
2. Go to **Configuration → Content authoring → AJAX Comments**, or navigate
   directly to `/admin/config/content/ajax_comments`.

Three options are available:

- **Notify** (on by default) — show a status message (such as "Your comment has
  been posted") after a comment is submitted via AJAX.
- **Enable scroll** (on by default) — after an AJAX action, scroll the browser to
  the affected comment so the visitor sees the result.
- **Reply autoclose** (off by default) — when a visitor opens a reply form, close
  any other reply form that is already open, so only one is active at a time.

This page also lists every entity type and bundle that has a comment field, with
a link to each one's display-settings form — a convenient jumping-off point for
the per-field switch below.

Click **Save configuration** to apply.

## The per-field enable/disable switch

Whether AJAX is actually used on a given comment field is controlled on that
field's formatter, **per view mode**, and it defaults to **enabled**. To change
it:

1. Go to **Structure → Content types → [your type] → Manage display**
   (`/admin/structure/types/manage/<type>/display`), choosing the view mode you
   want (for example *Default* or *Teaser*).
2. Find the comment field, and click its settings cog in the **Format** column.
3. Toggle **Enable Ajax Comments** on or off.
4. Click **Update**, then **Save**.

Because this is a setting on the entity view display, you can, for example, keep
AJAX on for the full view of an Article but off for the teaser — and the choice is
exported as part of your `core.entity_view_display.*` configuration. Turning it
off leaves the comments themselves intact; it only disables the AJAX behavior for
that field and view mode.

## Access

AJAX Comments adds no permissions of its own. Who can post, reply to, edit, or
delete comments is governed entirely by core's comment permissions — *Post
comments*, *Edit own comments*, *Administer comments*, and so on — so review those
under **People → Permissions** if you need to adjust who can do what.
