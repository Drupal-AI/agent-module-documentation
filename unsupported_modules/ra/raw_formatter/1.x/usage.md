<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Raw Field Formatter renders a field value (expected to be JSON) through a theme template — but its only sanitization is a bypassable regex tag-strip and it outputs with |raw, making it a stored-XSS sink.

---

Raw Field Formatter is a field formatter that json_decodes a field's value, runs token replacement, and renders it through a theme template. Its name suggests outputting values raw, and that is the security problem, verified in review. Its only sanitization is a regular expression that strips HTML tags — preg_replace('/<[^>]*>/', '', ...) — and the template then outputs the result with the Twig raw filter (no auto-escaping). The regex only removes complete tags (it requires a closing '>'), so a malformed tag with no closing '>' survives; verified that <img src=x onerror=alert(1) (no closing bracket) passes through unchanged and reaches the |raw output, where a browser parses it as a tag and fires the onerror handler — stored XSS. Because this is a field formatter, the field value is authored content, so a content editor (or anyone who can set the field) can plant the payload. Do not use this formatter on any field whose value comes from users who should not inject HTML/JavaScript, until the sanitization is fixed (drop |raw so Twig escapes, or use Xss::filter()/check_markup() rather than a regex). See the local security notes for the verification.

---

- Render a field value raw.
- Format a JSON field value.
- Avoid this on untrusted fields.
- Understand the stored-XSS risk.
- Fix the |raw output first.
- Replace the regex sanitizer.
- Use Xss::filter or check_markup.
- Know malformed tags bypass the strip.
- Confirm who sets the field.
- Do not use on editor-set fields.
- Render JSON structure.
- Treat it as an XSS sink.
- Escape the output.
- Review the sanitization.
- Avoid raw HTML output.
- Patch before use.
- Enable when needed.
- Keep disabled otherwise.
- Restrict administration.
- Confirm on your site.
- Test before production.
- Review configuration.