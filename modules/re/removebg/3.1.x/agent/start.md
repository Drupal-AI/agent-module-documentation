<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# remove.bg (removebg) — agent index

**Image-style effect that removes backgrounds via the remove.bg / rembg.com API.**

- **Version:** 3.1.x
- **Core:** ^9 || ^10 || ^11 — requires core `image`, `image_effects`.
- **Config route:** `removebg.settings.form` → `/admin/config/removebg` (perm `administer removebg`).
- **Effect:** `RemoveBgImageEffect` (`src/Plugin/ImageEffect/`). Endpoints: `api.remove.bg/v1.0/removebg`, `api.rembg.com/rmbg` (fixed).

**Security:** Settings route is permission-gated. The effect POSTs the **image being processed** (not a request-supplied URL) to **fixed** provider endpoints — no SSRF. Guzzle uses default TLS verification (no `verify=>false`). API key stored in module config. No security findings. See [configure/settings.md](configure/settings.md).
