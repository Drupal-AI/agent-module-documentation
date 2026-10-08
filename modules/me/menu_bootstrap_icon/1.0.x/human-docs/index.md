# Menu Bootstrap Icon — manual setup guide

**Menu Bootstrap Icon** (`menu_bootstrap_icon`) brings the full **Bootstrap 5**
icon set (around 2,000 icons) to your site and lets you use those icons in four
different places: on **menu links**, in **Link fields** (via a widget and
formatter), on **File fields** (an automatic file-type icon plus optional online
document viewers), and inside **CKEditor 5** (a toolbar plugin for inserting icons
into body text). A searchable popover icon picker is provided everywhere you add
an icon.

It's the module to reach for when you want an icon-driven navigation menu that
matches a Bootstrap 5 theme, recognizable per-format glyphs on downloadable
document lists, or consistent iconography across menus, links, and rich text.

A small settings page controls whether the Bootstrap assets load from a CDN and
lets you regenerate the icon picker's search index (for example after you add your
own custom icons). One important thing to remember: the icon assets are attached
automatically on admin forms and field displays, but **not** on your rendered
front-end menus — you add a one-line library reference to your theme to enable
those (see below).

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

## Where it lives in the admin menu

The settings page is at **Configuration → User interface → Bootstrap icons
update** (`/admin/config/content/menu_bootstrap_icon`, requires **Administer site
configuration**). The icon features themselves appear on the screens where you
already work — the menu link edit form, field widget/formatter settings on Manage
form display / Manage display, and the CKEditor 5 toolbar.

## How to use it

### Enable icons on front-end menus (do this first)

Because the icon CSS/JS is not auto-attached to rendered menus, add the library to
your theme's `.info.yml` so menu icons actually show on the front end:

```yaml
libraries:
  - menu_bootstrap_icon/cdn
```

(If your admin theme is already Bootstrap 5-based and provides the icon font, you
may not need the CDN — see the settings page below.)

### Menu link icons

Edit any menu link (**Structure → Menus → (a menu) → Edit** a link). A **Bootstrap
Icon** section appears with:

- **Icon class** — the Bootstrap icon (e.g. `bi bi-house`), chosen with the
  searchable picker.
- **HTML tag** — render the icon in an `<i>` or `<span>`.
- **Appearance** — show the icon **before** the text, **after** it, or **only** the
  icon (with an accessible label for screen readers).
- **Menu Item Roles** — optionally restrict which roles *see* this menu link. Note
  this is display-only menu visibility, not access control — the destination page
  still enforces its own permissions.

### Link fields

- Set a field's widget to **Bootstrap icon link** (on *Manage form display*) so
  editors can attach an icon to each link value, with an optional per-field default
  icon.
- Set the field's formatter to **Bootstrap icon link** (on *Manage display*) to
  render the icon before, after, or instead of the link text.

### File fields

Set a File field's formatter to **File Bootstrap icon** (on *Manage display*). It
automatically maps each file's extension/MIME type to a Bootstrap file-type glyph.
Its settings let you:

- Choose a fallback icon and whether the icon shows before, after, or only.
- Open documents in a **modal dialog** or a **new tab** instead of downloading.
- Preview office/PDF documents through the **Google Docs** or **Microsoft Office**
  online viewer.

### CKEditor 5

On a text format that uses CKEditor 5 (**Configuration → Content authoring → Text
formats and editors**), drag the **Bootstrap Icons** button into the toolbar.
Editors can then search and insert inline `<i class="bi …">` icons into body text.

### The settings page

At **Configuration → User interface → Bootstrap icons update**
(`/admin/config/content/menu_bootstrap_icon`):

- **Use CDN** — when ticked, the Bootstrap 5 assets load from a CDN wherever icons
  are shown. Untick it if your (Bootstrap 5) admin theme already provides those
  assets. (Default: on.)
- **Icon define** — a YAML editor holding the picker's search index.
- **Generate** — scans the module's `icons/*.md` definition files and rebuilds the
  search index. Click this after adding your own custom icon definition files.

> **Note:** regenerating the search index writes to a file inside the module
> directory, so that directory must be writable for the Generate step to persist.
