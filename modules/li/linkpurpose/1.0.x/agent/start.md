<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Link Purpose Icons — agent index

Adds icons + screen-reader hints to links whose behavior differs from a normal link: external,
new-window, download, document, app, mail (`mailto:`), tel (`tel:`). It's a config-driven
wrapper around a bundled JS library. One config object `linkpurpose.settings`; no plugins,
services or entities. `linkpurpose_page_attachments()` pushes config into
`drupalSettings.linkpurpose` and attaches the library on every **non-admin** route.

- **All settings keys (7 purposes + global options), how config maps to `drupalSettings`, and
  how to change them** → [configure/settings.md](configure/settings.md)

Key facts:
- Config object `linkpurpose.settings`. Form route `linkpurpose.settings` →
  `/admin/config/user-interface/linkpurpose` (permission `administer linkpurpose`).
- Seven boolean "purpose" toggles: `purposeExternal`, `purposeDownload`, `purposeDocument`,
  `purposeApp`, `purposeMail`, `purposeTel`, `purposeNewWindow` (all default `true`).
- Each purpose has a `...Message` (screen-reader text), `...Selector`, `...Class`,
  `...IconType/IconPosition/IconClasses/IconWrapperClass`.
- Global keys: `domain` (extra internal domains), `roots`, `shadowComponents`, `ignore`
  (default `#toolbar-administration a`), `hideIcon`, `noRunIfPresent`, `noRunIfAbsent`,
  `noIconOnImages`, `themePreprocess`, `noAggregate`.
- Special external behaviors: `purposeExternalNewWindow`, `purposeExternalNoReferrer`.
- Never runs on admin routes; only non-empty config values are sent to the browser.
