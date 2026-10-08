# Configuration

All of Custom Meta's screens live under **Configuration → Search and Metadata →
Metatag → Custom Meta Tags** (`/admin/config/search/metatag/custom-meta`), and all
of them require the **Administer custom meta tags** permission.

## The overview

The overview page is a table of every custom tag you've defined, each with **Edit**
and **Delete** operations. A fresh install ships one example tag, `sitename`, so the
table is never empty to start with. From here you add new tags, edit existing ones,
delete obsolete ones, and reach the global settings form.

## Add a custom tag

Click **Add** (`/admin/config/search/metatag/custom-meta/add`) and fill in the form.
All four fields are required:

- **Attribute** — the kind of meta tag, chosen from a dropdown:
  - **Name** → renders as `<meta name="…">` (the common case: verification tokens,
    `theme-color`, `referrer`, `rating`, and so on).
  - **Property** → renders as `<meta property="…">` (used by Open Graph / Facebook
    and similar social tags).
  - **Http Equiv** → renders as `<meta http-equiv="…">` (for example `refresh`).
- **Name** — the machine name of the tag, which is also the `name`/`property`/
  `http-equiv` value written into the markup. It must be unique among your custom
  tags.
- **Label** — the friendly name shown for this tag on the Metatag forms.
- **Description** — the help text shown under the field on the Metatag forms.

Click save. The definition is written into the `custom_meta.settings` configuration,
keyed by its machine name.

## Edit or delete a tag

- **Edit** reopens the same form pre-filled
  (`/admin/config/search/metatag/custom-meta/edit/{machine_name}`); the uniqueness
  check is skipped so you can change the label, description, or attribute.
- **Delete** shows a confirmation page
  (`/admin/config/search/metatag/custom-meta/delete/{machine_name}`) before removing
  the definition.

## Global settings — the prefix

The **settings** form (`/admin/config/search/metatag/custom-meta/settings`) has one
option: a global **prefix** that is prepended to every custom tag's rendered name.
For example, with the prefix `og:` a tag named `foo` renders as `property="og:foo"`.
Leave it empty if you don't need one.

## Important: flush caches after changing definitions

Metatag caches its tag plugin definitions, and Custom Meta turns your definitions
into those plugins behind the scenes. So **after you add, edit, or delete a tag you
must flush caches** before the change shows up on the Metatag forms and in the page
output:

```bash
drush cr
```

If a new tag doesn't appear on the Metatag settings form, a forgotten cache flush is
almost always the reason.

## Setting values on your tags

Defining a tag only creates the *field*. To give it a value, go to the normal Metatag
places: the site-wide **Metatag** defaults, a content type's Metatag defaults, or an
individual entity's Metatag field. Your custom tags appear there grouped under a
**Custom Metatags** section. Any tag you leave empty is automatically omitted from
the rendered page.

## Managing tags with Drush

You can script definitions by writing straight to the config object, then flushing
caches:

```bash
drush cset custom_meta.settings tag.og_section.attribute property -y
drush cset custom_meta.settings tag.og_section.name og_section -y
drush cset custom_meta.settings tag.og_section.label 'OG Section' -y
drush cset custom_meta.settings tag.og_section.description 'Open Graph section' -y
drush cr
```
