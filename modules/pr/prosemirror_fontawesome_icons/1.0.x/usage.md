<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
ProseMirror FontAwesome Icons demonstrates the ProseMirror module's extension APIs by adding a searchable FontAwesome icon picker and an `icon` node type to the editor.
---
The module ships three ProseMirror plugins: an Extension (`FontAwesomeIconsExtension`) that registers the icon node type and menu button, an ElementType (`IconElementType`), and a Renderer (`FontAwesomeIconsRenderer`) that outputs each icon as `<i class="fas fa-{iconName} pm-icon" aria-hidden="true">`. Icons only appear once an `icon` element is added to the ProseMirror configuration, and — because the renderer emits via a Drupal `html_tag` render element — the `iconName` attribute is escaped as an attribute value, so stored-content injection through the class list is mitigated by core's attribute escaping.

Front-end rendering additionally requires that the FontAwesome library be present on the theme and that the text format allow the `<i>` tag with class attributes; otherwise icons will not display for visitors. The JavaScript bundle is prebuilt (`npm run build`).

Typical setup: enable the module, add a ProseMirror element named "Icons" with machine name `icon`, and ensure the text format permits `<i class>`.
---
- Add an icon picker button to a ProseMirror editor.
- Insert FontAwesome solid icons into rich text.
- Search icons by name in the picker dialog.
- Drag-and-drop an icon into content.
- Register the `icon` node type via the extension plugin.
- Render stored icons as `<i class="fas fa-*">`.
- Allow `<i>` with classes in the relevant text format.
- Bundle FontAwesome on the front end for display.
- Study the module as a ProseMirror API example.
- Rebuild the JS bundle after edits (`npm ci && npm run build`).
- Provide an accessible `aria-hidden` icon markup.
- Extend ProseMirror without writing core patches.
- Ship a prebuilt JS bundle with the module.
- Style inserted icons with the `pm-icon` class.
- Reference the module when building custom ProseMirror nodes.
- Restrict which formats render the icon node.
