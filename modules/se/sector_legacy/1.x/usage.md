Sector Legacy is a backward-compatibility metapackage for the Sector Drupal distribution, bundling three optional submodules and pinning the contrib modules that older Sector sites still rely on.

---

Sector Legacy (`sector_legacy`) is a wrapper/metapackage published by Sparks Interactive to keep older **Sector** (sector.org.nz) distribution sites running as the distribution moves forward. The top-level module itself contains no PHP, routes, services, or config — its job is twofold: its `composer.json` `require` block pins the contrib dependencies that legacy Sector builds depend on (antibot, autologout, components, current_page_crumb, ds, field_delimiter, inline_entity_form, radix, view_unpublished, webform, xmlsitemap), and it ships three self-contained submodules (`admin_ui_toggle`, `sector_blocks`, `sector_utils`) that provide the blocks and editor-UX tweaks that used to live in the core distribution. The `.info.yml` description explicitly notes the parent "does not need to be enabled"; you install the project for its Composer constraints and enable only the submodule(s) you want. It targets Drupal 10 and 11 and is incompatible with Drupal 9.

---

- Composer-require `drupal/sector_legacy` to pull in the pinned set of contrib modules an older Sector site expects, without hand-maintaining those version constraints.
- Keep a Sector 9-era site supported after upgrading to Drupal 10/11 without re-implementing the distribution's legacy features.
- Bridge the gap between Sector 9 and Sector 10 for features newer Sector builds no longer bundle.
- Enable `sector_blocks` to get the distribution's custom theme blocks (responsive menu controls, Search API search boxes, desktop search fly-out, release-notes banner).
- Enable `admin_ui_toggle` to place a block that lets editors hide/show the admin chrome on the front end while previewing.
- Enable `sector_utils` for editor-experience improvements on node and media forms under the Claro admin theme.
- Standardise the "Publishing status" checkbox label to "Published" across content types via `sector_utils`.
- Move the node publishing status and form action buttons into the meta sidebar group on Claro via `sector_utils`.
- Show media editors, on the media delete form, whether the item is still referenced (integrates with the optional `entity_usage` module).
- Render nicer human-readable file sizes and MIME-type labels for media `field_filesize` / `field_mimetype` fields.
- Visually flag unpublished content in non-full Display Suite view modes with an `entity-status-unpublished` class.
- Gate the contextual "Configure block" link behind a dedicated permission (`configure blocks from contextual links`) so it is not shown to every block-configuring user.
- Attach a small admin CSS layer only when the active admin theme is Claro.
- Serve as the umbrella project on drupal.org for long-term support of aging Sector legacy sites.
- Pair with the Radix theme (pinned as a requirement) and the Sector Radix Starter for legacy sub-themes.
- Provide the Search API-styled search block markup that replicates the default core search block design for Sector themes.
- Provide a placeholder/nag banner block announcing Sector distribution upgrade news to site administrators.
- Selectively enable only the pieces you need — each submodule is independent and can be turned on or off on its own.
- Use as a reference example of packaging distribution-specific blocks and UX tweaks as small, focused submodules.
