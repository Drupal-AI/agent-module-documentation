<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# TMGMT LanguageLine (tmgmt_capita) — agent index

TMGMT translator plugin for **Capita LanguageLine Solutions** human translation. Version **8.x-1.1**. Core `^9.2 || ^10`. Depends on tmgmt, tmgmt_file.

`CapitaTranslator::doRequest` uses core `http_client` (Guzzle), Basic auth from translator username/password settings, staging/production URL by `environment` setting, JSON responses. **TLS verification left at Guzzle default (not disabled).** No callback routes; configured at `entity.tmgmt_translator.collection`.
