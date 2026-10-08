# Configuration

Section Library has very little global configuration — its real "content" is the
templates editors save. This page covers the small settings form, the six
permissions, and where to manage saved templates.

## The settings form

1. Log in as a user with the **Administer section library template entities**
   permission.
2. Go to **Configuration → Content authoring → Section library**, or navigate
   directly to `/admin/config/content/section-library`.

The form has just two fields, both of which are **label overrides**:

- **Section label** (default *Section*) — the word used for a single saved
  section.
- **Template label** (default *Template*) — the word used for a whole‑page
  capture.

These only relabel the UI (for example the "Add Section" / "Add Template" buttons
and titles) so you can match your team's vocabulary — say, "Block group" and
"Page layout". They do **not** change the underlying stored `type` values
(`section` / `template`).

## Permissions

Grant these at **People → Permissions** (`/admin/people/permissions`). Section
Library defines six:

| Permission | What it allows |
|-----------|----------------|
| **View section library templates** | See the saved‑templates listing. |
| **Add section library templates** | Save a section or page to the library. |
| **Edit section library templates** | Edit a template's label/image. |
| **Delete section library templates** | Delete templates. |
| **Import template from section library** | Use the "Choose template from library" picker and import a template into a layout. |
| **Administer section library template entities** | Full admin, including access to the settings form above; overrides the others. |

A typical split is to give a design team **add / edit / delete**, give general
editors only **view + import**, and reserve **administer** for site admins.

## Managing saved templates

Saved templates live at **Content → Section library**
(`/admin/content/section-library`) — a Views‑powered listing where you can edit
labels and preview images or delete stale entries. Each template also has a
preview at `/admin/content/section-library/{id}/preview` so you can check it
before importing.

Each saved template records its label, an optional preview image, a type of
either *section* (one captured section) or *template* (a whole page of sections),
and the serialized Layout Builder section(s) themselves. When imported, the
sections are deep‑cloned — inline blocks become new independent instances — so
edits to a copy never affect the original.
