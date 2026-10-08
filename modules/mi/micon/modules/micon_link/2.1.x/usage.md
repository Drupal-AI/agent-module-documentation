<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Micon Link provides an alternate widget and formatter for core Link fields that let editors attach a Micon icon (and an icon position) to each link, stored inside the link's options attributes.

---

The submodule adds two plugins for the core `link` field type: the **`micon_link` widget** (extends core `LinkWidget`) and the **`micon_link` formatter** (extends core `LinkFormatter`). The widget adds a `#type => 'micon'` icon picker to each link item; the chosen icon is saved in the link's `options.attributes.data-icon` (and, when enabled, `data-icon-position` = `before`/`after`/`icon_only`). Widget settings (schema `field.widget.settings.micon_link`): `packages` (which icon packages to offer), `icon` (a default/fallback icon), `position` (allow choosing icon position), `target` (allow an "open in new window" checkbox). The formatter renders each link through `MiconIconize` so the icon appears with the link text; its settings (schema `field.formatter.settings.micon_link`) include `title` (override text, token-aware), `icon` (fallback icon), `position`, and `text_only`. The shared logic lives in `MiconLinkWidgetTrait`, which the Linkit variants reuse. No settings form or `configure` route — everything is configured on the field's *Manage form display* / *Manage display*.

---

- Add an icon to each menu-style link stored in a Link field.
- Let editors choose the icon per link from a searchable picker.
- Restrict the icon picker on a link field to specific packages.
- Set a default/fallback icon used when a link has none.
- Let editors place the icon before or after the link text, or show icon-only.
- Offer an "open in new window" (target=_blank) checkbox on each link.
- Render a "call to action" link with a leading Font Awesome arrow icon.
- Build an icon-decorated footer or social link list from a multi-value Link field.
- Show icon-only links (e.g. a row of social icons) via the icon_only position.
- Override the displayed link text with the formatter's token-aware `title` setting.
- Trim or plain-render link URLs while still showing an icon (inherits core Link formatter settings).
- Output text-only (icon + text, no anchor) with the formatter's `text_only` option.
- Store the icon on the link value itself (`options.attributes.data-icon`) so it travels with the data.
- Swap a plain Link widget for `micon_link` on Manage form display without changing the field.
- Provide consistent iconography across all links in a content type.
- Use the same icon package site-wide for link icons.
- Add icons to "related links" or "resources" link fields.
- Decorate documentation or download links with type icons (pdf, external, etc.).
- Reuse the widget trait to build custom icon-aware link widgets.
- Combine with Linkit (via micon_linkit) for autocomplete + icons.
