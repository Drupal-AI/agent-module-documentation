# Configuration

Single Content Sync works out of the box for the common content types, but a
settings form lets you control **which entity types and bundles** can be exported,
a couple of **safety and file** options, and how **embedded references** are
handled. This page covers that form, the export/import UIs, bulk export, and the
module's permissions.

## The settings form

1. Log in as a user with the **Administer single content sync** permission.
2. Go to **Configuration → Content → Single Content Sync**, or navigate directly
   to `/admin/config/content/single-content-sync`.

The settings, with their defaults:

- **Allowed entity types** *(default: node, media, taxonomy term, block content,
  menu link content — all bundles)* — choose which entity types (and optionally
  which bundles) may be exported. Only the listed types get an **Export** tab and
  can be exported. Leaving a type's bundle list empty means "all bundles."
- **Site UUID check** *(on by default)* — when on, the importer refuses to import
  content whose source site UUID differs from this site's, guarding against
  importing content from an unrelated site. Turn it off to allow imports between
  arbitrary sites.
- **Embedded entities export mode** *(default: stub)* — how entities embedded in
  formatted‑text or link fields are exported: **none**, **stub** (base fields
  only, matched by UUID on import), or **full** (the whole entity).
- **Menu link export mode** *(default: stub)* — the same choices for a content
  item's menu link.
- **Import directory schema** *(default: temporary)* — the stream wrapper used for
  the working directory during import.
- **Export directory schema** *(default: temporary)* — the stream wrapper used for
  the working directory during export.

Saving the form flushes all caches, since changing the allowed types affects the
per‑entity operation forms. You can also set these values with Drush, e.g.:

```bash
drush cset single_content_sync.settings site_uuid_check 0
drush cset single_content_sync.settings embedded_entities_export_mode full
```

All settings live in the `single_content_sync.settings` config object and export
with `drush config:export`.

## The per‑entity Export tab

Every allowed entity gets an **Export** tab (for example `/node/{id}/export`). It
shows the entity serialized as YAML in an editable preview, an **Include all
translations?** checkbox (which refreshes the preview), and two buttons:

- **Download as a file** — streams a `.yml` (YAML only, no assets).
- **Download as a zip with all assets** — streams a `.zip` bundling the referenced
  files and images.

## The Import page

At **Content → Import** (`/admin/content/import`) you paste YAML or upload a
`.yml`/`.zip`, then submit to recreate the content and everything it references on
the current site.

## Bulk export

A bulk export form at `/admin/config/content/single-content-sync/export` lets you
export many entities at once, and a Views‑Bulk‑Operations‑style **Content bulk
export** action (with asset and translation options) is available on entity
listing pages.

## Permissions

Single Content Sync defines these permissions:

- **Import single content** — access to the Import page.
- **Administer single content sync** — access to the settings form.
- **Export *(type)* content** — a per‑entity‑type export permission generated for
  each exportable type, e.g. *Export node content*, *Export media content*,
  *Export taxonomy_term content*. Grant these to let editors export specific kinds
  of content. (Standard entity access is also checked on each Export form.)
