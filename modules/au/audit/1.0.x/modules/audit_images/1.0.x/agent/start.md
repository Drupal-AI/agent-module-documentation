<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Audit: Images (audit_images) — agent index

Analyzes image display configuration including image styles, responsive styles, breakpoints, and field formatters.

Submodule of the **audit** framework. Depends on: `audit`. Core `^10.2 || ^11 || ^12`. Version 1.0.11.

## Analyzer plugin

- Plugin id `images` — `ImagesAnalyzer` (`src/Plugin/AuditAnalyzer/ImagesAnalyzer.php`), extends `AuditAnalyzerBase`, `#[AuditAnalyzer]` weight 3 (default Project-Score multiplier).
- Detail-page checks (`getAuditChecks()`): `modules` (Modules), `image_styles` (Image Styles), `responsive_styles` (Responsive Image Styles), `ckeditor_styles` (CKEditor Image Styles), `unused_styles` (Unused Styles), `lazy_loading` (Lazy Loading), `image_fields` (Image Field Analysis), `image_fields_issues` (Image Field Issues).

## Configuration

- No settings of its own.

## Run it

- UI: Reports > Audit > `Audit: Images` detail page (runs live, `view audit results` permission).
- Drush: `drush audit:run images` (JSON; add `--filter=...`, `--fail-on=error`), discover filters with `drush audit:filters images`.

Parent framework + plugin API: [../../../../agent/start.md](../../../../agent/start.md), [../../../../agent/plugins/analyzer.md](../../../../agent/plugins/analyzer.md).
