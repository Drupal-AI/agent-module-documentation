<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# ODT Importer — agent index

**Converts uploaded .odt (OpenDocument Text) documents to HTML** for use in fields. Depends on core `field`,
`file`. Version **1.0.10**. Core `^10.3||^11||^12`.

Content-editing/import — parses **untrusted uploaded documents**; ensure imported HTML flows through a
**sanitizing text format** before display (XSS). No access role.
