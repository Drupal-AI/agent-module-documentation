# Configuration

Entity Print Chrome is configured as an **engine choice inside Entity Print's own
settings** — it does not add a separate settings page. You select the Chrome
engine and tell it where the Chrome/Chromium binary lives.

## Open the settings form

1. Log in as a user with the **Administer site configuration** permission (an
   administrator by default).
2. Go to **Configuration → Content authoring → Entity Print**, or navigate
   directly to `/admin/config/content/entityprint`.

## Select the PDF engine

Find the **PDF engine** selector on Entity Print's settings page and choose
**Chrome**. This makes Chrome the engine used for PDF exports.

## Chrome engine settings

With Chrome selected, its options appear:

- **Path to the Chrome/Chromium binary** — the full filesystem path to the
  browser on the web server. The default is `/usr/bin/google-chrome`; change it
  if your binary lives elsewhere (for example `/usr/bin/chromium`). If this path
  is wrong, PDF generation will fail because the engine cannot launch Chrome.
- **Print background images** — optional. Enable it if you want background images
  and background colors from your CSS to appear in the PDF (needed for
  full‑color output such as colored headers or watermarks). Leave it off for
  leaner, ink‑friendly documents.

## Save

Click **Save configuration**. Then generate a PDF from any Entity Print print
link to confirm Chrome is producing the document with the CSS fidelity you
expect. For very large documents, be aware the engine allows a fixed timeout for
Chrome to produce the PDF, so extremely long pages may need to be split.

## Security note — Chrome runs without a sandbox

The engine launches Chrome with sandboxing disabled (`noSandbox`) and renders
from a temporary HTML file on the server. Because a browser running unsandboxed
is riskier if it processes untrusted markup, run the site (and therefore Chrome)
under a **low‑privilege service user or an isolated container**. The Chrome
binary path is admin‑only configuration, so keep this Entity Print settings form
restricted to trusted administrators. Temporary HTML files are written to
Drupal's `temporary://` directory and removed after each render.
