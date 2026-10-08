<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Micon Linkit provides a Link-field widget that combines Linkit's autocomplete (search internal entities to build links) with Micon's per-link icon picker.

---

The submodule adds one field widget, **`micon_linkit`** (label "Linkit (with icon)"), for the core `link` field type. It extends Linkit's `LinkitWidget` and mixes in `micon_link`'s `MiconLinkWidgetTrait`, so you get Linkit's autocomplete URL field plus the Micon icon controls (icon picker, optional position, optional target). Like `micon_link`, the chosen icon is stored on the link value at `options.attributes.data-icon` (position at `data-icon-position`); widget settings are the same `packages` / `icon` / `position` / `target` (plus Linkit's own `linkit_profile`). There is no formatter of its own — render with core Link or the `micon_link` formatter. No settings form or `configure` route; select the widget on the field's *Manage form display*. Requires the contrib **Linkit** module (and `micon_link`).

---

- Let editors autocomplete internal links and attach an icon in one widget.
- Add icons to a "related content" Link field that uses Linkit search.
- Build icon-decorated navigation/CTA links that reference nodes by title.
- Restrict the icon picker on a Linkit field to specific packages.
- Provide a default fallback icon for Linkit-built links.
- Allow before/after/icon-only positioning on Linkit links.
- Offer an "open in new window" checkbox alongside Linkit autocomplete.
- Keep icons stored on the link value (`data-icon`) so they travel with content.
- Swap a plain Linkit widget for `micon_linkit` without changing the field.
- Reuse Micon's Font Awesome package for Linkit link icons.
- Combine entity autocomplete with consistent link iconography.
- Decorate resource/download links that point at media or file entities.
- Use with the `micon_link` formatter to render the icon on output.
- Give an editorial team one control for both link target and icon.
- Migrate from `micon_link` to Linkit-powered links while keeping icons.
- Add icons to menu-like link lists built with Linkit.
- Standardise link iconography across content types using Linkit.
- Attach icons to cross-references created via Linkit autocomplete.
- Avoid a separate icon field by embedding the icon in the link widget.
