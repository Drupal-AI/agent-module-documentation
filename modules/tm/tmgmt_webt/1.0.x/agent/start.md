<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# WEB-T Translator (tmgmt_webt) — agent index

**TMGMT translator plugin for WEB-T** / EU **eTranslation**. Depends on `tmgmt`, `webt` (reuses webt's
`EtranslationService`). Version **1.0.0**. Core (per project).

`WebtTranslator` calls `webt.translation_service.etranslation` (`EtranslationService`), which sends
eTranslation credentials + content to `language-tools.ec.europa.eu`. Store credentials as secrets.
