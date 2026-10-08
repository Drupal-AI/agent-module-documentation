<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# AI Playwright — the Browser preview tool, runner, and capture script

## Tool — `ai_playwright:browser_preview` (BrowserPreview)

`src/Plugin/AiFunctionCall/BrowserPreview.php`. `#[FunctionCall]`, function name
`ai_playwright_browser_preview`, label *"Browser preview (Playwright)"*, group `information_tools`,
`module_dependencies: ['ai_playwright', 'file']`.

- **Inputs** (both optional): `url` — a path on this site (e.g. `/` or `/about`), empty = front
  page; `task` — a note of what to check, echoed back for context.
- **Permission gate** in `execute()`: throws unless the current user has one of
  `use ai playwright`, `administer ai agents`, or `use Drupal Canvas AI`.
- **Output** (`getReadableOutput()`): lines with `Opened: <url>`, optional `Looking for: <task>`,
  `Title: …`, either `Screenshot saved as file id N - call describe_image with this id to see the
  page.` or a save-failure note, `Console errors: …`, and `Visible text:` + the captured text.

Add the tool to a Canvas AI agent (or any AI Assistance agent). Typical flow: build a page → call
`browser_preview` → pass the returned file id to `describe_image` to "see" it → refine.

## Service — `PlaywrightRunner` (`src/PlaywrightRunner.php`)

Service id `ai_playwright.runner`. Args: `@config.factory`, `@logger.factory`,
`@extension.list.module`, `@file_system`, `@file.repository`, `@entity_type.manager`,
`@current_user`, `@datetime.time`.

`capture(string $url, bool $authenticated = TRUE): array` — the whole integration:

1. **`resolveUrl($url)`** — the target:
   - `''` → `<internal_base>/` (front page).
   - a relative path → `<internal_base>/<ltrim($url,'/')>` (always this site).
   - an absolute URL (matches a `scheme://` regex) → accepted **only** if scheme is `http`/`https`
     with a host **and** `allow_external_urls` is on; otherwise it logs a warning and returns NULL
     (capture refused). Non-http(s) schemes (`file://`, `gopher://`, …) are always rejected.
2. **`scriptPath()`** — absolute path to `scripts/browser-capture.mjs` (NULL if missing).
3. Builds the temp PNG path in the system temp dir from a server-side hash (not from input).
4. Builds the command **argv array** `[$this->nodeBinary(), $script, $target, $tmp]`; for an
   authenticated capture appends the login URL from `currentUserLoginUrl()`.
5. Runs it via `Symfony\Component\Process\Process($command, $cwd, ...)` with the capture timeout —
   **an argv array, so no shell is invoked and no argument is interpolated into a shell string**.
   `$cwd` is the module dir so Node resolves the bundled Playwright.
6. `Json::decode()` the stdout; on failure/`ok != true` returns a friendly error.
7. **`saveScreenshot()`** — reads the PNG bytes, deletes the temp file, writes a managed file to
   `<screenshot_scheme>://ai_playwright/browser_<hash>.png` (`FileExists::Rename`) and returns the
   file id. The filename is a hash of the bytes — no input reaches the path.

Helpers: `currentUserLoginUrl()` mints a **one-time auto-login** link for the *current* user only
(`Url::fromRoute('user.reset.login', [uid, timestamp, hash => user_pass_rehash(...)])`) and keeps
only its path+query, rewritten onto the internal base (never an external host); anonymous → NULL.
`internalBase()`, `nodeBinary()`, `timeout()` (>0 else 90), `allowExternalUrls()` read config.

## Node script — `scripts/browser-capture.mjs`

`node browser-capture.mjs <url> <output-png-path> [login-url]`. Launches headless Chromium
(`chromium.launch({ headless: true })`), new context with `ignoreHTTPSErrors: true`. If a login URL
is given it visits it first (establish a session). Then `page.goto(url, { waitUntil: 'networkidle',
timeout: 30000 })`, grabs `page.title()`, `document.body.innerText` (whitespace-collapsed, sliced
to 4000 chars), console `error` messages and `pageerror` (each sliced to 200 chars, max 10), and a
full-page screenshot. Prints one JSON line: `{ ok, title, text, consoleErrors, screenshot }` or
`{ ok: false, error }`. It makes **no LLM calls and no network calls beyond the requested URL and
the optional login link**; the script is static and bundled — nothing AI-generated is written or
executed.

> Note: the module's `playwright.config.ts` (with `--no-sandbox`, `--disable-web-security`, etc.)
> configures the **Cucumber/webship-js BDD test suite**, not the runtime capture — the runtime
> script uses default Chromium launch args.

## Security posture (for operators)

- Gate the tool on `use ai playwright` (restricted). It opens an authenticated browser **as the
  acting user**, so it sees exactly what that user can — treat granting it as granting the agent
  authenticated browser access.
- Off-site URLs are off by default; the tool then only opens same-site paths resolved against the
  internal base. Enable `allow_external_urls` only when you accept the agent navigating arbitrary
  http(s) URLs from the server.
- All arguments pass to Node as an argv array via Symfony Process — no shell interpolation.
