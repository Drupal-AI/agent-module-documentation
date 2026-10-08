<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# AnimateCSS — agent index

Integrates the Animate.css library (v4.1.1). Base module attaches the library site-wide and exposes animation option helpers + two extension hooks. No config/permissions/`configure` in the base module — the admin UI lives in the `animatecss_ui` submodule.

- **Applying animations (classes, library loading local vs CDN, requirements)** → [theming/animate.md](theming/animate.md)
- **Procedural helper functions returning animation/delay/speed/event option lists** → [api/functions.md](api/functions.md)
- **Extension hooks: add animation names, register scroll-reveal libraries** → [hooks/hooks.md](hooks/hooks.md)

Submodule (own docs):
- `animatecss_ui` → [../../modules/animatecss_ui/1.1.x/agent/start.md](../../modules/animatecss_ui/1.1.x/agent/start.md)

Key facts:
- Asset libraries: `animatecss/animate.css` (local `/libraries/animate.css/animate.min.css`) and `animatecss/animate.cdn` (cloudflare 4.1.1).
- `hook_page_attachments()` attaches the library ONLY when `animatecss_ui` is NOT installed; local if present, else CDN.
- Usage in markup: `<h1 class="animate__animated animate__bounce">…</h1>` (note the `animate__` prefix).
- `animatecss_check_installed()` returns whether the local library file exists.
