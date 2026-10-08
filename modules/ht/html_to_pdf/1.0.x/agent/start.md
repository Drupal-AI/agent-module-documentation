<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# HTML to PDF — agent index

**Conversion of an uploaded HTML file to PDF** using the Dompdf library. Version **1.0.0**. Core `^10||^11`.

Content/utility — uses **Dompdf** (library, no shell exec/injection) on **uploaded HTML**: keep Dompdf remote
resources disabled (SSRF), avoid `phar`, gate the upload form, treat HTML as untrusted. No access role.
