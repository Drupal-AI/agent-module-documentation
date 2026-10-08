<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# TMGMT Translator for eTranslation — agent index

**TMGMT translator plugin for EU eTranslation** (European Commission machine translation). Depends on
`tmgmt`; requires PHP 8.0. Version **1.1.5**. Core `^9.2||^10||^11`.

**Note (vs `webt`/`tmgmt_webt`):** this uses Drupal's **standard `http_client`** (TLS verification **not**
disabled) — it does **not** share the `webt` disabled-TLS finding. Store eTranslation credentials as
secrets; content is sent to eTranslation (data-handling consideration). TMGMT governs the workflow.
