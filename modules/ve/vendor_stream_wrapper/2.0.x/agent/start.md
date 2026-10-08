# Vendor Stream Wrapper — agent index

Registers a read-only **`vendor://`** stream wrapper for files in Composer's `vendor/` directory,
rewrites `vendor://` paths in `*.libraries.yml`, and serves whitelisted vendor files at
`/vendor_files/{filepath}`. No plugin types, no Drush, no permissions of its own (the settings form
uses core `administer site configuration`; downloads require `access content`).

- **Safe-list config (`allowed_file_patterns`), the settings form, and `vendor_file_path`** →
  [configure/patterns.md](configure/patterns.md)
- **Services, the `vendor_stream_wrapper_create_url()` helper, download route, the safe-list event** →
  [api/stream-wrapper.md](api/stream-wrapper.md)

Key facts:
- Config object `vendor_stream_wrapper.settings`, key `allowed_file_patterns` (a **sequence of
  strings**, one glob per line, `*` wildcard). Empty = nothing downloadable (a requirements warning
  shows).
- UI route `vendor_stream_wrapper.settings` → `/admin/config/media/vendor-stream-wrapper`.
- Download route `vendor_stream_wrapper.vendor_file_download` → `/vendor_files/{filepath}`
  (permission `access content`); a file serves only if it matches a safe-list pattern.
- Vendor dir resolution: `$settings['vendor_file_path']` (settings.php) → `../vendor` → `./vendor`.
- Helper: `vendor_stream_wrapper_create_url('vendor://pkg/file.css', $include_base_url = TRUE)`.
- Patterns are gathered via `VendorStreamWrapperEvents::COLLECT_SAFE_LIST_REGEX_PATTERNS`; contrib
  modules can subscribe to add patterns.
