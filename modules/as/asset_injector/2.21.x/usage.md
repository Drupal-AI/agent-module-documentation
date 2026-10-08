Asset Injector lets administrators add custom CSS and JavaScript snippets to page output through configurable rules, without editing a theme.

---

Asset Injector combines the classic CSS Injector and JS Injector modules into one, giving site administrators a UI to paste CSS or JS that is then attached to rendered pages. Each snippet is a configuration entity (`asset_injector_css` / `asset_injector_js`) edited at Admin → Configuration → Development → Asset Injector, so snippets are exportable YAML and deployable between environments (great for multisite). Each asset can be scoped with visibility conditions — for example only on certain paths, content types, or for certain roles — and JS assets can target header or footer and declare jQuery/other library dependencies. Assets are compiled into a dynamic Drupal library so core aggregation and caching apply, and the generated library can be altered with `hook_asset_injector_library_info_build_alter()`. It is explicitly not a replacement for real theming, but a quick way to apply small tweaks or third-party snippets (analytics, chat widgets, style fixes). Access is tightly restricted via dedicated permissions because injecting JS is a security-sensitive capability. Snippets can be enabled, disabled, duplicated, or deleted individually.

---

- Add a small CSS override to fix spacing without touching the theme.
- Inject a third-party chat widget's JavaScript site-wide.
- Add an analytics or tag-manager snippet to page output.
- Apply CSS tweaks only on specific pages via path conditions.
- Load a JS snippet only for authenticated users by role condition.
- Restrict a style override to a single content type.
- Add print-specific CSS through the media/settings on an asset.
- Place a script in the footer to avoid render-blocking.
- Declare a jQuery dependency for a JS snippet.
- Quickly prototype a design fix before committing it to a theme.
- Add a cookie-consent banner script across the site.
- Inject a promotional banner's CSS/JS during a campaign, then disable it.
- Export asset snippets as config and deploy them to production.
- Share a common tweak across a multisite via a config split.
- Duplicate an existing asset to create a variant quickly.
- Temporarily disable an asset without deleting it.
- Add hover/animation CSS to a specific view or block.
- Load a small polyfill script conditionally.
- Override a contrib module's styling with higher-specificity CSS.
- Add tracking pixels or conversion scripts to landing pages only.
- Inject custom fonts' @font-face CSS.
- Alter the generated asset library programmatically via the provided hook.
