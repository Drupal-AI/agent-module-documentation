<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Config2PHP exports configuration elements as PHP.

---

Config2PHP **exports configuration elements as PHP code** — turning a piece of Drupal config into a PHP
snippet you can paste into an install/update hook or module code, for programmatic configuration. It depends on
core Config and a service module, provides its own permissions, in the Development package.

Use it as a developer aid to script config. It is a developer tool. Security note: exported PHP may include
**config values that are secrets** (API keys, etc.) if present in the config — review and redact before pasting/
committing (don't hard-code secrets into code); the export UI is gated by its permission (keep to developers).
It has no content or access role beyond its permission. Export config to PHP.

---

- Export config as PHP code.
- Generate config snippets for hooks.
- Aid programmatic config.
- Depend on core Config.
- Provide its own permissions.
- Serve developers.
- KNOW exported PHP may include secret config values.
- Review/redact before pasting/committing.
- Not hard-code secrets into code.
- Gate the export UI to developers.
- Have no content/access role beyond permission.
- Export config to PHP.
- Handle config export.
- Export config.
- Configure the export.
- Generate PHP.
- Handle the export.
- Script config.
- Redact secrets.
- Provide config-to-PHP export.
