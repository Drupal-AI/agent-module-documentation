<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Scribit.pro (scribit_pro) — agent index

**Integrates the Scribit.pro accessible-video platform: submit YouTube/Vimeo videos for subtitles / audio description / transcript / sign language, then render the accessible player.**

- **Version:** 3.0.x  •  core: `^9 || ^10 || ^11`  •  PHP 8.1+  •  depends on `field_ui`, `media`, `key`.
- **Field plugins:** `ScribitProWidget` ("Scribit Pro oEmbed URL") + `ScribitProFormatter`, for Remote Video media.
- **Services:** `scribit_pro.api` (`ApiService`, authenticated Bearer API calls), `scribit_pro.helper` (`HelperService`, YouTube/Vimeo ID extraction + Pro-Services payloads), logger channel `scribit_pro`.
- **Config:** `scribit_pro.config` at `/admin/config/system/scribit-pro` — Scribit ID + API-token **Key** — gated by permission **`administer scribit pro`**.
- **Routes:** `scribit_pro.config` (permission-gated) and public `scribit_pro.callback` → `/scribit-pro/callback` (`_access: 'TRUE'`, no_cache).
- **Security (pre-reviewed — not re-investigated):** the anonymous `/scribit-pro/callback` (`Callback::execute`) is an **unimplemented stub** — it only returns a `RedirectResponse` to `<front>` and changes no state (`@todo handle the callback`), so it is inert; the route comment already notes a real implementation must validate request origin/signature. Admin config is permission-gated; API token stored via Key. **No security findings** beyond noting the callback stub.

See [configure/setup.md](configure/setup.md) for the full setup.
