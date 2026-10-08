<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# GTranslate (g_translate) — agent index

Places a **Google Translate widget** as a Drupal block: a language switcher (flags and/or a
dropdown) that drives Google's on-the-fly page translation into ~100 languages. There is **no
server-side call to any Google API and no API key** — the block emits inline HTML/JS that loads
Google's client widget (`translate.google.com/translate_a/element.js`) in the visitor's browser
(default `onfly` method), or, in the paid Pro/Enterprise modes, rewrites URLs to a per-language
sub-directory / sub-domain. Nothing is translated or stored inside Drupal. The whole module is one
block plugin (`gtranslate_block`) plus a settings form.

Configure at `/admin/config/regional/g-translate` (route `g_translate.settings`, permission
`g_translate settings`), then place the **GTranslate** block (block category *Accessibility*) in a
region. Version **1.0.1**, core `^9.5 || ^10 || ^11 || ^12`, package **Multilingual**.

- Depends on: core `block`.
- Settings page / configure route: **yes** — `g_translate.settings`.
- Permissions: **one** — `g_translate settings` (Configure GTranslate).
- Drush: none. Plugin types defined: none. Config schema: none shipped (only `config/install`).
- Provides: block plugin `gtranslate_block`, theme hook `gtranslate`, JS library
  `g_translate/jquery-slider`.

**Not a substitute for Drupal's translation system.** The output is Google machine translation:
nothing is stored, reviewed or correctable; translated pages are not indexed (no multilingual SEO);
a third-party script sees every page a visitor reads (consent/GDPR); text in images/PDFs, form
validation and post-load content are missed. It is right for a small or monolingual site that just
wants a convenience switcher; use core translation for languages the organisation actually commits
to.

## What you'd do → where

- **Configure the widget (look, main language, which languages show, flag size, URL method) and
  place the block** → [configure/settings.md](configure/settings.md)

## Key facts (real machine names)

- Route: `g_translate.settings` → `/admin/config/regional/g-translate` (form
  `Drupal\g_translate\Form\GTranslateSettingsForm`, form id `g_translate_admin`,
  `_permission: 'g_translate settings'`).
- Menu link: `g_translate.settings`, parent `system.admin_config_regional`.
- Permission: `g_translate settings` (declared in `g_translate.permissions.yml`).
- Block plugin: `gtranslate_block` (`Plugin\Block\GTranslateBlock`, admin label *GTranslate*,
  category *Accessibility*), rendered uncacheable (`#cache['max-age'] = 0`).
- Config object: `g_translate.settings`. Keys: `gtranslate_look`
  (`flags_dropdown|flags|dropdown|dropdown_with_flags`), `gtranslate_main_lang` (language code),
  `gtranslate_flag_size` (`16|24|32`), `gtranslate_new_window` (0/1), `gtranslate_pro` (0/1),
  `gtranslate_enterprise` (0/1), `gtranslate_method` (`onfly|redirect`, derived), and one
  `gtranslate_<langcode>` per language (`0` hide / `1` list / `2` flag).
- Theme hook: `gtranslate` (variable `gtranslate_html`), template `templates/gtranslate.html.twig`.
- Library: `g_translate/jquery-slider` (`js/jquery-slider.js`, depends `core/jquery`; attached only
  for the `dropdown_with_flags` look).
- Legacy `.module` hooks: `hook_help` (`help.page.g_translate`), `hook_theme`, plus a stale
  D7-style `g_translate_permission()` (superseded by `g_translate.permissions.yml`).
