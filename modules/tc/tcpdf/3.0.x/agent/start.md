# TCPDF — agent index

Developer-only wrapper around the `tecnickcom/tcpdf` PHP library for generating PDFs from code. No UI,
no `configure`, no permissions, no plugins. Requires `tecnickcom/tcpdf` **^7.0.15** via Composer, which
pulls the `tecnickcom/tc-lib-pdf` 8.x component family. Core requirement is **`^11.3 || ^12`** (Drupal 10
is no longer supported).

- **`tcpdf_get_instance()`, `TCPDFDrupal`, `DrupalInitialize()`, the `FontDirectory` service, config
  constants & override points** → [api/usage.md](api/usage.md)

Submodule (own docs):
- `tcpdf_example` →
  [../../modules/tcpdf_example/3.0.x/agent/start.md](../../modules/tcpdf_example/3.0.x/agent/start.md)

Key facts:
- `tcpdf_get_instance(array $params = [], array $class = [], array $config = []): TCPDFDrupal` — the
  only entry point; returns a fresh subclass of `TCPDF`. Signature unchanged from 2.x.
- Loads `tcpdf.config.inc` (defines constants only if undefined) after defining `K_TCPDF_EXTERNAL_CONFIG`.
  In 3.0 that include defines only `K_PATH_FONTS` (resolved by the `FontDirectory` service) and
  `PDF_IMAGE_SCALE_RATIO = 1.25`; every other `K_*`/`PDF_*` constant now comes from TCPDF 7's
  `tcpdf_autoconfig.php`. There is no module-managed cache dir any more.
- `FontDirectory` (`\Drupal\tcpdf\FontDirectory`, autowired service) locates the font files. TCPDF 7 ships
  no fonts; they must be built, and `$settings['tcpdf_fonts_path']` can point at a directory outside
  `vendor/`.
- Requirements run through the OOP hook `\Drupal\tcpdf\Hook\TcpdfRequirements` (`#[Hook('runtime_requirements')]`):
  checks the `TCPDF` class exists and that the core fonts are available.
- `DrupalInitialize()` gained `subject`, `author` and `logo_path` option keys and now defaults title /
  author / subject to the site name.
