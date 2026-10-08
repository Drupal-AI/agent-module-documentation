<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Lingotek Copy Target - agent index

Copies **downloaded Lingotek translations from one locale to another** (version **1.1.0**, core `^8.8||^9||^10`; depends on `lingotek`).

- Implements `hook_lingotek_content/config_entity_translation_presave` and saves the same data into mapped target locales via Lingotek's own services. No external HTTP of its own.
- Routes `lingotek_copy_target.config` / `...config_targets_delete` gated by `configure lingotek_copy_target`.
- Category: Multilingual / Translation.
