<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Logo per language adds a logo setting per installed language, so a multilingual site can show a translated or script-appropriate wordmark instead of one logo everywhere.

---

Drupal's site logo is a theme setting with no language dimension, which is a problem the moment a brand's mark contains words: an Arabic or Japanese site showing a Latin-script logo looks unfinished, and organisations with legally distinct names per market cannot use one image at all. This module extends the theme settings form with one logo field per installed language and swaps the logo according to the active language on render. It is genuinely tiny — `lpl.module`, an info file, two READMEs and a licence, with no `src/` directory, no routes, no permissions, no configuration page and no dependencies beyond core. Configuration happens where the site logo already lives, in theme settings, so there is nothing new for an administrator to learn. Note that its `.info.yml` declares no dependency on `language` or `content_translation`; on a single-language site it simply has one language to offer, which makes it harmless but pointless there. Core range is `^9 || ^10 || ^11`.

---

- Show a translated logo on each language of a site.
- Use a script-appropriate wordmark per language.
- Support legally distinct brand names per market.
- Keep one theme while varying the logo.
- Localise branding without a theme per language.
- Match the logo to a right-to-left layout.
- Give a bilingual institution both marks.
- Configure logos from the existing theme settings form.
- Avoid custom preprocess code for the same effect.
- Provide a fallback logo for untranslated languages.
- Roll out a rebrand language by language.
- Support a government site's language obligations.
- Match logo to language rather than to domain.
- Keep branding consistent with translated content.
- Add a language logo without a deployment.
- Reduce bespoke multilingual theming.
- Serve a regional logo variant.
- Onboard a new language with its own mark.
