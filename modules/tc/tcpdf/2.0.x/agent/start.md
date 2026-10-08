# TCPDF — agent index

Developer-only wrapper around the `tecnickcom/tcpdf` PHP library for generating PDFs from code. No UI,
no `configure`, no permissions, no plugins. Library `tecnickcom/tcpdf` (^6.8) required via Composer.

- **`tcpdf_get_instance()`, `TCPDFDrupal`, `DrupalInitialize()`, config constants & overrides** →
  [api/usage.md](api/usage.md)

Submodule (own docs):
- `tcpdf_example` →
  [../../modules/tcpdf_example/2.0.x/agent/start.md](../../modules/tcpdf_example/2.0.x/agent/start.md)

Key facts:
- `tcpdf_get_instance(array $params = [], array $class = [], array $config = []): TCPDFDrupal` — the
  only entry point; returns a fresh subclass of `TCPDF`.
- Loads `tcpdf.config.inc` (defines `K_*`/`PDF_*` constants only if undefined) after defining
  `K_TCPDF_EXTERNAL_CONFIG`. Cache dir = `temporary://tcpdf/cache`.
- `hook_requirements` checks the TCPDF class exists and the cache dir is writable.
- `tcpdf.config.inc` ships `K_TCPDF_CALLS_IN_HTML = true`.
