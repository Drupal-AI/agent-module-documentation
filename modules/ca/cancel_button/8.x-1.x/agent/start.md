<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Cancel Button (cancel_button) — agent index

Adds a **Cancel button to entity forms** and resolves its target by precedence. Version **8.x-1.5**. Core `^8..^11`. Configure at `/admin/config/content/cancel-button` (`administer cancel button configuration`).

Cancel target precedence: form `setRedirect()` → `?destination=` → HTTP referer → entity canonical page → per-content-type fallback (configured).

Security: admin config route is permission-gated; redirect target uses core's sanitised `destination` handling (internal-only), so no open-redirect surface.

See [configure/settings.md](configure/settings.md) for the per-bundle fallback configuration.