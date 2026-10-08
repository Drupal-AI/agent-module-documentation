<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Trim — agent index

Strips leading/trailing whitespace from every string value submitted through a **content
entity** form, running *before* validation. No settings form, no `configure` route, no
permissions, no plugins, no Drush, no config schema. Its only persistent footprint is a
**module weight of 1001** (set at install) so it validates first.

- **What it does, exactly which forms it touches, and its module-weight trick** →
  [api/mechanism.md](api/mechanism.md)
- **"How do I configure it?" (there is nothing to configure) + the weight it relies on** →
  [configure/no-config.md](configure/no-config.md)

Key facts:
- Acts only on forms whose form object's entity is a `ContentEntityType` (nodes, users,
  terms, media, comments, custom content entities). **Config forms are skipped by design.**
- Mechanism: `trim_form_alter()` `array_unshift`es `trim_form_values` onto `$form['#validate']`;
  that callback recursively `trim()`s every string in `$form_state->getValues()`.
- Only affects Form API submissions — **not** REST, migrations, or direct `$entity->save()`.
- Module weight `1001` lives in `core.extension` (`module.trim`), set by `trim_install()`.
