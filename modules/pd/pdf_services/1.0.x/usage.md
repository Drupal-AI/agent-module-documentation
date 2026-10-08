<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
PDF Services integrates the Adobe PDF Services API for PDF analysis and optimization.

---

PDF Services **integrates the Adobe PDF Services API** — sending PDFs to Adobe's cloud service for analysis and
optimization (compression, accessibility, extraction). It stores credentials via the **Key** module, depends on
core File, and provides its own permissions, in the Content package.

Use it to process PDFs via Adobe. It is an integration/PDF feature. Security/data handling: it **uploads your PDFs
to the Adobe PDF Services API** (external egress — PDFs can contain sensitive content; confirm acceptable and
disclose per policy) and authenticates with **Adobe credentials stored via the Key module** (secret handling, a
positive). Serve over HTTPS. It has no access-control role beyond its permission. Configure the Adobe credentials
(via Key).

---

- Integrate the Adobe PDF Services API.
- Analyze/optimize PDFs.
- Compress/extract PDF content.
- Store credentials via the Key module.
- Depend on core File + provide permissions.
- Serve integration/PDF.
- Upload PDFs to the Adobe API (egress; can be sensitive).
- Store Adobe credentials via Key (positive).
- Serve over HTTPS + disclose per policy.
- Have no access-control role beyond permission.
- Configure the Adobe credentials via Key.
- Handle PDF services.
- Process PDFs.
- Configure the client.
- Optimize PDFs.
- Handle the integration.
- Analyze PDFs.
- Upload PDFs.
- Secure the credentials via Key.
- Provide Adobe PDF services.
