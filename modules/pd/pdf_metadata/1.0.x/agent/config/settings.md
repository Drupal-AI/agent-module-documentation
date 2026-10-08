<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# PDF Metadata — install & site settings

## Install & enable

```bash
composer require drupal/pdf_metadata
drush en pdf_metadata -y
```

Pulls in `token`, `hook_event_dispatcher` and `core_event_dispatcher` (core `file` is required
too). `hook_install()` sets `provider = ghostscript` if unset.

**Server requirement:** at least one command-line tool must be present, or nothing is written:

- **Ghostscript** — `gs` on `PATH`; check with `gs -v`. Default provider.
- **ExifTool** — `apt install libimage-exiftool-perl` / `brew install exiftool`, or
  `composer require phpexiftool/exiftool`.

`hook_requirements($phase='runtime')` in `pdf_metadata.install` reports the situation on the
status report: `REQUIREMENT_ERROR` when neither tool is available, `REQUIREMENT_WARNING` when the
configured provider is missing but another is available, `REQUIREMENT_OK` otherwise.

## Settings form

- Route **`pdf_metadata.settings`** → `/admin/config/content/pdf-metadata/settings`
  (`pdf_metadata.routing.yml`), permission **`administer site configuration`**, `_admin_route`.
- Form class `Form\SettingsForm` (extends `ConfigFormBase`); menu link
  `pdf_metadata.links.menu.yml` places it under `system.admin_config_content`.
  *(Note: the README's `/admin/config/media/...` path is stale — the actual route is under
  `admin/config/content`.)*

Fields:

| Form key | Config key | Meaning |
|---|---|---|
| `provider` (radios) | `provider` | `ghostscript` or `exiftool`; each option shows a ✓/✗ availability marker. Default `ghostscript`. |
| `exiftool_binary_path` (textfield) | `exiftool_binary_path` | Optional absolute path to the ExifTool binary; empty = auto-detect. Only relevant to the ExifTool provider. |
| `extra_gs_options` (textarea, one per line) | `extra_gs_options` | Extra Ghostscript command arguments; stored as a sequence (trimmed, blanks filtered). |

`buildForm()` also renders an **Auto-Detection Results** table (via
`ExiftoolProvider::getDetectionPaths()`) and static installation help. `validateForm()` verifies a
supplied `exiftool_binary_path` exists, is executable, and responds to `-ver`; it warns if the
selected provider is unavailable. `submitForm()` saves the config and calls
`drupal_flush_all_caches()` (the provider manager is built once in the container, so a rebuild is
needed to pick up the change).

## Config object & schema

Config object **`pdf_metadata.settings`** (`config/install/pdf_metadata.settings.yml`):

```yaml
provider: ghostscript
exiftool_binary_path: ''
extra_gs_options: []
```

Schema `config/schema/pdf_metadata.schema.yml` types these plus the per-field third-party schema
`field.field.*.*.*.third_party.pdf_metadata` (`enabled` bool, `reference_enabled` bool,
`meta_types` mapping of `title`/`author`/`subject`/`keywords` strings).

## Providers & selection

`Provider\PdfMetadataProviderManager` (service `pdf_metadata.provider_manager`) registers both
providers in `initializeProviders()` and exposes:

- `getActiveProvider()` — returns the configured provider; if it is not `isAvailable()`, falls back
  to `ghostscript`, then to `exiftool`.
- `getProviders()` / `getAvailableProviders()` / `getProviderOptions()` — used by the form and
  `hook_requirements`.

Both providers implement `Provider\PdfMetadataProviderInterface`:

- **`GhostscriptProvider`** (`getId()='ghostscript'`): `isAvailable()` runs `gs -v`.
  `writeMetadata()` writes to a temp file with `-sDEVICE=pdfwrite -dSAFER` and a `/DOCINFO pdfmark`,
  then `rename()`s over the original only on success — a failed run leaves the stored PDF intact.
  May flatten interactive form fields.
- **`ExiftoolProvider`** (`getId()='exiftool'`): `detectBinary()` searches, in order, the custom
  configured path, `vendor/phpexiftool/exiftool/exiftool`, `which exiftool`, then common system
  paths (`/usr/bin`, `/usr/local/bin`, homebrew, MacPorts); results are cached. `writeMetadata()`
  runs ExifTool with `-overwrite_original`, editing metadata in place (preserves fillable forms).

Operate it: pick the provider that matches your need (forms → ExifTool; broad availability →
Ghostscript). The module falls back automatically, so on a server with only one tool the choice
mostly affects the label shown. Provider changes take effect after the cache flush the form
performs.
