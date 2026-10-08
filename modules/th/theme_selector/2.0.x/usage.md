<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Theme Selector allows changing the page theme with a query string parameter, choosing from configured selectable themes.

---

Theme Selector allows changing the page theme via a query-string parameter — so a URL like
`?theme=dark` can render the page with a chosen theme, selected from a configured list of selectable
themes (`theme_selector` config entities). This supports theme previews, A/B theme testing, or letting
users pick a theme via a link. It is configured at the `theme_selector` collection and provides its own
permissions.

Use it to offer theme switching by URL. The security-relevant point is scope: only themes an administrator
has explicitly configured as selectable should be switchable (so a query parameter can't force an
arbitrary/installed-but-not-intended theme, which could be a defacement/UX-confusion vector) — the module
uses configured theme_selector entities to bound this. Verify only intended themes are selectable. It is a
theming/negotiation feature; it changes presentation, not content or access.

---

- Change theme via a query string.
- Use ?theme= to switch themes.
- Select from configured themes.
- Support theme previews.
- Enable A/B theme testing.
- Configure selectable themes.
- Provide its own permissions.
- Bound switching to configured themes.
- Prevent arbitrary theme switching.
- Verify only intended themes are selectable.
- Change presentation, not access.
- Let users pick a theme via link.
- Configure the theme_selector entities.
- Switch themes by URL.
- Preview themes.
- Scope switchable themes.
- Offer theme choice.
- Configure theme switching.
- Change the page theme.
- Select themes by query.
