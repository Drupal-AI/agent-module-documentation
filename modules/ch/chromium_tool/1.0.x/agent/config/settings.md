<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Chromium Tool — configuration

## Install / enable

`composer require drupal/chromium_tool` (pulls `chrome-php/chrome ^1.14` and `drupal/ai ^1.1`),
then `drush en chromium_tool`. Core `image` and `ai` are hard dependencies. A working
**Chromium/Chrome binary must exist on the server** (in the DDEV/CI image or host). `chrome-php`
launches it headless with `noSandbox => TRUE`.

## Config object `chromium_tool.settings`

Schema: `config/schema/chromium_tool.schema.yml` (`type: config_object`). Keys:

- `chrome_executable_path` (string) — absolute path to the Chromium/Chrome binary. When empty,
  `ChromiumBrowserFactory::create()` constructs `new BrowserFactory()` with no path and the library
  auto-discovers a binary (`AutoDiscover`).
- `image_style` (string) — machine name of a Drupal image style applied to every screenshot; empty
  = none.

No `config/install/chromium_tool.settings.yml` ships, so both keys start unset until the form is
saved.

## Settings form

- Class `ChromeExecutablePathConfig` (`src/Form/`, extends `ConfigFormBase`), form id
  `chromium_tool_chrome_executable_path_config`.
- Route `chromium_tool.chrome_executable_path_config` →
  `/admin/config/system/chrome-executable-path-config`, `_title` "Chrome Executable Path",
  requirement **`administer site configuration`** (the module declares no permissions of its own;
  this is the core admin permission). Linked from `.info.yml` `configure:`.
- Fields: `chrome_executable_path` (required textfield, placeholder `/usr/bin/chromium`) and
  `image_style` (select of all `image_style` entities, "- None -" empty option).
- `validateForm()` rejects a path that is empty or does not start with `/`, resolves symlinks with
  `realpath()`, and errors unless the target `file_exists`, `is_file`, and `is_executable`. (A
  `@todo` notes Windows is unsupported.)

## Bundled image style

`config/install/image.style.chromium_tool_max_1500.yml` installs style **`chromium_tool_max_1500`**
("Chromium Tool Max 1500"): a single `image_scale` effect, width/height 1500, `upscale: false`. Use
it (or any style) via the `image_style` setting to cap screenshot size.
