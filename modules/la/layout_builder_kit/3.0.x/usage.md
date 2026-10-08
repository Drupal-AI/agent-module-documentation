<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Layout Builder Kit adds seven ready-made block components — Rich Text, Image, Icon Text, Video, Render, Tab and Book Navigation — that editors place with core Layout Builder (or in Block Layout).

---

Core's Layout Builder gives you sections and a way to arrange blocks, but leaves you to supply the blocks. Layout Builder Kit fills that gap with seven prebuilt `@Block` plugins (ids `lbk_rich_text`, `lbk_image`, `lbk_icon_text`, `lbk_video`, `lbk_render`, `lbk_tab`, `lbk_book_navigation`; admin labels all end in "(LBK)"). It provides **no `@Layout` plugins and no section styles** — it is a component/block library, not a section framework. Every component extends the module's own `LBKBaseComponent` base class, which gives each one a shared configuration surface: a **Title**, a **Display title** checkbox, and a free-text **CSS class** field. Rich Text, Icon Text, Image and Tab embed core `text_format` (CKEditor) fields whose output is rendered through `processed_text`, so their HTML is filtered by the chosen text format. Video accepts a YouTube/Vimeo URL (or reads one from an entity field) and rewrites it to an embed URL inside an `<iframe>`. Render embeds a chosen node or media entity by a selected view mode. Tab builds an unlimited set of tabs, each holding rich text or a rendered content/plugin block. Book Navigation renders sibling/next navigation for core Book nodes. Components register their Twig templates **at runtime via the Hook Event Dispatcher `theme` event**, which is why the module depends on `hook_event_dispatcher` (4.x) — a substantial architectural dependency, not just a helper. Version **3.0.0-beta2** on core `^10 || ^11`. The Book Navigation component needs the core **Book** module; the Render component needs core **Media**. A single settings form at `/admin/config/content/layout_builder_kit/settings` (permission `access layout builder kit components`, `restrict access: true`) controls the image upload directory and allowed image extensions. Two caveats worth weighing, the same trade as the EPT paragraph family: prebuilt components are quick to adopt but **awkward to diverge from** (the markup and settings are the module's, so anything the options don't cover means overriding templates), and **components become a dependency of your content** — pages are built from them, so removing the module later leaves sections referencing blocks that no longer exist. The project is minimally maintained with no further development planned.

---

- Add a Rich Text (CKEditor) block anywhere in a Layout Builder layout.
- Place an Image block with an optional rich-text overlay.
- Add an Icon Text block (image beside text, optionally linked).
- Embed a YouTube or Vimeo video from a pasted URL.
- Pull a video URL from a node or taxonomy field into a Video block.
- Render an existing node by a chosen view mode inside a layout.
- Render a media entity by a chosen view mode inside a layout.
- Build a tabbed panel with an unlimited number of tabs.
- Put rich text directly inside a tab.
- Render an existing content or plugin block inside a tab.
- Add Book navigation (siblings + next section) to a Book node layout.
- Give editors a consistent starter set of layout components.
- Add a per-component CSS class for theme hooks.
- Optionally hide a component's title while keeping it set.
- Standardise common building blocks across a site's landing pages.
- Use the components in classic Block Layout, not only Layout Builder.
- Configure where the Image/Icon Text components upload files.
- Restrict which image extensions the upload widgets accept.
- Prototype a page structure quickly without writing block plugins.
- Pair with Layout Builder Modal for a nicer configuration dialog.
