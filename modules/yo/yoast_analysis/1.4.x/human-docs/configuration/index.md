# Configuration

Yoast Analysis has no settings form. Analysis is switched on for a bundle entirely by
whether a **`yoast_analysis` view mode** exists and is enabled for it — and the fields
in that view mode are exactly the content the analyzer sees.

## Enable analysis on a bundle

1. **Make the view mode available.** Go to **Structure → Display modes → View modes**
   (`/admin/structure/display-modes/view`). If a **Yoast analysis** view mode does not
   already exist for your entity type (e.g. Content), click **Add view mode**, choose
   the entity type, and create one named/keyed `yoast_analysis`.
2. **Enable it on the bundle and choose the analysed fields.** Edit the bundle's
   **Manage display** (for example **Structure → Content types → Article → Manage
   display**). Under *Custom display settings*, turn on the **Yoast analysis** display,
   then configure which fields it shows — and in what order. **Only the fields shown in
   this view mode are sent to the analyzer**, so this is where you include the real
   content (title, body, etc.) and leave out blocks or admin-only fields.
3. **Use it.** Edit or view an entity of that bundle. An **SEO Analysis** local task tab
   now appears next to *View* / *Edit* (and as an entity operation in content lists).

Repeat per bundle. A bundle without a `yoast_analysis` view mode simply has no tab —
that absence is the "off" switch.

## Who can see the SEO Analysis tab

The tab and its route are guarded by two conditions, both of which must pass:

- **Edit access** — the current user must have `update` access to the entity, so the
  tab is effectively limited to editors of that content. There is no separate
  permission to grant; it rides on your existing edit permissions.
- **The view mode must exist** for the entity's bundle (the on/off switch from above).

The analyse route is also treated as an admin route.

## What the tab shows

On the SEO Analysis tab, the module renders the entity in the `yoast_analysis` view
mode, then hands that HTML to the YoastSEO.js library in the browser. Editors get:

- A **focus keyword** field. Typing a keyword updates the keyword-based SEO
  assessments live.
- A live **SEO / readability score** (sentence length, passive voice, keyword usage,
  and so on).
- A **snippet preview** showing how the page's title, URL, and meta description will
  look in search results. The title and description come from Metatag if that module is
  installed (otherwise the entity label is used and the description is empty).

Analysis is localised to the entity's language via a built-in locale mapping, so a
multilingual site gets per-language feedback on each translation. Everything runs
client-side — no content leaves the browser.

## Which entity types get the tab

The module offers the SEO Analysis tab to **every entity type that has a canonical
URL** — nodes, taxonomy terms, users, media, and custom entities alike. To add it to a
custom entity type, make sure that type has a canonical link template, then create and
enable a `yoast_analysis` view mode for its bundles, exactly as above.
