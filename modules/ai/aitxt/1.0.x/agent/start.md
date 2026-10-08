<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# ai.txt (aitxt) — agent index

Dynamically generates an `ai.txt` file (directives telling AI crawlers/scrapers how they may use
your content — the robots.txt-analogous convention from Spawning) and lets an administrator edit it
per-site from the web UI. A fork of the RobotsTxt module. Version **1.0.0**, core `^10.1 || ^11`,
no module or Composer dependencies beyond core.

## What it provides
- **Route `aitxt.content`** — path `/ai.txt`, `_access: TRUE` (public), serves the configured file as
  `text/plain` (`\Drupal\aitxt\Controller\AiTxtController::content`).
- **Route/form `aitxt.admin_settings_form`** — `/admin/config/search/aitxt`, gated by permission
  `administer aitxt` (`\Drupal\aitxt\Form\AiTxtAdminSettingsForm`, a `ConfigFormBase`). This is also
  the `configure` route (admin menu link under Configuration › Search and metadata).
- **Config object `aitxt.settings`** — keys `content`, `manual`, `allow_text`, `allow_images`,
  `allow_audio`, `allow_video`, `allow_code` (schema in `config/schema/aitxt.schema.yml`).
- **Permission** `administer aitxt` (`aitxt.permissions.yml`).
- **Hook `hook_aitxt()`** — other modules append extra lines to the served file (`aitxt.api.php`).
- **`\Drupal\aitxt\Extensions`** — constants (TEXT/IMAGES/AUDIO/VIDEO/CODE) of file-extension globs used
  to build the generated file.
- No entities, no plugin types, no services of its own, no Drush commands.

## Install-time behavior (`aitxt.install`)
- `hook_install()` seeds `aitxt.settings.content` from `/sites/default/default.ai.txt`, else the module's
  bundled `ai.txt`, else empty.
- `hook_requirements('runtime')`: errors without Clean URLs; warns if a real `ai.txt` file exists in the
  webroot (the file on disk wins over the route).

## Solution docs
- [config/settings.md](config/settings.md) — the settings form, config keys, generate-vs-manual modes,
  the served route, and cache invalidation.
- [api/hook_aitxt.md](api/hook_aitxt.md) — appending lines from another module via `hook_aitxt()`.
