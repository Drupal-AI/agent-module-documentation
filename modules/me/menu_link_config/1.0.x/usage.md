<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Menu Link Config makes custom menu links **configuration entities** (`menu_link_config`), so a small, structural navigation can live in `config/sync` and deploy with `drush cim` instead of being recreated by hand on every environment.

---

Drupal's menu links come in two kinds and neither is deployable the way site builders often want. Links defined by modules in `*.links.menu.yml` are code, fixed at release time. Links created through the UI are `menu_link_content` content entities, which do not appear in a configuration export and so must be recreated, exported as default content, or migrated. Since a site's primary navigation is structural rather than editorial on many projects, that is a recurring source of environment drift. This module adds a third option: a `menu_link_config` config entity, created from the normal menu UI through an "Add config link" action on each menu's edit page, that exports and imports like any other configuration. Under the hood a deriver turns every entity into a core menu link plugin (`menu_link_config:{id}`, extending `MenuLinkBase`), and the entity's `postSave()`/`preDelete()` keep the core menu tree in sync so links render through core's normal access-aware tree. Config translation is supported through a dedicated mapper when the `config_translation` module is installed. Two caveats worth stating: the project has only ever shipped alphas (newest release `8.x-1.0-alpha9`), and links-as-configuration are translated through config translation rather than core content translation — check the multilingual story before adopting on a translated site.

---

- Deploy a small menu structure as configuration with `drush cim`.
- Keep navigation identical across dev, stage, and production.
- Review a menu change in a merge request / code review.
- Stop recreating menu links after a database refresh.
- Put the primary navigation under version control.
- Ship a menu with an install profile or distribution.
- Export a single menu link from the single-item config export UI.
- Roll a navigation change back with config revert.
- Give developers ownership of structural links.
- Avoid default-content modules just for menus.
- Add a config link straight from a menu's edit page.
- Keep a footer or utility menu in code.
- Reduce environment drift in navigation.
- Standardise menus across a multisite.
- Deploy a new section's menu link alongside its feature code.
- Audit navigation changes through git history.
- Mix config links with existing content and module links in one menu.
- Prepare menu structure before the content it points to exists.
- Keep menu structure out of content exports.
- Replace core's Custom Menu Links for structural menus.
- Translate a config menu link via the Config Translation module.
- Point a config link at an internal route, an external URL, `<front>`, or `<nolink>`.
