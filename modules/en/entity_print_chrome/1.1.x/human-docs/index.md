# Entity Print Chrome — manual setup guide

**Entity Print Chrome** (`entity_print_chrome`) adds a **headless‑Chrome PDF
engine** to the [Entity Print](https://www.drupal.org/project/entity_print)
module. Where Entity Print ships engines such as Dompdf and wkhtmltopdf, this
module contributes a `chrome` engine that uses the `chrome-php/chrome` PHP
library to drive a local Chrome/Chromium browser and turn Entity Print's rendered
HTML into a high‑fidelity PDF.

It is the right choice when you need modern CSS support — flexbox, grid, and web
fonts — in printed PDFs that older engines render poorly. Page selection,
routing, print links, and access control all continue to come from Entity Print
itself; this module only supplies the engine plus a small HTML post‑processor
that rewrites root‑relative asset paths so local images and stylesheets resolve
when Chrome renders from a temporary file.

The module needs a little setup: a Chrome/Chromium binary must be present on the
web server, and you select "Chrome" as the PDF engine in Entity Print's settings
(setting the binary path if it differs from the default). It depends on **Entity
Print** and the `chrome-php/chrome` Composer library, and supports Drupal 9 and
10. One operational note: the engine launches Chrome with sandboxing disabled
(`noSandbox`), so run it under a low‑privilege service user or container — see the
security note in [Configuration](configuration/index.md).

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer (which pulls in
   `chrome-php/chrome`), enable it and Entity Print, and provide a Chrome binary.
2. [Configuration](configuration/index.md) — select the Chrome engine, set the
   binary path, and tune options.

## Where it lives in the admin menu

You configure the print engine through Entity Print's own settings at
**Configuration → Content authoring → Entity Print**
(`/admin/config/content/entityprint`). This module adds the *Chrome* engine
choice and its options there.
