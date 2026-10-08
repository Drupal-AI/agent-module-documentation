<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# CKEditor5 page break (ckeditor5_page_break) — agent index

Adds one CKEditor 5 toolbar button — **Page Break** — that inserts an explicit page break into
content, controlling where a printed or PDF/Word-exported document divides. The whole module is a
single Drupal CKEditor 5 plugin definition (`ckeditor5_page_break.ckeditor5.yml`) that wraps the
upstream `@ckeditor/ckeditor5-page-break` package (bundled into `js/build/page-break.js`); there is
**no PHP** — the `.module` file is an empty stub, and there are no routes, services, forms,
permissions, drush commands, plugin classes, hooks or config schema. You "operate" it entirely
through a text format: enable the module, then drag the **Page break** button onto the CKEditor 5
toolbar of a format at `/admin/config/content/formats` (there is no settings page of its own).

The inserted markup is `<div class="page-break" style="page-break-after:always;">` containing a
`<span class="page-break__label">` (styled by `css/pagebreak.css` for the editor; the print CSS in
`@media print` hides the on-screen marker). Two operational gotchas worth attaching: (1) the break
is **`page-break-after: always` print CSS** — invisible on screen, so its effect is only observable
in a print preview or export, and honouring it depends on the generator (a headless-browser PDF path
honours print CSS; some library generators ignore it — test the site's real export path). (2) The
plugin declares **`elements: false`**, so it does **not** register the `<div class="page-break">`
markup in a format's allowed HTML tags — on a format that runs "Limit allowed HTML tags", the break
is stripped silently on save unless you add the tag/attributes yourself; on Full HTML it survives.

- **Depends on:** core `ckeditor5` (`drupal:ckeditor5`).
- **Core:** `^9 || ^10 || ^11`. **Package:** `CKEditor 5`. **Version:** 1.1.1.
- **Settings page / configure route:** none (`configure` is null; configured per text format).
- **Permissions / drush / services / hooks / plugin types / config schema:** none.
- **No security surface** — pure client-side CKEditor 5 plugin, no PHP.

## Key facts (real machine names)
- **CKEditor 5 plugin id (Drupal definition):** `ckeditor5_page_break_pagebreak`
  (in `ckeditor5_page_break.ckeditor5.yml`).
- **Upstream CKEditor 5 plugin loaded:** `pageBreak.PageBreak` (re-exported from
  `js/ckeditor5_plugins/pagebreak/src/index.js`, built to `js/build/page-break.js`).
- **Toolbar item machine name:** `pagebreak` (label "Page Break"). `elements: false`.
- **Libraries:** `ckeditor5_page_break/pagebreak` (the plugin JS, depends on `core/ckeditor5`) →
  used as `library`; `ckeditor5_page_break/admin.pagebreak` (`css/pagebreak.admin.css`, toolbar
  button icon `icons/marker.svg`) → used as `admin_library`; `ckeditor5_page_break/theme`
  (`css/pagebreak.css`, the `.ck-content .page-break` styling).
- **Rendered markup:** `<div class="page-break" style="page-break-after:always;">` with a
  `<span class="page-break__label">`.
- **Configure it at:** `/admin/config/content/formats` → a CKEditor 5 format → drag **Page break**
  into the active toolbar. No module-provided config entities or schema.
