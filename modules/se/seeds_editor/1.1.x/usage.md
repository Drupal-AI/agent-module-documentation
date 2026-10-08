<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Seeds Editor is the editor layer of the Seeds distribution: it installs ready-made text formats and their bound CKEditor 5 / ACE editors, pulls in a dozen contrib editor modules, and can load custom LTR and RTL stylesheets for the editor.

---

Assembling a good CKEditor 5 experience in Drupal is mostly integration work. You want Linkit for internal links, Entity Embed for media, `editor_advanced_link` for link attributes, a plugin pack for the toolbar buttons core leaves out, responsive tables, media resizing, Blazy for lazy images, Smart Trim for teasers, and Allowed Formats to stop editors picking the wrong one. Each is a separate module with its own configuration, and getting them to agree takes a while.

This module is that assembly, done once. Its dependency list is the honest description of what it is: seventeen modules, most of them contrib. Enabling it pulls in the whole set and, from `config/install`, creates two text formats and editors immediately — a CKEditor 5 "Simple Editor" and an ACE-source-editor "Advanced Editor" — plus, from `config/optional`, a fully-featured CKEditor 5 "Basic Editor" (media embed, Linkit, entity embed, media resize, Bootstrap-style buttons and tables) that is created only when its supporting modules are present. The formats behave like any Drupal text format: they are gated by "use the X text format" permissions and are not granted to any role on install, so only users with `administer filters` can use them until you assign them.

Beyond the shipped configuration the module itself is small. A single settings form at `/admin/config/content/seeds-editor` (permission `administer seeds editor`) toggles custom editor CSS and stores an LTR and an RTL stylesheet path. When enabled, `hook_ckeditor_css_alter()` and `hook_library_info_alter()` attach the stylesheet matching the current language direction to CKEditor and to plain textarea widgets, which is how RTL styling (via `ckeditor_bidi`) is made to look right in Arabic, Hebrew or Persian content.

That is the trade to weigh. On a Seeds site, or a new build that wants a known-good editor out of the box, it saves real time and gives every environment the same setup. On an existing site with its own text formats, it is a large and opinionated footprint that must be reconciled with what is already there — and seventeen dependencies is seventeen upgrade paths.

---

- Get a complete, pre-configured CKEditor 5 setup in a single module enable.
- Install standard "Simple Editor" and "Advanced Editor" text formats without hand-building them.
- Add a full-featured "Basic Editor" format with media, tables and buttons when its dependencies are present.
- Standardise editor configuration across dev, stage and production environments.
- Give content editors a source-code (ACE) editing format for raw HTML/markup.
- Add Linkit-powered internal linking to the editor.
- Embed media and entities in body text with Entity Embed and media_embed.
- Resize embedded media inline with ckeditor_media_resize view modes.
- Add responsive tables to authored content.
- Lazy-load editor images with the Blazy filter.
- Add rich link attributes (target, rel, class, aria-label, title) via editor_advanced_link.
- Offer Bootstrap-style button and alert styles through the CKEditor style dropdown.
- Handle right-to-left content by loading a custom RTL stylesheet automatically.
- Load a custom LTR stylesheet so the editor preview matches the front-end theme.
- Apply custom editor CSS to plain textarea widgets as well as CKEditor.
- Trim teaser text intelligently with Smart Trim.
- Restrict which text formats a field offers with Allowed Formats.
- Start a new site with a known-good editor instead of core defaults.
- Build or extend a Seeds distribution site.
- Restrict who can change the editor settings with the `administer seeds editor` permission.
- Weigh seventeen dependencies and their upgrade paths before adopting on an existing site.
