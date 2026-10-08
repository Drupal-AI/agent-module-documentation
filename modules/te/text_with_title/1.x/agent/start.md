<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Text with Title (text_with_title) — agent index

Field type combining a **title + formatted text area** in one field. Version **dev-1.x**.
Core `^8 || ^9 || ^10 || ^11`. Depends on core `field`.

For repeating "heading + content" patterns (FAQ, feature blocks, accordions): a multi-value
instance is a clean list of titled sections that move/sort/delete as units — lighter than a
paragraph type, sturdier than two position-aligned parallel fields.

**Separate field type** → chosen at field creation; converting existing separate fields is
add-and-migrate, not in-place. Display/widget are the module's — check they suit the theme.