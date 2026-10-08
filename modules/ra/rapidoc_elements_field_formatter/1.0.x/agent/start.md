<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# RapiDoc Elements Field Formatter — agent orientation

Two field formatters under `src/Plugin/Field/FieldFormatter/`:
- `RapiDocElementsUIFormatter` (file fields) — extends `FileFormatterBase`, resolves the file
  URI to an absolute URL via `FileUrlGeneratorInterface::generateAbsoluteString()`.
- `RapiDocElementsUILinkFormatter` (link fields) — extends core `LinkFormatter`, uses
  `buildUrl($link)` (editor-supplied URL).

Both set `#theme => rapidoc_elements_ui_field_item` and attach the `rapidoc` library. The Twig
template emits `<rapi-doc spec-url="{{ file_url }}" ...>`; the RapiDoc component fetches the
spec in the browser.

Security notes (reviewed, no server-side vuln):
- The library JS is loaded from the `unpkg.com` CDN (external) — supply-chain / CSP concern, not
  a code vuln.
- `spec-url` is auto-escaped by Twig; no stored XSS. The link formatter renders an
  editor-supplied URL (requires field-edit access) fetched client-side — not server-side SSRF.
