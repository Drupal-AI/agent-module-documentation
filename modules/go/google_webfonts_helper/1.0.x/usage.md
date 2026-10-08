<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Google Webfonts Helper downloads Google Fonts to the site's own filesystem and serves them from there, so no visitor request reaches Google's font CDN. An admin adds each font at `/admin/config/system/google-webfonts-helper`; the module fetches the files, writes the `@font-face` CSS, and exposes the font as an attachable asset library.

---

The driver is legal and privacy-related more than technical. A German court found in 2022 that embedding Google Fonts from Google's servers transmits the visitor's IP address to a third country without consent, in breach of the GDPR, and a wave of claims followed; many European organisations now require self-hosting as policy. Self-hosting by hand means downloading the right weights and subsets, writing the `@font-face` rules and keeping them current — tedious enough that it gets deferred. This module turns each font into a `google_webfont` **configuration entity**: pick a font family, the variants (weights/styles) and subsets (charsets) in the admin form, and on save it downloads the files from the google-webfonts-helper service (`gwfh.mranftl.com`), extracts them under `fonts_path` (default `public://google-webfonts-helper`), and generates the CSS. Each font becomes a library `google_webfonts_helper/<id>` you attach to a theme, template, or render array. It needs only `symfony/finder` and no other Drupal module, with core `^9 || ^10 || ^11`. Two operational notes: the downloaded files are not configuration, so each environment re-fetches them (on save, and whenever asset libraries are rebuilt); and self-hosting is generally faster than the CDN in modern browsers, since cache partitioning removed the cross-site reuse that once made third-party font CDNs attractive.

---

- Self-host Google Fonts for GDPR compliance.
- Stop visitor IPs reaching Google's font CDN.
- Meet a European data-protection requirement.
- Avoid a consent banner just for web fonts.
- Download font files automatically from the admin UI.
- Generate `@font-face` CSS without hand-editing.
- Manage each font as a configuration entity.
- Export font definitions with `drush cex`.
- Choose specific weights, styles and subsets per font.
- Pick "best support" (eot/svg/ttf/woff/woff2) or "modern browsers" (woff/woff2) output.
- Set `font-display` (swap/optional/…) per font.
- Attach a font via `google_webfonts_helper/<id>` library.
- Serve fonts from the site's own domain or CDN.
- Improve font-loading performance vs the third-party CDN.
- Remove a third-party request from every page.
- Support a public-sector or regulated privacy policy.
- Update a self-hosted font by re-saving it.
- Keep font choices in version control.
- Support an offline or air-gapped site's fonts.
- Store fonts in a custom stream-wrapper path.
- Reduce external runtime dependencies.
- Avoid legal risk from embedded remote fonts.
