<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Text Block provides a block whose text lives in **configuration** rather than in a content entity, so a snippet of markup can be exported, version-controlled and deployed with the rest of a site's config.

---

Drupal's own answer to "a block with some text in it" is a custom block content entity, and that is the right answer when editors own the text. It is the wrong answer when developers own it: block content is content, so it does not appear in a config export, does not travel through `drush config:import`, and has to be recreated by hand or shipped as default content on every environment. Text Block inverts that. The block is a plugin (`src/Plugin/Block`) whose body is stored in the block's own configuration and validated by `config/schema`, so it appears in `block.block.*` config, exports with `drush cex`, imports with `drush cim`, and arrives on staging and production the same way any other configuration does. The module is correspondingly tiny — a plugin, a schema file and tests, with core `block` as its only dependency and no routes, permissions or services of its own. Access is whatever the block layout grants; who may edit the text is `administer blocks`, since editing configuration is what it is.

---

- Ship a text snippet as configuration rather than content.
- Deploy block text through `drush config:import`.
- Version-control the wording of a site notice.
- Keep block text identical across environments.
- Review copy changes in a merge request.
- Avoid recreating custom blocks after a database refresh.
- Put a legal disclaimer under source control.
- Roll back block text with a config revert.
- Include block text in a site's config export.
- Manage a footer message from code.
- Give developers ownership of a fixed snippet.
- Prevent editors from changing a controlled message.
- Distribute the same block across a multi-site estate.
- Ship default text with an install profile.
- Audit where a phrase appears in configuration.
- Move a hardcoded template string into config.
- Provide a block that survives content re-imports.
- Keep the block layout and its text in one export.
