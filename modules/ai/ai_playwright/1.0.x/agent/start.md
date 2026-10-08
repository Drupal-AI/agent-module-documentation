<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# AI Playwright (ai_playwright) — agent index

An **AI Agent tool** that opens a page of **this site** in a real headless browser
(**Playwright / Chromium**, run as a bundled Node script) and returns a full-page **screenshot**
(as a managed file id), the page **title**, the visible **text** and browser **console errors** —
so the Drupal Canvas AI assistant can see and verify what it builds. Package `AI`. Core `^11.2`.
PHP `>=8.3`. Version `1.0.0-alpha1`. License GPL-2.0-or-later.

- **Depends on**: `ai`, `ai_agents`, core `file`. Server needs **Node.js 18+ + Playwright +
  Chromium** (Composer `suggest: ext-node`).
- **Settings, config object, install/requirements, the internal base URL** →
  [config/settings.md](config/settings.md)
- **The Browser preview tool, the PlaywrightRunner service, and the Node capture script** →
  [tools/browser-preview.md](tools/browser-preview.md)

## What it provides (from source)

- **AI function-call plugin** `ai_playwright:browser_preview` (`src/Plugin/AiFunctionCall/BrowserPreview.php`),
  group `information_tools`, `module_dependencies: ['ai_playwright', 'file']`. Inputs: `url`
  (optional path or absolute URL), `task` (optional note, echoed back). Returns the opened URL,
  title, screenshot file id, console errors and visible text.
- **Service `ai_playwright.runner`** (`src/PlaywrightRunner.php`): resolves a safe target URL,
  shells out to the bundled Node script via **Symfony Process with an argv array**, saves the
  screenshot as a managed file, returns the capture.
- **Node script** `scripts/browser-capture.mjs`: launches headless Chromium, optionally visits a
  login link first, navigates to the URL, captures title/innerText/console errors + a full-page
  PNG, prints one JSON line.
- **Settings form** `SettingsForm` at route `ai_playwright.settings` — `/admin/config/ai/playwright`.
- **Permissions** (`ai_playwright.permissions.yml`): `use ai playwright` (run the tool),
  `administer ai playwright` (settings). Both `restrict access: true`.
- **Config**: object `ai_playwright.settings` with schema and install defaults.
- **Requirements hook** (`ai_playwright.install`): runtime check that the Node binary responds to
  `node --version`.

## Mechanism (short)

`BrowserPreview::execute()` checks permission (`use ai playwright` / `administer ai agents` /
`use Drupal Canvas AI`) then calls `PlaywrightRunner::capture($url)`. `resolveUrl()` sends a
relative path to the **configured internal base** (this site); an absolute URL is honoured **only**
when `allow_external_urls` is on (off by default), and only for http(s). For an authenticated
capture the runner mints a **one-time auto-login link** for the acting user (`user.reset.login`,
rewritten onto the internal base). The command `[node, script, target, tmp, login?]` runs via
`Symfony\Component\Process\Process` (argv array — no shell). The script prints JSON; the runner
persists the PNG under `<scheme>://ai_playwright/` and returns the file id + metadata. No
AI-generated script is written or executed — the capture script is static and bundled.
