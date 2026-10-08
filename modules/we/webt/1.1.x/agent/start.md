<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# WEB-T (webt) — agent index

Automated **content translation** via pluggable engines — a generic engine and an EU **eTranslation**
engine. Integrates `content_translation`, `locale`, `language`, `config_translation`. Config at
`webt.settings`. Version **1.1.1**. Core (per project).

The eTranslation engine (`EtranslationService`) calls `language-tools.ec.europa.eu` with `Basic` auth
credentials. Store credentials as secrets.
