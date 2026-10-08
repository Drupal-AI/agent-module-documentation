<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Micon Linkit Attributes provides a Link-field widget that combines Linkit autocomplete, the Link Attributes UI (custom link attributes like class/rel/target), and Micon's per-link icon picker.

---

The submodule adds one field widget, **`micon_linkit_attributes`** (label "Linkit (with icon and attributes)"), for the core `link` field type. It extends `linkit_attributes`' `LinkitWithAttributesWidget` and mixes in `micon_link`'s `MiconLinkWidgetTrait`, so editors get Linkit autocomplete, the configurable link-attributes controls (from the Link Attributes module), and a Micon icon picker in one widget. As with `micon_link`, the icon is stored on the link value at `options.attributes.data-icon` (position at `data-icon-position`); the module reuses the `packages`/`icon`/`position` settings but drops the `target` setting because `linkit_attributes` already provides target handling. No formatter of its own, no settings form, no `configure` route. Requires the contrib **Linkit** and **Link Attributes** (`linkit_attributes`) modules plus `micon_link`.

---

- Let editors autocomplete a link, set custom attributes, and pick an icon in one widget.
- Add both `rel`/`class`/`target` attributes and a Micon icon to link-field values.
- Build richly-attributed CTA links with icons that reference internal entities.
- Restrict the icon picker on the field to specific packages.
- Provide a default fallback icon for attribute-rich Linkit links.
- Allow before/after/icon-only icon positioning alongside link attributes.
- Rely on link_attributes for target handling instead of Micon's own checkbox.
- Keep the icon on the link value (`data-icon`) so it travels with content.
- Swap a plain Linkit-with-attributes widget for the Micon variant without changing the field.
- Reuse Micon's Font Awesome package for attributed link icons.
- Add tracking/utility classes plus icons to marketing links.
- Decorate download/resource links with both attributes and icons.
- Combine entity autocomplete, attributes, and iconography for editors.
- Standardise attributed-link iconography across content types.
- Render with the core Link or `micon_link` formatter to show the icon.
- Give one control for link target, attributes, and icon.
- Migrate from `micon_linkit` when custom link attributes are also needed.
- Attach icons to cross-references that carry accessibility attributes.
- Avoid separate fields for link, attributes, and icon.
