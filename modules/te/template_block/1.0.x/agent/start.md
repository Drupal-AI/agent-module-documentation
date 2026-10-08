<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Template Block (template_block) — agent index

**Renders a block whose content is a theme Twig template selected by a suggestion name.**

- **Version:** 1.0.x  (info.yml `1.0.0-beta1`)
- **Core:** ^10 || ^11
- **Plugin:** Block `template_block` (`src/Plugin/Block/TemplateBlock.php`)
- **Theme hook:** `template_block` + suggestion `template_block__<suggestion>` (`.module`)
- **Config:** one block setting `template_suggestion`, validated `^[a-z0-9_]+$` in `blockValidate()`
- **Template to author:** `template-block--<suggestion>.html.twig` in the active theme

**Security:** No routes, permissions, or services. Placing/configuring the block requires the core *administer blocks* / Layout Builder permission. The editor input is a regex-restricted suggestion name (lowercase, digits, underscore) used only as a theme suggestion — it is not evaluated as Twig/PHP, so there is no SSTI surface; the actual Twig is authored in the theme by someone with filesystem access. No anonymous or mutating endpoints.
