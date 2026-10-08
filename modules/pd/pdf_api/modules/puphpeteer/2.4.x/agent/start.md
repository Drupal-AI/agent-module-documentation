# Puphpeteer — agent index

pdf_api submodule adding a **`puphpeteer`** `PdfGenerator` backend that renders HTML to PDF
with headless Chrome via Puppeteer (`NigelCunningham\Puphpeteer\Puppeteer`). Depends on
`pdf_api`. **Not enabled by default / left disabled here** — needs Node.js + the Puppeteer
library (Chromium). Config object `puphpeteer.settings` can still be written/read while
disabled, but generation needs the Node stack.

- **Settings form, config object `puphpeteer.settings`, keys** → [configure/settings.md](configure/settings.md)

Key facts:
- Generator plugin id `puphpeteer` (class `PuphpeteerGenerator`, extends pdf_api's `PdfGeneratorBase`, `required_class = "NigelCunningham\\Puphpeteer\\Puppeteer"`). It plugs into pdf_api's `plugin.manager.pdf_generator` — see the parent [pdf_api plugins doc](../../../../2.4.x/agent/plugins/pdf-generator.md).
- Settings form route `puphpeteer.config` at `/admin/config/system/pdf-api/puphpeteer` (permission `administer site configuration`).
- Service `puphpeteer` → `NigelCunningham\Puphpeteer\Puppeteer`.
- No permissions of its own, no Drush, no plugin types of its own.
