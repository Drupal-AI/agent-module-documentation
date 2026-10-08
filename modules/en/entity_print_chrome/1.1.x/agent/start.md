<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Entity Print Chrome (entity_print_chrome) — agent index

**A headless-Chrome PDF print engine for Entity Print, using `chrome-php/chrome` to render server-generated entity HTML to PDF.**

- **Version:** 1.1.x  •  core: `^9 || ^10`  •  package: Entity Print  •  depends on `entity_print` + composer `chrome-php/chrome`.
- **Engine plugin:** `@PrintEngine(id="chrome")` `Chrome` — writes `$this->html` to a `temporary://*.html` file, `BrowserFactory($binary_location)->createBrowser(['noSandbox'=>TRUE])`, `navigate('file://'.realpath)`, `page->pdf(...)->getBase64(10000)`, unlinks temp file.
- **Config:** `binary_location` (default `/usr/bin/google-chrome`), `print_background`; set via Entity Print settings form (admin-only).
- **Subscriber:** `PostRenderSubscriber` rewrites root-relative href/src to `file://getcwd()...` (skipped on debug routes).

**Security (reviewed, sound — no finding):** NOT an SSRF sink — Chrome navigates only to a module-written local `file://` temp file, never a request-supplied URL. The HTML is Entity Print's server-side render of the entity; who may print is gated by Entity Print's own route permissions. `binary_location` is admin-only config (an admin with that access can already run code), so not attacker-controlled command injection. `noSandbox=>TRUE` is a hardening note (isolate the service), not a request-time vuln.
