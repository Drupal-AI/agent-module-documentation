<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Lilt Translator (tmgmt_lilt) — agent index

**TMGMT translator plugin for the Lilt** (AI-assisted) translation service. Depends on `tmgmt`,
`tmgmt_file`. Version **8.x-1.7**. Core `^8.8||^9||^10||^11`.

**Security:** store the Lilt API key as a **secret** (not exported config); content is sent to Lilt
(data-handling). Uses standard HTTP (TLS not disabled). TMGMT governs the workflow.
