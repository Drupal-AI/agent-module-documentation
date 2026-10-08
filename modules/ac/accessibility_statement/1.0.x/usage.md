<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Accessibility Statement provides a dedicated, configuration-driven page that publishes a legally structured accessibility statement for a Drupal site.
---
EU Directive 2016/2102 requires public-sector sites to publish a structured accessibility statement, and since June 2025 the European Accessibility Act (2019/882, implemented in Germany as the BFSG) extends similar duties to private products and services. Sites usually hand-author a free-text node that lacks structure and is hard to keep consistent; this module replaces that with a schema-backed admin form.

An admin form at `/admin/config/system/accessibility-statement` (permission `administer accessibility statement`) collects all required data in structured fields, with conditional sections depending on whether the statement covers a public-sector body or a product/service. The public page path is configurable (a route subscriber rewrites the route from config) and defaults to `/accessibility-statement`, exposed via `_access: 'TRUE'` because such statements must be reachable by everyone. The output is config-only semantic HTML — no request input is stored or reflected — with `aria-label`, `aria-live` for AJAX, machine-readable `<time>` dates and sanitized `tel:` links. A footer menu link is added on install and the `accessibility-statement.html.twig` template is themeable.

Typical setup: enable the module, open the settings form, choose the statement type, record the conformance status against EN 301 549 / WCAG 2.1 or 2.2 AA, list any non-accessible content, and fill in the contact and enforcement/market-surveillance details.
---
- Publish a legally structured accessibility statement page
- Comply with EU Directive 2016/2102 for a public-sector site
- Comply with the European Accessibility Act 2019/882 / BFSG for a product or service
- Choose between a public-sector-body or product/service statement type
- Change the statement URL path from the default `/accessibility-statement`
- Use a localized path such as `/barrierefreiheitserklaerung`
- Declare a fully, partially, or non-conformant status
- Measure conformance against EN 301 549
- Measure conformance against WCAG 2.1 AA or WCAG 2.2 AA
- List non-accessible content under the non-compliance category
- List content excluded as a disproportionate burden
- List content that is out of scope of the legislation
- Add or remove non-accessible content rows via AJAX
- Provide a feedback contact name, email, phone and postal address
- Render a sanitized `tel:` link for the contact phone
- Configure an enforcement / arbitration body (public sector)
- Configure a market surveillance authority (private sector / BFSG)
- Add a machine-readable last-review `<time>` date
- Expose the statement via the auto-created footer menu link
- Restrict editing to trusted roles via the provided permission
- Theme the page by overriding `accessibility-statement.html.twig`
- Translate the statement content via config translation
- Set an SEO meta description for the statement page
- Keep the statement consistent through structured fields instead of free text
