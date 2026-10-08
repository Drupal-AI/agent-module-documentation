<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Config Entity Cloner adds the ability to clone configuration entity type configuration, duplicating config entities.

---

Config Entity Cloner adds a clone action for configuration entities — duplicating a config entity
(a view, a content type, an image style, a field config, etc.) as a starting point for a new one,
instead of recreating it from scratch. It provides its own permissions and Drush commands and is in the
Development package.

Use it during site building to speed up creating similar configuration by cloning an existing one and
adjusting. It is a developer/site-building tool that creates configuration; because cloning creates new
config entities, restrict the permission to trusted site builders and review clones (a cloned config
entity may reference or duplicate settings that need adjusting). It operates in the config layer with no
runtime access role.

---

- Clone configuration entities.
- Duplicate a view or content type.
- Copy an image style config.
- Start new config from an existing one.
- Provide Drush commands.
- Provide its own permissions.
- Speed up site building.
- Avoid recreating config from scratch.
- Restrict cloning to trusted builders.
- Review cloned configuration.
- Clone field configs.
- Operate in the config layer.
- Have no runtime access role.
- Adjust cloned settings.
- Duplicate config entity types.
- Create similar configuration fast.
- Clone and modify.
- Support development workflows.
- Copy configuration.
- Bootstrap new config.
