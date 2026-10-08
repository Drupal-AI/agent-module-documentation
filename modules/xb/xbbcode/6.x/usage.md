<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Extensible BBCode (xbbcode) provides an extensible BBCode text filter, converting BBCode markup like [b], [url] and custom tags into HTML, with a standard-tags submodule.

---

BBCode is a markup syntax (used in forums) that authors write as [b]bold[/b] and the site converts to HTML. xbbcode provides an extensible BBCode filter with custom-tag support and a `xbbcode_standard` submodule of common tags. It is a text filter, and any filter converting user markup to HTML is security-relevant: the safety depends on the filter properly escaping user-supplied text and attribute values so that BBCode cannot be used to inject HTML/JavaScript (e.g. a [url] whose target is a javascript: URI, or text that breaks out of the generated HTML). xbbcode is a long-standing, mature module (version 6.x) and its standard tags are designed to output safe HTML, but two things warrant attention on any site: it should run in a text format whose overall filtering (allowed HTML, or the BBCode filter itself) prevents raw HTML/script from passing through alongside BBCode, and custom tags defined by administrators must themselves output safe HTML (a custom tag template that echoes user input unescaped would be an XSS vector — a custom-tag author is trusted with that). So confirm the text format's filter order (BBCode converting, with raw HTML restricted), and review any custom tags for safe output. Used with standard tags in a properly-configured format it is a safe way to offer simple markup.

---

- Offer BBCode markup.
- Convert [b]/[url] to HTML.
- Add a BBCode filter.
- Support custom BBCode tags.
- Use standard BBCode tags.
- Confirm the text format restricts raw HTML.
- Review custom tags for safe output.
- Escape user input in tags.
- Avoid javascript: URLs in [url].
- Configure filter order.
- Provide forum-style markup.
- Extend with custom tags.
- Ensure BBCode can't inject HTML.
- Use in a safe text format.
- Offer simple markup.
- Check attribute-value escaping.
- Enable when needed.
- Keep disabled otherwise.
- Restrict administration.
- Confirm on your site.
- Test before production.
- Review configuration.