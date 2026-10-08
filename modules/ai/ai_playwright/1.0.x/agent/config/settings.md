<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# AI Playwright — settings, config, and server setup

## Install & enable

```bash
composer require drupal/ai_playwright
drush en ai_playwright -y
```

Requires `ai`, `ai_agents` and core `file`. **On the server** you must also install the browser
runtime (Composer records it as `suggest: ext-node`):

```bash
cd web/modules/contrib/ai_playwright
npm install playwright && npx playwright install --with-deps chromium
```

Node is run from the module directory (`cwd`), so it resolves the Playwright installed there.

## Settings form

`Drupal\ai_playwright\Form\SettingsForm` (route `ai_playwright.settings`, path
**`/admin/config/ai/playwright`**, permission **`administer ai playwright`**; menu link under
*Configuration → AI*). Form id `ai_playwright_settings`. Fields:

| Field | Config key | Notes |
|---|---|---|
| Internal base URL | `internal_base` | Required. The base the browser uses to reach the site from the server (usually loopback). Validated to a full http(s) URL with a host; saved with trailing slash stripped. |
| Node.js binary | `node_binary` | Required. Bare `node` (resolved from PATH) or an absolute path. |
| Capture timeout (seconds) | `timeout` | `#type => number`, min 5, max 300, default 90. |
| Allow opening absolute off-site URLs | `allow_external_urls` | Checkbox, **off by default**. Off = tool only ever opens paths on this site. |

A **Test browser capture** submit (`::testBrowser`, `#limit_validation_errors => []`) runs one
capture of `/` with the *saved* settings and reports the opened URL, title and console-error count,
or the error.

## Config object `ai_playwright.settings`

Schema `config/schema/ai_playwright.schema.yml`; install defaults
`config/install/ai_playwright.settings.yml`:

| Key | Type | Default | Meaning |
|---|---|---|---|
| `internal_base` | string | `http://localhost` | Base URL the browser uses to reach this site. |
| `node_binary` | string | `node` | Node.js executable. |
| `timeout` | integer | `90` | Max seconds per capture (clamped to >0; runner default 90). |
| `screenshot_scheme` | string | `public` | Stream wrapper screenshots are saved to (no form field; edit via config). |
| `allow_external_urls` | boolean | `false` | Whether absolute off-site http(s) URLs may be opened. |

## Requirements hook

`ai_playwright_requirements('runtime')` runs the configured Node binary as `node --version` (via
`Symfony\Component\Process\Process`, 10s). If it does not respond it reports *"Node.js not found"*
(Warning) with a link to the settings page; otherwise *"Node.js <version>"* (OK). This is
best-effort — Playwright itself is only exercised when the tool runs.

## Operating notes

- Keep `internal_base` on the loopback so the browser reaches the site without external DNS/TLS.
- Set an absolute `node_binary` path when the web server user has no PATH to `node`.
- Leave `allow_external_urls` off unless you specifically need the agent to open external pages;
  when off, only same-site paths are ever opened.
- Screenshots accumulate under `<screenshot_scheme>://ai_playwright/`; they are managed `file`
  entities (temporary/permanent lifecycle handled by core file usage as with any managed file).
