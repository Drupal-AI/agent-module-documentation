<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# iFrame Resizer — agent index

Loads the third-party iframe-resizer JS library (v4.x) and initializes it from site config, so iframes auto-size to their content. One settings form, no fields/blocks. Requires the library installed at `libraries/iframe-resizer/` (`composer require bower-asset/iframe-resizer:^4`; v5.x unsupported).

- **Settings form, config keys, host vs hosted modes, targeting, library install** → [configure/settings.md](configure/settings.md)
- **The two alter hooks to override emitted settings from code** → [hooks/hooks.md](hooks/hooks.md)

Key facts:
- Config object `iframe_resizer.settings`; UI at `/admin/config/user-interface/iframe_resizer`, gated by permission `administer iframe resizer` (`restrict access: true`).
- `hook_page_attachments()` attaches `iframe_resizer/init` when `iframe_resizer_usage.host` is on, and `iframe_resizer/hosted` when `iframe_resizer_usage.hosted` is on.
- Options are emitted to `drupalSettings.iframeResizer.advanced` (host) and `.advancedHosted` (hosted).
- `hook_requirements()` errors on the status report until the library file `libraries/iframe-resizer/js/iframeResizer.min.js` exists.
