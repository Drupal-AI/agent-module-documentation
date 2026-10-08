<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# ProseMirror FontAwesome Icons (prosemirror_fontawesome_icons) — agent index
**Adds a FontAwesome icon picker + `icon` node type to the ProseMirror editor (API demo).**

- **Version:** 1.0.x (1.0.0-beta2)
- **Core:** ^10 || ^11
- **Depends on:** prosemirror
- **Plugins:** `Plugin/ProseMirror/Extension/FontAwesomeIconsExtension`, `.../Rendering/FontAwesomeIconsRenderer`, `.../ElementType/IconElementType`
- **Output:** `<i class="fas fa-{iconName} pm-icon" aria-hidden="true">`

**Security:** No routes, permissions, or services. Icon name is emitted via a core `html_tag` render element (attribute-escaped). Front-end display depends on the text format allowing `<i class>`.
