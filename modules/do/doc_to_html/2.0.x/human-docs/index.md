# DOC to HTML — manual setup guide

**DOC to HTML** (`doc_to_html`) lets editors upload a Word document straight from a
node edit form and have it converted to clean HTML that lands inside a CKEditor 5
text field. Behind the scenes the module hands the uploaded file to
**LibreOffice** (running on the same server as Drupal), converts it to HTML,
extracts and tidies the body markup, and drops the result into the editor ready to
review and save.

The primary supported formats are **DOC** and **DOCX**, and a site builder can
enable additional LibreOffice-supported formats — **ODT**, **RTF**, and **PPTX** —
from the module configuration. It solves the familiar problem of editors pasting
messy Word markup into the editor by hand: instead, the document is converted
server-side through a repeatable, configurable pipeline.

This module needs setup before it does anything useful. First, **LibreOffice must
be installed** on the same environment where Drupal's PHP runs (web server,
PHP-FPM container, or DDEV web container), because Drupal shells out to it on the
command line. Second, you point the module's settings at the LibreOffice binary
and choose your options. Third, you add the **DOC to HTML** widget to a long-text
field. A built-in **Test Wizard** lets you confirm the conversion works before you
enable the widget on real content. It depends only on core's File and Text
modules, and requires PHP 8.1 or later.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable the
   module, and make sure LibreOffice is available on the server.
2. [Configuration](configuration/index.md) — point the module at LibreOffice, set
   conversion options, run the Test Wizard, and add the widget to a field.

## Where it lives in the admin menu

The module's admin forms sit under **Configuration → Content authoring → DOC to
HTML**:

- **Basic settings** — `/admin/config/content/doc_to_html/basic-settings`
  (the module's main configure route: output folder, enabled upload formats, HTML
  cleanup options).
- **LibreOffice settings** — `/admin/config/content/doc_to_html/libreoffice-settings`
  (the binary path, executable name, and conversion timeout).
- **Test Wizard** — `/admin/config/content/doc_to_html/test-wizard`
  (upload a sample document and preview the conversion result).

All three require the **Administer DOC to HTML settings** permission. Editors who
will actually use the upload widget need the separate **Use DOC to HTML widget**
permission.
