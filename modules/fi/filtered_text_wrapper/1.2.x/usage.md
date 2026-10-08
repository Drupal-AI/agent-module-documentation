<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Filtered Text Wrapper adds a text-format filter that wraps the processed output of a WYSIWYG field in a configurable prefix and suffix (for example a `<div class="wysiwyg">` … `</div>` wrapper).

---

Themes often need editor content wrapped in a container element so scoped CSS can target it, but editors should not have to type wrapper markup by hand. This module provides a `wrapper` filter plugin (`WrappingFilter`) that concatenates a configured `prefix` before, and `suffix` after, the field's already-filtered HTML. Prefix and suffix default to `<div class="wysiwyg">` and `</div>` and are edited per text format on the filter settings form.

The filter is `TYPE_TRANSFORM_REVERSIBLE` and its `process()` simply returns `prefix . $text . $suffix` — the prefix/suffix strings are emitted verbatim, not passed through any XSS filtering. This is safe in normal use because those strings are static configuration that only users with the `administer filters` permission can set (a restricted, trusted-admin capability); there is no path for an untrusted commenter/author to influence them. Note that because the wrapper markup is not re-sanitised, an administrator can place arbitrary markup (including markup the format's "Limit allowed HTML tags" filter would otherwise strip) in the prefix/suffix — so order this filter after your HTML-restriction filter and keep the wrapper to simple container tags. The user-entered body text itself still passes through the format's other filters normally.

Setup: edit a text format at Administration > Configuration > Content authoring > Text formats and editors, enable "Wrapper", set the prefix/suffix, and order it (usually last) in the filter processing order.

---

- Wrap all WYSIWYG output of a text format in a container `<div>` for scoped CSS
- Add a class hook (e.g. `class="wysiwyg"`) around editor content site-wide
- Give a "Full HTML" format a different wrapper than a "Basic HTML" format
- Wrap content in a `<section>` or `<article>` element for semantic markup
- Add a leading/trailing block (banner, ad slot markup) around every formatted field
- Namespace editor styles by wrapping content so CSS can target `.wysiwyg p`
- Apply a print/email wrapper on a format used for outgoing mail bodies
- Configure prefix and suffix independently per text format
- Reset to the default `<div class="wysiwyg">` wrapper
- Disable wrapping for a format by turning the filter off
- Combine with an allowed-HTML filter (ordered before it) to keep body sanitisation
- Provide a consistent DOM container so JS can scope behaviours to editor content
- Wrap RTL/LTR containers around content for a multilingual theme
- Use as a lightweight alternative to a custom theme template for field wrapping
- Order the filter last so the wrapper is the outermost element
