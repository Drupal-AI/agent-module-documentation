# TCPDF Example — agent index

Example/demo submodule of `tcpdf`. Enable it to see a working PDF-generation endpoint and to copy the
controller as a starting point for your own "download as PDF" feature. Depends on `tcpdf`
(`tcpdf:tcpdf`). Core requirement `^11.3 || ^12`. No settings page, no services, no config schema, no
plugins — a learning aid, not for production.

- **The demo route + controller, and how it calls the parent's `tcpdf_get_instance()` /
  `DrupalInitialize()`** → [api/example.md](api/example.md)
- **The `use tcpdf example` permission** → [permissions/permissions.md](permissions/permissions.md)

Parent module (the actual API you would use in real code):
- `tcpdf` → [../../../../3.0.x/agent/start.md](../../../../3.0.x/agent/start.md) ·
  API: [../../../../3.0.x/agent/api/usage.md](../../../../3.0.x/agent/api/usage.md)

Key facts:
- Permission `use tcpdf example` gates BOTH routes.
- Routes: `tcpdf_example.content` → `/tcpdf_example/content` (`::exampleContents`, a page linking to
  the sample); `tcpdf_example.download_pdf` → `/tcpdf_example/download/{example_name}`
  (`::downloadPdf`; only `simple` is valid, else `\InvalidArgumentException`; return type `never`).
- Controller `\Drupal\tcpdf_example\Controller\TcpPdfExampleController` (final, extends
  `ControllerBase`, constructor-injects `\Drupal\Core\Render\RendererInterface`).
- Theme hook `tcpdf_example_basic_html` is now registered by the OOP hook class
  `\Drupal\tcpdf_example\Hook\TcpdfExampleHooks::theme()` (`#[Hook('theme')]`); `tcpdf_example.module`
  keeps a `#[LegacyHook]` `tcpdf_example_theme()` that delegates to it. Template
  `templates/tcpdf_example_basic_html.html.twig`, no variables.
- Header-callback helper `tcpdf_example_default_header(TCPDFDrupal $tcpdf, array $context)` still lives
  procedurally in `tcpdf_example.module`.
- Menu link `tcpdf_example.content` (`tcpdf_example.links.menu.yml`).
- Caveat: as shipped in 3.0.0 the controller still defines no `create()`, so it fatals under current
  core until one is added — see [api/example.md](api/example.md).
