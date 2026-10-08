<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Chromium Tool — `screenshot_webpage` AI function call

Class `ScreenshotWebpage` (`src/Plugin/AiFunctionCall/ScreenshotWebpage.php`), extends
`Drupal\ai\Base\FunctionCallBase`, implements `ExecutableFunctionCallInterface`. Registered via the
`#[FunctionCall]` attribute from `drupal/ai`.

## Identity

- `id`: `chromium_tool:screenshot_webpage`
- `function_name`: `chromium_tool_screenshot_webpage`
- `name`: "Screenshot a webpage with Chromium"
- `group`: `browsing_tools`
- description: "Takes a screenshot of a URL either above-the-fold (viewport) or full page."

## Context arguments (`context_definitions`)

- `url` (string, **required**) — absolute URL to screenshot.
- `mode` (string, optional) — `above_the_fold` or `full_page` (default `above_the_fold`).
- `viewport_width` (integer, optional, default 1920).
- `viewport_height` (integer, optional, default 1080).
- `wait_ms` (integer, optional; code defaults to 500 when null) — extra wait after navigation.

## `execute()` flow

1. Reads the five context values (with the defaults above).
2. Validates `url` against `@^https?://@i`; throws `\InvalidArgumentException` if it is not an
   absolute http(s) URL.
3. `match($mode)`: `full_page` → `screenshotter->screenshotFullPage()`, else
   `screenshotAboveTheFold()`.
4. If `chromium_tool.settings:image_style` is non-empty, loads that `ImageStyle`, writes the PNG to
   `temporary://` (via `file_system->saveData(..., FileExists::Replace)`), calls
   `createDerivative()` to the style's `buildUri()` destination, swaps in the derivative bytes if
   produced, then deletes both temp files. Any `\Throwable` is logged to the `chromium_tool` channel
   and the original bytes are kept.
5. `setOutput()` with `json_encode(['mime'=>'image/png','encoding'=>'base64','data'=>base64_encode($binary),'width'=>$width,'height'=> full_page ? null : $height,'mode'=>$mode,'url'=>$url,'image_style'=> id|null], JSON_UNESCAPED_SLASHES)`.

## Dependencies injected (`create()`)

`ai.context_definition_normalizer`, `plugin.manager.ai_data_type_converter` (base), plus
`chromium_tool.screenshotter`, `config.factory`, `file_system`, `logger.factory`.

## Operating it

Enable the tool for an AI agent/assistant that supports `drupal/ai` function calling, ensure a valid
`chrome_executable_path` (or an auto-discoverable binary), and the agent can call
`chromium_tool_screenshot_webpage` with a `url`. Access is governed by whoever/whatever can invoke
the AI agent's tools — the plugin defines no route or permission of its own.
