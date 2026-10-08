Vendor Stream Wrapper registers a read-only `vendor://` stream wrapper so CSS/JS (and other files) that live in Composer's `vendor/` directory — typically outside the webroot — can be referenced from Drupal libraries and resolved to public URLs, without copying them into the docroot.

---

The module tags a stream wrapper service for the `vendor` scheme (`Drupal\vendor_stream_wrapper\StreamWrapper\VendorStreamWrapper`), so `vendor://vendor-name/package/path/file.css` resolves to the file inside the vendor directory. It locates the vendor directory at `../vendor` then `./vendor`, or at `$settings['vendor_file_path']` if set in `settings.php` (throwing `VendorDirectoryNotFoundException` if none is found). It implements `hook_library_info_alter()` to rewrite any `vendor://` path found in `*.libraries.yml` `js`/`css` entries into a real URL, and provides a helper `vendor_stream_wrapper_create_url($uri, $include_base_url = TRUE)` (delegating to the `vendor_stream_wrapper.manager` service's `createUrlFromUri()`) for resolving URIs in code. Public access is deliberately locked down: files are served through the route `vendor_stream_wrapper.vendor_file_download` at `/vendor_files/{filepath}`, and a file is only downloadable if it matches a **safe-list** pattern. Site owners set those patterns as `allowed_file_patterns` (one glob per line, `*` wildcard) in config `vendor_stream_wrapper.settings` via the form at `/admin/config/media/vendor-stream-wrapper`; a `hook_requirements()` warning fires when none are set. Patterns are collected by dispatching the `VendorStreamWrapperEvents::COLLECT_SAFE_LIST_REGEX_PATTERNS` event — the module's own subscriber turns each glob into an anchored regex, and other modules can subscribe to contribute patterns programmatically. It also decorates the core CSS/JS asset optimizers so aggregated assets referencing vendor files are handled correctly.

---

- Reference a Composer-installed library's CSS from a Drupal library without copying it to the docroot.
- Load a vendor JS file (e.g. a JS package under `vendor/`) via `vendor://` in `*.libraries.yml`.
- Keep the `vendor/` directory outside the webroot but still serve specific assets from it.
- Attach a third-party CSS file shipped by a Composer package to a theme or module.
- Build a URL to a vendor asset in PHP with `vendor_stream_wrapper_create_url()`.
- Expose only whitelisted CSS files from a vendor package while blocking everything else.
- Allow `foo/bar/css/*.css` downloads from a specific vendor package via a safe-list pattern.
- Point the module at a non-standard vendor location using `$settings['vendor_file_path']`.
- Serve font or icon files bundled inside a Composer package to the browser.
- Provide a module dependency's front-end assets without a build step or symlink.
- Let a contrib module contribute its own safe-list patterns via the collect-patterns event.
- Avoid committing vendor assets into the site repository's web directory.
- Reference a shared JS widget library installed via Composer across multiple themes.
- Aggregate vendor CSS/JS alongside site assets through the decorated optimizers.
- Gate access so only intentional files under `vendor/` are web-accessible.
- Resolve `vendor://` URIs to root-relative paths (without base URL) for embedding.
- Migrate a site to keep libraries in `vendor/` for cleaner Composer-managed dependencies.
- Serve a CKEditor/JS plugin's assets straight from its Composer package directory.
- Diagnose misconfiguration via the runtime requirements warning when no patterns are set.
- Distribute a module that pulls its front-end library from `vendor/` on install.
- Restrict downloadable vendor files to specific extensions using wildcard patterns.
- Provide public URLs for vendor assets much like `private://` works for private files.
