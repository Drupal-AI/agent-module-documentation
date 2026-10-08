<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
## What it does

- Injects a small JavaScript library that traps the browser Back button so the user cannot navigate back to previously viewed pages.
- Intended to stop users returning (via history/cache) to authenticated pages after logout, or to lock users onto a flow (e.g. a quiz/exam page).
- Configurable to run everywhere or only on an admin-defined list of paths.

---

## Install & configure

- Enable the module; no dependencies beyond core.
- Configure at `/admin/config/browser/noback/settings` (route `disable_back_button.config_form`, permission `administer site configuration`).
- Choose whether to apply site-wide or on a page-list; the JS library `disable_back_button` is attached on matching responses.

---

## Usage & behaviour

- The protection is purely client-side JavaScript; it does not enforce any server-side access control.
- It works by manipulating `window.history` (pushState / popstate handlers) so a Back press re-lands on the current page.
- A user with JavaScript disabled, or using browser dev tools, bypasses it entirely — do not rely on it as a security control.
- Use it as a UX nicety, not to protect sensitive data; real post-logout protection must come from cache headers and session handling.
- Applies on both anonymous and authenticated sessions depending on the path configuration.
- The path matching follows Drupal's standard visibility-path syntax (one path per line, `*` wildcards).
- Because it only adds a library, it has negligible performance cost.
- Disabling the module removes the library and restores normal Back behaviour immediately.
- No custom permissions are defined; only the core `administer site configuration` gate protects the settings form.
- No routes expose data; the only route is the admin settings form.
- Combine with `Cache-Control: no-store` on sensitive pages for defence in depth.
- The library is registered in `disable_back_button.libraries.yml` and attached from the `.module` file.
- Settings are stored in simple module config (config factory), exportable via CMI.
- Safe to leave enabled on multilingual sites; behaviour is language-agnostic.
- There is no API for other modules; it is a self-contained UX toggle.
- Test in the actual target browsers, since history behaviour varies across browser vendors and versions.
