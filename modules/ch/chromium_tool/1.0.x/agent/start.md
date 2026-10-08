<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Chromium Tool (chromium_tool) — agent index

Drives a **headless Chrome/Chromium** browser (via `chrome-php/chrome`) to take webpage
screenshots, and exposes that as an **AI function-call tool**. Package `AI Tools`. Depends on
`drupal/ai` (`ai:ai`) and core `image`. Composer requires `chrome-php/chrome ^1.14` +
`drupal/ai ^1.1`. Core `^10 || ^11`. License GPL-2.0-or-later. Version 1.0.2.

- **Config form, config object, schema, bundled image style, executable path** →
  [config/settings.md](config/settings.md)
- **The `ChromiumScreenshotter` / `ChromiumBrowserFactory` services** →
  [api/screenshotter.md](api/screenshotter.md)
- **The `screenshot_webpage` AI function call plugin** →
  [plugins/screenshot_webpage.md](plugins/screenshot_webpage.md)

## What it actually is

- Two services (`chromium_tool.services.yml`):
  - `chromium_tool.browser_factory` → `ChromiumBrowserFactory` (`src/Service/`): builds a
    `HeadlessChromium\BrowserFactory`, passing the configured `chrome_executable_path` (or none,
    letting the library auto-discover the binary).
  - `chromium_tool.screenshotter` → `ChromiumScreenshotter` (`src/Service/`): `screenshotAboveTheFold()`
    and `screenshotFullPage()`, each returns **PNG bytes**. Uses `noSandbox => TRUE`, a temp file,
    and cleans it up in `finally` + a destructor.
- One AI function-call plugin: `ScreenshotWebpage` (`src/Plugin/AiFunctionCall/`), id
  **`chromium_tool:screenshot_webpage`**, function name `chromium_tool_screenshot_webpage`, group
  `browsing_tools`. Context args: `url` (required), `mode` (`above_the_fold` | `full_page`),
  `viewport_width` (1920), `viewport_height` (1080), `wait_ms` (500). Returns a JSON payload with a
  base64 PNG.
- One settings form: `ChromeExecutablePathConfig` (`src/Form/`), route
  **`chromium_tool.chrome_executable_path_config`** at
  `/admin/config/system/chrome-executable-path-config`, permission `administer site configuration`.
- Config object `chromium_tool.settings` (`chrome_executable_path`, `image_style`); schema in
  `config/schema/chromium_tool.schema.yml`. Installs image style `chromium_tool_max_1500`
  (`config/install/`, a 1500×1500 non-upscaling `image_scale`).
- **No** custom permissions file, **no** Drush, **no** hooks, **no** entities, **no** submodules.

## Mechanism (from source)

- `ScreenshotWebpage::execute()` reads `url`, requires it to match `@^https?://@i`, then calls the
  screenshotter for the chosen `mode`. If `chromium_tool.settings:image_style` is set, it writes the
  PNG to a `temporary://` URI, runs `ImageStyle::createDerivative()`, swaps in the derivative bytes,
  and deletes both temp files; failures are logged and the original is returned. Output is
  `json_encode(['mime'=>'image/png','encoding'=>'base64','data'=>base64…, 'width','height','mode','url','image_style'])`.
- `screenshotFullPage()` navigates, `evaluate()`s a JS snippet to measure `scroll/offset/client`
  width+height, and screenshots with a `HeadlessChromium\Clip`. Both modes use
  `captureBeyondViewport => TRUE`.
- The browser binary is launched by the library via Symfony `Process` in **array/args mode** (not a
  shell string), and the target URL travels over the DevTools protocol (`$page->navigate()`), never
  the command line.
