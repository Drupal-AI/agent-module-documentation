<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Chromium Tool — screenshotter & browser-factory services

Two services in `chromium_tool.services.yml`; call them from custom code to get PNG bytes.

## `chromium_tool.browser_factory` — `ChromiumBrowserFactory`

`src/Service/ChromiumBrowserFactory.php`. Constructor arg `@config.factory`.

- `create(): HeadlessChromium\BrowserFactory` — reads `chromium_tool.settings:chrome_executable_path`.
  If empty, returns `new BrowserFactory()` (library auto-discovers the binary); otherwise
  `new BrowserFactory($executablePath)`.

## `chromium_tool.screenshotter` — `ChromiumScreenshotter`

`src/Service/ChromiumScreenshotter.php`. Constructor arg `@chromium_tool.browser_factory`. `final`.
Both methods return **raw PNG bytes** (string) and throw `\RuntimeException` if the temp file cannot
be read.

- `screenshotAboveTheFold(string $url, int $width = 1920, int $height = 1080, int $waitMs = 500): string`
  — creates a browser with `noSandbox => TRUE` and `windowSize => [$width,$height]`, `createPage()`,
  `navigate($url)->waitForNavigation()`, optional `usleep($waitMs*1000)`, then
  `screenshot(['format'=>'png','captureBeyondViewport'=>TRUE])`.
- `screenshotFullPage(string $url, int $width = 1920, int $initHeight = 1080, int $waitMs = 500): string`
  — same setup, then `evaluate()`s a JS snippet returning the document's max
  `scroll/offset/client` width and height, builds a `HeadlessChromium\Clip(0,0,$fullWidth,$fullHeight)`,
  and screenshots PNG with `captureBeyondViewport => TRUE` + that clip.

### Temp-file handling

Each method writes the image to `tempnam(sys_get_temp_dir(),'shot_').'.png'`, records it in
`$lastTempFile`, reads it back with `file_get_contents()`, and in a `finally` block calls
`$browser->close()` and `@unlink()`s the temp file (clearing `$lastTempFile` to avoid double
cleanup). `__destruct()` unlinks any stray `$lastTempFile` as a safety net.

### Notes for callers

- The service methods themselves do **not** validate the URL scheme — the caller is responsible.
  The `ScreenshotWebpage` plugin enforces `http(s)` before calling; direct callers should validate
  the URL they pass (host/scheme) themselves.
- `noSandbox => TRUE` is always set (needed for typical container/root environments).
