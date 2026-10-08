<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Drush language negotiation (drush_language_negotiation) — agent index
**Forces the site default language for CLI/Drush runs via one core language-negotiation plugin.**

- **Version:** 1.0.x  •  **Package:** Drush  •  **Core:** ^8 || ^9 || ^10 || ^11  •  **License:** GPL-2.0-or-later
- **Requires:** core **Language** module — it provides the `@LanguageNegotiation` plugin type this plugin targets. (info.yml declares no `dependencies` key; the requirement is implicit.)
- **No composer.json, no config, no schema, no permissions, no routes, no services, no hooks, no Drush commands.** Despite the name it does **not** add any `drush` command — it only fixes language during CLI runs.

## What it actually is

- One plugin: `LanguageNegotiationDrush` (id **`language-drush`**, `LanguageNegotiationDrush::METHOD_ID`), in
  `src/Plugin/LanguageNegotiation/LanguageNegotiationDrush.php`, extending core
  `Drupal\language\LanguageNegotiationMethodBase`.
- Annotation `@LanguageNegotiation`: `weight = -99` (very high priority so it wins once enabled),
  name *"Drush Language Switching to correct language"*.
- Activated per-site on core's detection page, not on a settings form of the module's own.

## The plugin, its detection logic, and how to enable it

→ [plugins/drush.md](plugins/drush.md)
