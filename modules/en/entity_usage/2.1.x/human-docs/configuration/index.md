# Configuration — choosing what to track

The **Settings** page is where you decide *which* relationships Entity Usage
records and *where* editors get to see them. It is worth spending a few minutes
here before you rebuild the usage table, because these choices control both the
usefulness of the reports and the size of the tracking data.

The single most important idea on this page is the split between **source** and
**target** entity types:

- A **source** is an entity that *does the referencing* — for example a node
  whose body embeds a media item, or an article that links to a landing page.
  Entity Usage watches source entities as they are saved and scans them for
  references.
- A **target** is an entity that *is referenced* — the media item, file, or term
  that a source points at. Entity Usage records a usage row for each target it
  finds.

So "track nodes as sources" means *look inside nodes for references*, while
"track media as targets" means *record when something references a media item*.
You usually want your content types as sources and the reusable things you care
about (media, files, terms) as targets.

## Open the Settings page

1. Go to **Configuration → Content authoring → Entity Usage Settings**
   (`/admin/config/entity-usage/settings`).
2. You land on the **Settings** tab. The **Batch Update** tab next to it is for
   rebuilding the table afterwards (see [Installation](../installation/index.md)).

![The Entity Usage Settings page](../images/settings.png)

The form is organised into collapsible sections. Work through them from top to
bottom.

## Enabled local tasks — where the "Usage" tab appears

The **Enabled local tasks** section (shown open in the screenshot above) controls
which entity types get a **Usage** tab (a *local task*) on their canonical page.
As the help text says: *"Check in which entity types there should be a tab (local
task) linking to the usage page."*

1. Under **Local task entity types**, tick each entity type whose editors should
   be able to click a **Usage** tab and see what references that entity — for
   example **Content** (nodes) and **Media**.
2. Leave the rest unchecked. By default no types are selected here, so the tab
   is opt-in.

Once enabled, an editor viewing (say) a media item sees a **Usage** tab
alongside View/Edit/Delete that lists every source entity referencing it.

## Tracked source entity types

Choose which entity types Entity Usage inspects for references when they are
saved. Tick the content types you author — most sites want **Content** (nodes),
and often **Media**, **Paragraphs**, or custom blocks. By default all content
entity types except *File* and *User* are treated as sources. Un-ticking a type
you never reference *from* keeps the module from scanning it needlessly.

## Tracked target entity types

Choose which entity types are recorded when something references them. This is
what keeps the usage table focused: if you only ever ask "where is this media /
file / term used?", enable just those target types and the table stays small.
Anything not enabled as a target is simply not recorded, even if a source points
at it.

## Enabled tracking methods (plugins)

Entity Usage detects each *kind* of reference with a separate tracking method
(plugin). This section lists the methods available on your site — tick the ones
relevant to how your content links things together, and un-tick any you do not
use to save processing when the table is rebuilt. The methods that ship with the
module cover:

- **Entity reference** — standard entity_reference fields (the usual "Media",
  "Related content", "Author" fields).
- **Link** — core link fields that point at an entity's URL.
- **HTML link** — plain `<a href>` links to entity URLs written inside text
  (body / formatted-text fields).
- **Entity embed**, **LinkIt**, and **Media embed** — entities embedded inside
  CKEditor text via those tools and core's media embed button.
- **Layout Builder** — references made by inline (non-reusable) blocks placed
  with Layout Builder.
- **Block field**, **Dynamic entity reference**, and **Entity reference
  revisions** — references made through those contrib field types (the last one
  covers Paragraphs).

New methods appear here automatically if another module (or your own custom
plugin) provides one. There is also an option governing whether references made
through **base fields** (built-in fields, not just the configurable fields you
add) are tracked; enable it if you rely on core reference base fields.

## Save

Click **Save configuration** at the bottom. Your changes take effect for content
saved from that point on.

## Rebuild the table so existing content reflects your choices

Because Entity Usage only records references as entities are saved, changing any
of the settings above does **not** retroactively update already-saved content.
After you save the settings, rebuild the usage table so the reports match your
new configuration:

- Open the **Batch Update** tab (`/admin/config/entity-usage/batch-update`) and
  run it to erase and regenerate all tracking records, or
- Run `drush entity-usage:recreate` (preferred on large sites).

See [Installation → Back-fill usage for existing content](../installation/index.md)
for details.

## Viewing usage — the per-entity "Usage" tab

Once tracking is configured and the table is populated, editors use the results
in two places:

- The **Usage** tab you enabled above, shown on an entity's canonical page,
  lists every source that references that entity — so before deleting a media
  item or editing a reusable block, you can see exactly what depends on it.
- The usage report under **Content** collects the same information site-wide.

Seeing these reports requires the **access entity usage statistics** permission,
so grant it to your content-editor roles under **People → Permissions**.
