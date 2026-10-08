<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# disable_language — agent start

Disables a configured language for the front end while keeping the language and its content
intact. "Disabled" is a **third-party setting on the `configurable_language` config entity**:
`third_party_settings.disable_language.disable: true` (config `language.entity.<langcode>`),
optionally with `redirect_language: <langcode>`. Disabled languages drop out of the language
switcher, `hreflang` head links, and Simple XML Sitemap; visitors are redirected to a fallback.
Requires core `language`. Config UI route: `disable_language.disable_language_settings`
(`/admin/config/regional/language/disable_language`). No Drush commands, no plugin types.

- **Disable/enable a language, module settings, config keys** → [configure/disable_language.md](configure/disable_language.md)
- **Read/set the disabled flag in PHP; the manager service** → [api/disable_language.md](api/disable_language.md)
- **Permissions (who still sees disabled languages)** → [permissions/disable_language.md](permissions/disable_language.md)
