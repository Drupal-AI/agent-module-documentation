<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Gotenberg adds a Gotenberg integration to your Drupal site.

---

Gotenberg integrates the **Gotenberg** document-conversion service — sending HTML (or a page) to a
Gotenberg instance to generate **PDFs** (and other formats), giving high-fidelity Chromium-based PDF rendering.
It is in the PDF package.

Use it to generate PDFs via Gotenberg. It is an integration feature. Security note: the Gotenberg endpoint URL
is **admin-configured** (its settings route requires `administer gotenberg settings`), and Gotenberg runs a
headless browser — point it only at a **trusted Gotenberg instance** you control (typically on your own
network), keep that endpoint access-restricted, and be mindful that the HTML you send is rendered by that
service. It has no access-control role of its own. Configure the Gotenberg endpoint.

---

- Integrate the Gotenberg service.
- Convert HTML/URLs to PDF.
- Render PDFs via Chromium.
- Serve PDF generation.
- Admin-configure the endpoint.
- Gate settings by permission.
- Point only at a trusted Gotenberg instance.
- Keep the endpoint access-restricted.
- Note the service renders your HTML.
- Have no access-control role of its own.
- Configure the Gotenberg endpoint.
- Handle PDF generation.
- Generate PDFs.
- Configure the service.
- Convert to PDF.
- Handle the integration.
- Render PDFs.
- Make PDFs.
- Secure the endpoint.
- Provide Gotenberg PDF.
