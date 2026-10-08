<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Entity Word (entity_word) — agent index

**Downloads a node's title+body as a Word .docx via phpoffice/phpword, with admin-configured filename/margins/fonts.**

- **Version:** 3.1.x  •  core: `^8.8 || ^9 || ^10`  •  configure: `entity_word.settings`  •  depends on `token` + composer `phpoffice/phpword`  •  permission `access download word document`.
- **Route:** `/entity-word/{node_id}/word` → `EntityWordController::nodeWord` (perm `access download word document`). Settings: `/admin/config/system/entity_word` (`administer site configuration`).
- **Build:** loads node, PhpWord section (paper size/margins/fonts from config), title as heading, body via `Html::addHtml`, streams Word2007 as attachment. `Settings::setOutputEscapingEnabled(TRUE)`.
