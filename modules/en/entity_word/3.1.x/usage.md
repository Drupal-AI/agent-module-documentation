<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Entity Word lets users download a node's content as a Microsoft Word document. Given a node ID it builds a `.docx` (Word2007) file from the node's title and body using the `phpoffice/phpword` library, applying admin-configured page size, margins, font family/color/size, and a token-based filename.
It is aimed at sites that want an editorial or reader-facing "download as Word" option on selected content, embedding a link like `/entity-word/{node_id}/word` in the node template.
---
Install with `composer require drupal/entity_word` (which needs `phpoffice/phpword`) and `drush en entity_word`; it depends on `token`. Configure document defaults at `/admin/config/system/entity_word` (permission `administer site configuration`): filename pattern (tokens), paper size, margins, and font styling. Grant the `access download word document` permission to roles that may download, and add a link to `/entity-word/{node_id}/word` in your node twig.
The download route requires the `access download word document` permission; the controller (`EntityWordController::nodeWord`) loads the node by ID and outputs its title and body. `Settings::setOutputEscapingEnabled(TRUE)` is set for the generated document.
---
- Install: `composer require drupal/entity_word && drush en entity_word -y` (needs phpoffice/phpword + token).
- Configure defaults at `/admin/config/system/entity_word` (perm `administer site configuration`).
- Set a token-based filename pattern for downloads.
- Set paper size, margins and font family/color/size.
- Grant `access download word document` to roles that may export.
- Link `/entity-word/{node_id}/word` from a node twig template.
- Visiting that URL downloads the node's title + body as a .docx.
- Body HTML is converted into the Word document via PhpWord's HTML reader.
- Output escaping is enabled for the generated document.
- Use for reader-facing "download as Word" buttons.
- Use for editorial export of article content.
- Filename tokens are resolved with the current language.
- Only node title and body are exported (not arbitrary fields).
