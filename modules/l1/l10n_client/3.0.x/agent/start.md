<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Localization Client (l10n_client) — agent index

**On-page interface (UI string) translation, with optional sharing to a localization server.**

- **Version:** 3.0.x (3.0.0-alpha3)
- **Core:** UI submodule declares `^8.8 || ^9 || ^10`; project ships a hidden `^11` stub
- **Main submodule:** `l10n_client_ui` (depends on core `locale`)
- **Configure route:** `l10n_client_ui.settings` → `/admin/config/regional/translate/client` (`administer languages`)
- **Permissions:** `use localization client ui` (on-page translate); `contribute translations to localization server` (contributor submodule)
- **Service:** `string_translator.l10n_client_ui` (`InterfaceTranslationRecorder`, priority 255) — records translations into locale
- **Submodules:** `l10n_client_ui` (on-page editor), `l10n_client_contributor` (share to a localization server via API key)
- **Security:** on-page translation gated by the translate permission, settings by `administer languages`; server contribution needs an API key (keep it secret). No security findings.
