<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Google cloud batch translation (tmgmt_google_batch) — agent index

TMGMT **machine-translation** plugin using the **Google Cloud Translation** batch API. Version **8.x-1.0**. Core `^8 || ^9 || ^10`. Depends on tmgmt.

`GoogleBatchTranslator` sends text to a configurable Google endpoint (`url` setting), API key from translator settings passed as the `key` query param; validates the key at config time. Default Guzzle TLS. No callback routes; configured at `entity.tmgmt_translator.collection`.
