<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
VLSuite Landing ships a landing page content type with Layout Builder enabled and the suite's components already permitted on it.

---

This is the assembled result: a content type an editor can create and immediately build a page in, with the right layouts available, the right blocks permitted in each section, translation configured and menu settings enabled.

Its dependency list is effectively the suite's recommended component set — CTA, image, icon, local and remote video, text, headings menu, attachments — plus two Layout Builder modules that matter. `layout_builder_restrictions` is what stops the block list being every block on the site. **`layout_builder_at`** is Layout Builder Asymmetric Translation, and it is the one worth understanding: without it, translating a page built in Layout Builder is awkward, because core ties layout to the original language. On a multilingual site that dependency is doing real work.

The nested `vlsuite_landing_content_editor` submodule adds an editor role configuration for the content type.

Take this as the fastest route into the suite: enable it and you have a working landing page builder, then adjust rather than assemble.

---

- Create a landing page with Layout Builder enabled.
- Get a working page builder in one install.
- Restrict which blocks appear per section.
- Translate a Layout Builder page asymmetrically.
- Configure menu settings for landing pages.
- Use the suite's recommended component set.
- Give editors a content type ready to build in.
- Adjust an assembled setup rather than build one.
- Add landing pages to an existing site.
- Support multilingual landing pages.
- Configure an editor role for the content type.
- Reference media from a landing page.
- Add links and views to a landing page.
- Standardise landing pages across a site.
- Reduce project setup time.
- Audit which components landing pages permit.