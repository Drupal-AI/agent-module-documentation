<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Layout Builder IPE adds a frontend in-place-editing experience for Layout Builder, similar to what Panels IPE offered.

---

Layout Builder IPE provides an in-place editing (IPE) experience for Layout Builder on the front
end — editing layouts directly in the rendered page context rather than only in the back-end Layout
Builder UI, similar to what Panels IPE used to offer. It aims to make layout editing feel more
immediate and WYSIWYG for editors. It depends on core Layout Builder and is configured at
`layout_builder_ipe.config`; it provides its own permissions.

Use it where editors prefer to arrange Layout Builder content on the live-looking page. It is an
editing-experience layer over Layout Builder; access is governed by Layout Builder's own permissions
plus this module's — it changes the editing UI, not what a user is allowed to edit. Grant its
permission only to users who should manage layouts.

---

- Edit Layout Builder layouts in place.
- Provide frontend IPE for Layout Builder.
- Arrange layouts on the rendered page.
- Offer a Panels-IPE-like experience.
- Depend on core Layout Builder.
- Configure at layout_builder_ipe.config.
- Provide its own permissions.
- Make layout editing more WYSIWYG.
- Edit layouts in page context.
- Grant IPE to layout managers only.
- Respect Layout Builder permissions.
- Change the editing UI, not access.
- Improve the layout editing experience.
- Manage sections on the front end.
- Place blocks in place.
- Give editors immediate layout feedback.
- Layer IPE over Layout Builder.
- Edit the live-looking page.
- Support front-end layout editing.
- Control access via permissions.
