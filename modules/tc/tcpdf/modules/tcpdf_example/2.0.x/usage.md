Demonstration/reference submodule for the TCPDF module: a permission-gated route that renders a Twig template to HTML and streams it back as a downloadable sample PDF, showing the intended `tcpdf_get_instance()` + `DrupalInitialize()` integration pattern. Enable it to learn the API and copy the controller — it is a learning aid, not a production feature.

---

`tcpdf_example` exposes two routes, both requiring the `use tcpdf example` permission: `/tcpdf_example/content` (`TcpPdfExampleController::exampleContents()`, a page linking to the sample) and `/tcpdf_example/download/{example_name}` (`::downloadPdf()`), which for `example_name = simple` calls `generateSimplePdf()`. That method renders the `tcpdf_example_basic_html` theme template (registered by `hook_theme()` in `tcpdf_example.module`) to HTML, obtains a wrapper instance via the parent module's `tcpdf_get_instance()`, initializes it with `DrupalInitialize()` (setting an HTML footer and a header produced by the `tcpdf_example_default_header()` callback, which draws the site logo and a welcome message), writes the HTML with `writeHTML()`, and returns the binary from `Output('', 'S')`. `downloadPdf()` sends raw `Content-Type: application/pdf` and `Content-Disposition: attachment` headers, prints the bytes, and exits; any `example_name` other than `simple` throws `\InvalidArgumentException`. It defines no config, services, or plugins of its own. Note: as shipped in 2.0.4 the controller has no `create()` method to satisfy the injected renderer, so both routes fatal under current Drupal core until a `create()` is added — copy the pattern rather than expecting it to run untouched.

---

- See a working end-to-end example of generating a PDF with the TCPDF module.
- Copy the controller pattern for streaming a generated PDF as a browser download.
- Learn how to render a Twig template to HTML and feed it to `writeHTML()`.
- See how `DrupalInitialize()` sets an HTML footer and a header callback.
- Study the header-callback contract (`tcpdf_example_default_header`) that receives the PDF instance plus context.
- See how the active theme logo is placed into the PDF header via `$tcpdf->Image()`.
- Reference the correct `Content-Type` / `Content-Disposition` headers for a PDF download.
- Demonstrate routing + permission wiring for a PDF-generating endpoint.
- Onboard developers to the module's intended usage without reading the library source.
- Use as scaffolding to build a real "Download as PDF" feature.
- Restrict PDF-generation demos to trusted users via the `use tcpdf example` permission.
- Show how invalid input is rejected (a non-`simple` example name throws an exception).
- Register a demo page in the menu via a `links.menu.yml` link.
- Learn why you should call `tcpdf_get_instance()` instead of `new TCPDFDrupal()`.
- Serve as a copy-paste starting point for building binary responses from a controller.
- Learn the `create()`/`__construct()` dependency-injection fix needed to make the demo runnable.
