Puphpeteer is a pdf_api submodule that adds a fifth PDF backend which renders HTML to PDF with a real headless Chrome browser driven by Puppeteer (via the `NigelCunningham/puphpeteer` PHP↔Node bridge), giving full CSS/JS fidelity that pure-PHP backends cannot.

---

Puphpeteer registers a `puphpeteer` `PdfGenerator` plugin against pdf_api's plugin type, wrapping the `NigelCunningham\Puphpeteer\Puppeteer` service to launch (or connect to) a headless Chrome instance and print the page to PDF. Because Chrome executes JavaScript and applies the full CSS engine, it produces the most browser-accurate output of the pdf_api backends, and it can optionally load **paged.js** for print-oriented pagination. Behaviour is controlled by the `puphpeteer.settings` config object: the Node executable path, extra Chrome args, headless/devtools/slowMo debugging, idle/read/stop timeouts, the content `source` (default `printable`), whether to use an external Puppeteer service (`service` + `service_url`), whether to leave the browser running, basic-auth credentials, and `pagedjs`/`printBackground` toggles. There is a small settings form at `/admin/config/system/pdf-api/puphpeteer` (route `puphpeteer.config`, permission *administer site configuration*) and a controller route. The submodule is **not enabled by default and is intentionally left disabled in this environment** because it requires a working Node.js runtime plus the Puppeteer library (`NigelCunningham/puphpeteer`, which installs Chromium) — none of which the pure-Drupal install provides. Everything documented here is derived from the source and config schema; the config object can still be created/read on a site where the module is disabled, but actual PDF generation needs the Node/Puppeteer stack installed.

---

- Render a PDF with full JavaScript execution (charts, client-side widgets) that dompdf/mPDF cannot run.
- Produce browser-accurate CSS output (flexbox, grid, web fonts) for high-fidelity documents.
- Generate print-optimised, paginated PDFs by enabling paged.js (`pagedjs: true`).
- Include CSS background images/colors in output via `printBackground`.
- Point the backend at a specific Node binary with `executable_path` when Node isn't on the default path.
- Connect to an already-running/remote Chrome instead of launching one (`service: true`, `service_url`).
- Keep a warm browser between generations (`leave_running`) to reduce per-PDF startup cost.
- Pass extra Chrome flags (e.g. `--no-sandbox`) via `chrome_extra_args` for containerised hosts.
- Fetch protected pages behind HTTP basic auth by supplying basic-auth username/password.
- Debug rendering by disabling headless mode and opening devtools (`headless: false`, `devTools: true`).
- Slow down Puppeteer actions for observation while debugging (`slowMo`).
- Choose the content source used to build the PDF (`source`, default `printable`).
- Tune idle/read/stop timeouts for large or slow-rendering pages.
- Serve as the pdf_api backend selected by Entity Print / Printable when maximum fidelity is required.
- Export dashboards or reports whose layout depends on JavaScript rendering.
- Generate PDFs of pages using modern CSS that HTML-to-PDF PHP libraries render incorrectly.
- Swap in Puppeteer for just the documents that need it while other content uses dompdf.
- Log Puppeteer/Chrome output to the Node or browser console for diagnostics.
- Trigger the Node debugger during a render (`triggerDebugging`) when chasing a rendering bug.
