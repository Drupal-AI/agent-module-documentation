# File Link — agent index

Provides the `file_link` **field type**: a core Link field that points only at files and stores
each target's **size** and **MIME type** (`format`). Depends on core `link` + `file`. No admin
settings page (`configure: null`), no permissions, no Drush. Config schema provided.

- **The `file_link` field type, its settings, widget & formatters** →
  [fields/file-link-field.md](fields/file-link-field.md)
- **HTTP fetch behaviour: `settings.php` flags, deferred requests, the queue worker, LinkToFile constraint** →
  [configure/http-behavior.md](configure/http-behavior.md)

Key facts: field type id `file_link` (extends `LinkItem`); extra stored columns `size` (int) +
`format` (string MIME). Field settings: `file_extensions` (default `txt`), `no_extension`
(bool), `deferred_request` (bool). Widget `file_link_default`; formatters `file_link` and
`file_link_separate` (option `format_size`). Queue worker `file_link_metadata_update`. Settings:
`file_link.follow_redirect_on_validate` (default TRUE), `file_link.disable_http_requests`
(default FALSE).
