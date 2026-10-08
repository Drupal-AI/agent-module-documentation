# Configuration

Live Blog is configured in three related places: a small **settings** area, a
**fields** page for the posts themselves, and the per‑content **Live Blog status**
toggle you set when creating content. This page walks through each.

## Open the settings

1. Log in as a user with permission to administer the site's structure.
2. Go to **Structure → Live Blog** (`/admin/structure/live-blog`).

From here you reach the three Live Blog areas:

- **Settings** — `/admin/structure/live-blog`
- **Fields** (add fields to Live Blog posts) — `/admin/structure/live-blog/fields`
- **List** (all created Live Blogs) — `/admin/structure/live-blog/list`

## Live Blog settings

The settings page controls the behavior of the live feed — for example how posts
are ordered for readers (new posts ascending or descending) and related display
options. Adjust these to match how you want the live coverage to read (most live
blogs show newest posts first), then save.

## Add fields to Live Blog posts

Live Blog posts are entities, so you can extend them with your own fields (images,
a source link, a category, and so on) at **Structure → Live Blog →
Fields** (`/admin/structure/live-blog/fields`). Add whatever fields your coverage
needs, just as you would on a content type.

## Set up the Live Blog field on a content type

The feature is switched on per piece of content through a special field type:

1. Go to a content type's **Manage fields** (or create a content type first) and
   click **Add field**.
2. Choose the field type **Live Blog type** and give it a label such as "Live Blog
   status". Save, add a description like "Enable/Disable the status of Live Blog",
   and save again.
3. On the content type's **Manage display**, hide the **Label** for this field so
   it doesn't show to readers.

## Turn a piece of content into a live blog

1. Create content of that type.
2. Tick the **Live Blog status** checkbox and save.
3. You can now add, update, and delete Live Blog posts on that content. Every
   reader with the page open sees changes appear automatically through AJAX
   polling.

## Permissions

Post creation, editing, and deletion are gated by Live Blog's per‑operation
permissions. Review them at **People → Permissions**
(`/admin/people/permissions`) and grant them only to the editorial roles that
should manage live coverage. Remember that *reading* the live feed is intentionally
open to anonymous visitors, so restrict permissions on the editing side, and keep
live‑blog content to what you're happy to serve publicly.
