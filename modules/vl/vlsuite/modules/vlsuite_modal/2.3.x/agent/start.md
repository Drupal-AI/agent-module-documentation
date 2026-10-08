<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# VLSuite Modal (vlsuite_modal) — agent index

Submodule of **vlsuite**. **Modal dialogs** for both front-end components and the Layout Builder
editing UI (`vlsuite_layout_builder` depends on it).
Version **2.3.3**. Core `^10.3 || ^11`. Depends on `vlsuite`.

Sharing one implementation between editing and front end is the right call — one set of dialog
behaviours, one focus-management implementation, one set of styles.

**Focus management is what makes or breaks it. Verify all four:** focus moves in on open; focus
cannot escape while open; Escape closes; focus returns to the opener on close. Get it wrong and a
keyboard or screen-reader user is trapped with no way out.