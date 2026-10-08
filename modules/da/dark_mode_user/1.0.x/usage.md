A standalone dark-mode system for Drupal that lets an administrator set a site-wide default and lets permitted users pick their own light, dark, or system color mode.

---

Dark Mode User writes a color-mode choice onto the `<html>` element as `data-dmu-mode` (`light`/`dark`) and `data-dmu-source` (`user`/`system`) so a theme can style itself accordingly; it ships no CSS of its own. A single admin form sets the site-wide default (also used for anonymous users), and users holding the `access dark mode user` permission get a "Dark mode user settings" section on their own user edit form where they may choose Light, Dark, System, or "Global settings" (fall back to the site default). The chosen mode is applied in the page header before render by an anti-flicker script, and a system/OS preference change is followed live. It is self-contained and does not require the older Dark Mode Toggle module — it is intended as a replacement for it.

---

- Give a Drupal site light/dark theming without pulling in the Dark Mode Toggle module.
- Set one site-wide default color mode (light, dark, or system) for all visitors.
- Have anonymous visitors follow a fixed site default color mode.
- Have anonymous visitors follow their OS/browser color-scheme preference by setting the default to "system".
- Let authenticated users override the site default with a personal color-mode choice.
- Let a user pin the site to always-light regardless of their OS setting.
- Let a user pin the site to always-dark regardless of their OS setting.
- Let a user follow their operating-system / browser dark-mode preference.
- Let a user revert to the global default via the "Global settings" option.
- Restrict who can set a personal preference by granting `access dark mode user` per role.
- Style a custom theme against the `data-dmu-mode` attribute on `<html>`.
- Integrate with Tailwind CSS via a `@custom-variant dark` targeting `[data-dmu-mode=dark]`.
- Detect whether the active mode came from the user or the OS via the `data-dmu-source` attribute.
- Avoid the flash-of-wrong-theme on load using the header anti-flicker script.
- Update the page live when the visitor changes their OS dark-mode setting while browsing (system source).
- Store per-user preference without adding a database field, using core's `user.data` store.
- Expose the effective mode to front-end JavaScript through `drupalSettings.dark_mode_user`.
- Provide a color-mode preference on multi-author sites where each editor wants their own default.
- Ship an accessibility-friendly dark option that respects OS-level preferences.
- Configure the global default at `/admin/config/user-interface/dark-mode-user` (requires `administer site configuration`).
- Roll out dark mode progressively by theming against the attribute while defaulting the site to light.
