<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
htmLawed provides a single text-format input filter (`filter_htmlawed`) that runs content through the bundled htmLawed PHP library to restrict, correct, and purify HTML according to admin-defined policy and for security.

---

The module wraps the standalone htmLawed library (shipped in `htmLawed/htmLawed.php`, library version 1.2.15) as a Drupal filter plugin of type `TYPE_HTML_RESTRICTOR`. You enable and configure it per text format at *Administration → Configuration → Content authoring → Text formats and editors* (`admin/config/content/formats`); it has no standalone settings page (`configure` is null). Each format that uses the filter gets its own four settings: **Config.** (comma-separated quoted key-value pairs forming htmLawed's `$config` array, e.g. `'safe' => 1, 'elements' => 'a, em, strong', 'deny_attribute' => 'id, style'`), **Spec.** (htmLawed's optional per-element `$spec` string that constrains attribute values), and **Short tip** / **Long tip** text shown to authors. The default config allows only `a, em, strong, cite, code, ol, ul, li, dl, dt, dd, br, p` and denies the `id` and `style` attributes with `safe=1`. htmLawed also balances and properly nests tags, corrects broken markup, and can restrict URL protocols, so core's "Limit allowed HTML tags" and "Correct faulty and chopped off HTML" filters can be dropped in its favour. Special pseudo-parameters are supported: `'comment' => 2` preserves the Drupal teaser `<!--break-->` marker and `'save_php' => 1` protects `<?php … ?>` blocks from being mangled. The **Config.** string is evaluated as PHP to build the array. htmLawed does not turn URLs into links or convert newlines into `<br>`/`<p>` — pair it with other filters for that, and generally run it last in the filter order.

---

- Restrict which HTML tags and attributes are allowed in a text format, as a more configurable alternative to core's "Limit allowed HTML tags" filter.
- Automatically balance and correctly nest malformed HTML that editors paste in (e.g. unclosed `<div>`s).
- Strip scriptable attributes such as `onclick`, `onerror`, and `style` to defend against stored XSS.
- Allow a curated tag whitelist for a comment or forum text format while denying everything else.
- Set `'safe' => 1` to apply htmLawed's built-in anti-XSS ruleset on top of your element list.
- Deny specific attributes globally with `'deny_attribute' => 'id, style, class'`.
- Limit permitted link protocols (e.g. only `http, https, mailto`) via the `schemes` config parameter.
- Constrain an attribute's allowed values per element with the **Spec.** parameter (e.g. table `border` must be 0–2).
- Preserve the Drupal teaser break marker by adding `'comment' => 2` to the config.
- Keep `<?php … ?>` code snippets intact in content by adding `'save_php' => 1`.
- Replace core's "Correct faulty and chopped off HTML" filter with htmLawed's more thorough correction.
- Enforce a house HTML style (e.g. force lowercase tag names, transform deprecated tags) via htmLawed config flags.
- Apply different HTML policies to different roles by giving each text format its own htmLawed settings.
- Show authors a short and a long "allowed tags" tip beneath the editor via the Short/Long tip fields.
- Clean up HTML imported from external feeds or migrations before it is stored.
- Remove disallowed embedded content (iframes, objects) from user submissions.
- Normalise entity/character encoding of markup so stored HTML is standards-compliant.
- Tighten a WYSIWYG format so pasted Word/Google-Docs markup is reduced to a safe subset.
- Run htmLawed as the final filter so markup produced by earlier filters is still validated.
- Provide a security-hardened "Full HTML"-style format that still forbids scripts.
- Audit and document a site's exact allowed-HTML policy in one place (the Config. string).
- Load the htmLawed library through the contrib Libraries module instead of the bundled copy when a newer version is required.
- Constrain uploaded rich-text field values to a minimal safe tag set across many content types.
