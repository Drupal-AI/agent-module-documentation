<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Theme Flip gives visitors a small floating widget to preview any allowed installed theme, applied via AJAX without a full page reload and without ever changing the site's default theme.

---

A theme negotiator (`FlipThemeNegotiator`, priority -10, admin routes excluded) reads the previewed theme from the session and applies it for that visitor only. The switch controller (`SwitchController::switchTheme`, POST `/theme-flip/switch/{theme}`) validates an `X-CSRF-Token` header itself — because core's `_csrf_request_header_token` only covers authenticated sessions and this route targets anonymous visitors — then checks the requested theme against the admin-configured allow-list and `themeExists()`, stores it in the session, re-renders the current page via a sub-request, and returns the whole document for the client to swap in. A token endpoint (`/theme-flip/token`) issues the CSRF seed and forces the session to persist. The requested `path` from the POST body is sanitised against open-redirect/SSRF (must start with `/`, not `//`, no `://`).

Admins choose which themes are previewable and on which pages the widget appears at `/admin/config/user-interface/theme-flip` (`administer theme flip`). The two public routes use `access content`, appropriate for a read-only, session-scoped preview that cannot affect other users or the saved configuration. Set up by enabling the module, selecting allowed themes, and configuring widget visibility.
---
- Let visitors preview a theme without reloading the page
- Offer a floating theme-switcher widget on the front end
- Restrict which themes visitors may preview
- Control which pages show the widget
- Preview a redesign against real content
- Keep the site default theme unchanged during previews
- Apply the previewed theme per session only
- Exclude admin routes from preview switching
- Validate a CSRF token even for anonymous switch requests
- Sanitise the return path against open redirects
- Re-render the current page in the chosen theme via sub-request
- Issue a CSRF token seed for anonymous visitors
- Let stakeholders compare multiple themes quickly
- Demo theme options to a client on a live site
- Reset to the default theme by clearing the preview
- Gate configuration behind `administer theme flip`
