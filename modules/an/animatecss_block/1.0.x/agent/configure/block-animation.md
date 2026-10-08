<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Assign Animate.css animations to blocks

**Depends on:** `drupal:block`, `animatecss:animatecss_ui` (the AnimateCSS base project).
**Settings form:** `AnimateCssBlockSettingsForm` — `/admin/config/user-interface/animatecss/settings/block` (permission `administer animate css block`).
**Service:** `animatecss_block.helper` = `AnimateCssBlockHelperService` (`@animatecss.animate_manager`, `@config.factory`, `@database`, `@current_user`, `@datetime.time`).

## What it does
Extends the AnimateCSS module so each block in Block layout can be given an Animate.css effect (fade, bounce, zoom, slide, etc.) with timing/repeat options. The helper service registers selectors with the AnimateCSS `animate_manager` and looks up stored animation ids:

```php
$this->connection->query("SELECT [aid] FROM {animatecss} WHERE [selector] = :selector", [':selector' => $selector])
```
— a parameterized query (safe placeholder), not string concatenation.

## Usage
1. Enable AnimateCSS (`animatecss_ui`) and this module.
2. Configure defaults at the block settings route.
3. Edit a block in Structure » Block layout and pick the Animate.css effect and options for that block.

## Notes
Block-level settings integrate with the AnimateCSS admin at `admin/config/user-interface/animatecss`. The provided permission `administer animate css block` gates the module's own settings form.
