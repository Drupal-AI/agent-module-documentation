<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
HTML Purifier wraps the audited `ezyang/htmlpurifier` PHP library as a Drupal text-format filter that strips XSS and other malicious HTML while rewriting the remaining markup into standards-compliant, well-formed output.

---

The module provides a single filter plugin, `htmlpurifier` (`Plugin\Filter\HtmlPurifierFilter`, type `TYPE_TRANSFORM_IRREVERSIBLE`), that you enable per text format at `admin/config/content/formats`. On each `process()` call it builds an `HTMLPurifier_Config` — the default config when the filter's settings are empty, otherwise a config assembled from a YAML blob you paste into the filter's settings form. The YAML is decoded and applied namespace-by-namespace via `$purifier_config->set("$namespace.$key", $value)`, with the `Cache` namespace deliberately stripped out so a text format can't touch cache internals. Purifier's serializer cache is written to `[temp]/htmlpurifier` by default (or an absolute path from `htmlpurifier.settings:cache_serializer_path`), and the directory is prepared each run. Unlike core's kses-based "Limit allowed HTML tags" filter, HTML Purifier understands the full HTML spec, so it can permit rich constructs (tables, inline styles, fonts) while still guaranteeing safe, valid output — making it a strong pairing with WYSIWYG editors. The settings form validates your YAML by trapping the library's `trigger_error()` calls through a custom error handler and surfacing them as form errors (deprecation notices are ignored). Because it is a filter, its protection depends on being enabled on the right formats and placed correctly in the filter order (it should run last, after any filter that could re-introduce raw markup). Config is a single string per format plus one settings object; there are no permissions, plugins, services or Drush commands.

---

- Sanitize user-submitted HTML (comments, WYSIWYG body fields) to remove XSS while keeping rich markup.
- Replace core's restrictive "Limit allowed HTML tags" filter with a spec-aware, standards-compliant one.
- Allow tables, inline `style` attributes, custom fonts, and images but still guarantee valid, safe output.
- Auto-correct malformed/unbalanced HTML pasted from Word or Google Docs into a text format.
- Enforce a strict but bullet-proof tag/attribute whitelist via HTML Purifier config directives.
- Provide a safe "Full HTML"-like format for semi-trusted authors without granting raw HTML.
- Strip event handlers, `javascript:` URIs, and other XSS vectors from stored markup.
- Configure allowed elements per format by pasting `HTML.Allowed` (and related) directives as YAML.
- Restrict link targets/protocols with `URI.*` directives to prevent phishing or open-redirect markup.
- Ensure output validates against a doctype for accessibility/compliance requirements.
- Normalize deprecated tags to modern, valid equivalents automatically.
- Harden a multi-author site where editors can paste arbitrary HTML.
- Point the serializer cache at a fast, writable path for high-traffic sites.
- Add defense-in-depth on top of an editor's client-side filtering (never trust the client alone).
- Filter markup coming in via REST/JSON:API text fields that use a purifier-enabled format.
- Tune allowed CSS properties with `CSS.AllowedProperties` for inline-style-heavy content.
- Give different formats different purifier rulesets (strict for anonymous, looser for staff).
- Convert legacy dirty HTML content to clean markup on the next save via the irreversible transform.
- Prevent clickjacking/markup-injection in fields rendered in emails or PDFs.
- Meet a security-review requirement for server-side HTML sanitization of all rich-text input.
