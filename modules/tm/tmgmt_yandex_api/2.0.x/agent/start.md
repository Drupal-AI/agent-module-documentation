<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Yandex Translator (tmgmt_yandex_api) — agent index

TMGMT **machine-translation** plugin using the **Yandex Translate** API. Version **2.0.0**. Core `^8.8 || ^9.0 || ^10.0`. Depends on tmgmt.

`YandexTranslator::doRequest` (core http_client) calls `getLangs`/`translate`, API key from settings passed as `key` query param; base URL overridable via `url` setting. Default Guzzle TLS. No callback routes; configured at `entity.tmgmt_translator.collection`.
