<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# AdSense ads.txt — agent index

Submodule of **adsense** that serves an auto-generated `/ads.txt` from your AdSense publisher
ID. No config, permissions, blocks or schema of its own. Depends on `adsense`.

Key facts:
- Route `adsense_adstxt.page` → path `/ads.txt`, `_access: TRUE` (public),
  controller `Drupal\adsense_adstxt\Controller\AdsenseAdsTxtController::display()`.
- Output (when a publisher ID is set) is `text/plain`, a single line:
  `google.com, <publisher-id>, DIRECT, f08c47fec0942fa0`.
- Publisher ID comes from `Drupal\adsense\PublisherId::get()` =
  `adsense.settings:adsense_basic_id`; modules may alter it via `hook_adsense_alter()`.
- If no publisher ID is configured, `/ads.txt` returns **404**.
- `hook_requirements()` warns on the status report if a static `ads.txt` file already exists in
  the Drupal root (it would be served instead of this dynamic route — remove it).
- To configure the ID, use the main AdSense module (`adsense.settings:adsense_basic_id`); see the
  parent adsense docs' `agent/configure/settings.md`.

There is no separate solution doc — this index covers the whole submodule.
