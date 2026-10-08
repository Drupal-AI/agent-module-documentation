Varbase Media Header adds a full-width media "hero" header (background image or looping local/YouTube/Vimeo video, with the page title and breadcrumbs overlaid) that site builders can switch on per content type and per taxonomy vocabulary.

---

Varbase Media Header is a configuration/feature module from the Varbase distribution (by Vardot). It ships an admin settings form where you pick which `node` and `taxonomy_term` bundles may use a media header; enabling a bundle imports two managed fields onto it from bundled config templates — `field_page_header_style` (a `list_string` with `standard` / `media_header` options) and `field_media` (an entity reference to a `media` entity) — and groups them into a "Media Header" section on the entity add/edit form. A `varbase_media_header_block` block, placed in a region, reads the current node/term, and when its `field_page_header_style` is set to something other than `standard` renders the referenced media through a dedicated `varbase_media_header` media view mode as the header background, together with the page title and (optionally hidden) breadcrumbs. A `preprocess_block` hook blanks the theme's own page-title and breadcrumb blocks on those pages so they are not duplicated. Local videos autoplay/loop via `js/video.media-header.local.js`; remote YouTube/Vimeo videos autoplay muted and loop via provider libraries and a custom oEmbed iframe template. The module depends on `varbase_media` and `varbase_components` (the latter supplies the `media-header` Twig component the block includes). Configuration lives in the `varbase_media_header.settings` config object; a single permission, `administer varbase media header`, gates the settings form.

---

- Add a background image hero to your Basic page / Landing page content type with the page title overlaid.
- Enable a looping background video (uploaded local video) behind a page header.
- Use a YouTube video as a muted, auto-looping page-header background.
- Use a Vimeo video as a page-header background.
- Turn media headers on for one content type but leave others with the standard header.
- Turn media headers on for a taxonomy vocabulary so term pages get a hero background.
- Let editors choose per node whether a page uses the "Media Header" style or the "Standard" header.
- Let editors pick which media item is shown in a node's header via the `field_media` reference.
- Automatically hide the theme's duplicate page-title block on media-header pages.
- Automatically hide the theme's breadcrumb block on media-header pages (or keep it in the hero).
- Optionally suppress breadcrumbs entirely inside the media header via the "Hide breadcrumbs" setting.
- Place the media header block in the header/content-top region through the normal Block layout UI.
- Render the header media through a specific media view mode chosen on the block form.
- Show the media header on the node preview page (full view mode) while composing content.
- Show the media header on the latest (forward-revision) version of a moderated node.
- Present taxonomy term landing pages with a branded media hero.
- Build consistent, distribution-wide hero styling on a Varbase site without writing theme code.
- Group the page-header-style and media fields into a collapsible "Media Header" section on the edit form.
- Give content authors a simple Standard-vs-Media-Header toggle without exposing raw field configuration.
- Combine with Media Library so editors reuse existing image/video media items as header backgrounds.
- Apply media headers to translated content (the block resolves the media field in the current content language).
- Roll the feature out via the bundled install recipe, which also grants the permission to the site_admin role.
