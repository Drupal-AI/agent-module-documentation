# Configuration

Noahs Page Builder is configured in two places: the **permission** that controls
who can use it, and a set of **admin forms** for global, style, and iframe
settings. The day-to-day work — building a page — happens in the editor itself,
covered in "How to use it" on the [overview](../index.md).

## The permission — read this first

A single permission, **Administer Noahs** (`administer noahs_page_builder`),
gates *everything*: the admin pages, the editor and preview, every builder AJAX
endpoint, the media upload, and the save action.

Grant it at **People → Permissions** (`/admin/people/permissions`), and grant it
**only to fully trusted editors**. Two things make this permission unusually
powerful:

- The builder can render **arbitrary CSS and HTML** to anonymous visitors, so
  holding this permission is effectively a full-HTML capability.
- The builder's media upload saves files keeping their original extension with
  **no MIME/extension allowlist** (SVG is explicitly accepted), so anyone with
  the permission can upload active file types.

For those reasons, do not hand this permission to loosely-trusted content roles.

## Admin pages

All of these require **Administer Noahs**:

- **`/admin/structure/noahs`** — the module's landing/admin page.
- **`/admin/structure/noahs/settings`** — global settings (the
  `NoahsSettingsForm`). This form includes an outbound HTTP check, which verifies
  TLS certificates (`CURLOPT_SSL_VERIFYPEER` is on).
- **`/admin/structure/noahs/settings_styles`** — the style editor, for global
  styling defaults.
- **`/admin/structure/noahs/settings_iframe`** — iframe settings for the live
  editor.
- **`/admin/structure/noahs_page_builder/icons`** — a browser of the icons
  available to widgets.

## Building and saving a page

You don't configure content on a form — you build it in the editor:

1. Open an entity's **Edit with Noahs** local task, or go to
   `/noahs_edit/{entity_type}/{entity}`.
2. Drag widgets from the palette and select each one to adjust its controls
   (spacing, colour, background, typography, borders, and so on).
3. Saving writes the layout to the module's own storage (the
   `noahs_page_builder_page` table) and generates the CSS. Revisions are kept
   only if the companion `noahs_page_builder_pro` module is installed.

The front end renders the saved layout and CSS automatically through the
module's response subscriber and Twig templates — that path is read-only for
visitors.
