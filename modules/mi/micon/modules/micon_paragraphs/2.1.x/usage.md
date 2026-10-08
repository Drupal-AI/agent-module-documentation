<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Micon Paragraphs adds an "Icon" picker to the Paragraphs type add/edit form so each paragraph bundle can carry a Micon icon, shown in the Paragraphs types admin list and (replacing the built-in icon-file upload) reused through Micon's string-matching system.

---

The submodule implements `hook_form_paragraphs_type_form_alter()` to add a `#type => 'micon'` element to the paragraphs type form and to hide the core `icon_file` upload (`$form['icon_file']['#access'] = FALSE`). An entity builder stores the chosen icon id as a **third-party setting** on the `paragraphs_type` config entity: `third_party_settings.micon_paragraphs.icon` (e.g. `fa-cube`). It replaces the paragraphs type list builder with `MiconParagraphsTypeListBuilder`, which renders the Micon icon in the existing icon column via `micon()->setIcon()`. Through `hook_micon_icons_alter()` it registers dynamic `micon_icons` definitions — `paragraphs.<label>` and `paragraphs.<machine_name>` — pointing at the bundle's icon, so `micon('paragraphs.text')` resolves anywhere. Changing an icon invalidates the `micon.discovery` cache tag. No settings form, no `configure` route. Helper `micon_paragraphs_icon($type)` returns the stored id. Requires the contrib Paragraphs module.

---

- Give each paragraph bundle (Text, Image, Quote…) a recognisable icon.
- Use a Micon Font Awesome icon instead of uploading an icon image per bundle.
- Show paragraph-type icons in the Paragraphs types admin overview.
- Store a paragraph type's icon in config so it deploys with `config export`.
- Read a bundle's icon in code with `micon_paragraphs_icon($paragraphs_type)`.
- Render a bundle icon anywhere via `micon('paragraphs.text')`.
- Match by label too: `micon('paragraphs.image gallery')` (lowercased label alias).
- Decorate an "Add paragraph" chooser/button with the bundle's icon.
- Drive a custom paragraph-type selector UI with per-bundle icons.
- Keep consistent iconography across a page-builder's paragraph bundles.
- Replace bespoke SVG uploads with a single shared icon package.
- Let editors identify paragraph types at a glance while building content.
- Set an icon on a new paragraph type at creation time.
- Update a bundle's icon and have all `paragraphs.*` matches follow after a cache clear.
- Expose paragraph-type icons to other Micon-aware features by string match.
- Remove a bundle's icon by clearing the picker (empties the third-party setting).
- Standardise the icon set across a component/paragraph library.
- Integrate bundle icons into custom Layout/Paragraphs theming.
- Pick the icon from a curated package via the searchable fonticonpicker element.
- Avoid custom preprocessing just to show a per-bundle icon.
