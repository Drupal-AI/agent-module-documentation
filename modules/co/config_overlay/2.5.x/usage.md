<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Config Overlay manages exported configuration as an overlay of the exported files with module-provided configuration.

---

Config Overlay changes how configuration is exported — managing the exported config as an *overlay* over
the configuration that modules provide by default, so the config export only contains what actually differs
from the modules' shipped defaults. This produces a smaller, cleaner config export (only your changes),
easing config management and upgrades. It is in the Config package.

Use it to keep a lean, difference-only config export. It is a configuration-management/developer feature
affecting import/export; it changes how config is stored/exported, not runtime access, and it has no
access-control role. Enable and use with the standard config workflow.

---

- Export config as an overlay.
- Store only config that differs from defaults.
- Produce a smaller config export.
- Ease config management/upgrades.
- Overlay module-provided defaults.
- Keep a difference-only export.
- Change export, not runtime access.
- Have no access-control role.
- Use the standard config workflow.
- Clean up the config export.
- Reduce config noise.
- Manage config as overlay.
- Handle config export.
- Export differences only.
- Simplify config.
- Overlay defaults.
- Manage configuration.
- Export lean config.
- Handle config overlay.
- Streamline config export.
