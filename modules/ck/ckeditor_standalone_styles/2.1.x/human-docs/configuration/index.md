# Configuration

Setting up CKEditor Standalone Styles has three parts: make sure the **Styles**
button is on your editor's toolbar, define your styles on the standalone page, and
grant the permission to whoever should manage them.

## 1. Add the Styles button to your format

1. Go to **Configuration → Content authoring → Text formats and editors**
   (`/admin/config/content/formats`) and **Configure** a format that uses
   CKEditor 5.
2. In the toolbar configuration, drag the **Styles** button from *Available
   buttons* into the *Active toolbar*.
3. Save the format.

Once this module is enabled, any styles you might set in this editor
configuration form are **ignored** — the list comes from the standalone page
instead.

## 2. Manage your styles

Go to **Configuration → Content authoring → CKEditor styles**
(`/admin/config/content/ckeditor_style`). Here you can **add, edit, delete and
drag-reorder** individual styles. Each style is a configuration entity that
defines:

- a **label** — the human-readable name that appears in the Styles dropdown,
- one **HTML element** the style applies to (for example `p`, `h2`, or `span`), and
- one or more **CSS classes** (enter one per line) added to that element when the
  style is chosen (for example a `<p>` with a `highlight` class).

When you save a style, the module automatically registers the CSS classes it uses
with the format's allowed-HTML filter, so the markup survives filtering and the
style actually applies on the rendered page — something core's built-in styles UI
does not do for you.

Because styles are config entities, a theme can also ship its own default styles;
those appear here alongside any you add.

## 3. Grant the permission

This module provides its own permission so you can delegate styles management
without handing over the full, security-sensitive editor and text-format
configuration.

1. Go to **People → Permissions** (`/admin/people/permissions`).
2. Find the CKEditor Standalone Styles permission and grant it to the role(s) that
   should curate the Styles dropdown.

This is the least-privilege payoff: a content lead can maintain the list of styles
while the powerful allowed-HTML and filter settings stay restricted to
administrators.

## Save

Save each style as you create or edit it, and save the People permissions form
after adjusting roles. Changes take effect on the next editor load (clear caches
if a new style does not appear immediately).
