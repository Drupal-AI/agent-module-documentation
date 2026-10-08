<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Wingsuit Link (wingsuit_link) — agent index

Submodule of **wingsuit_companion**. Connects the **UI Patterns Settings link widget** to
**Link Attributes**, so a link passed to a component can carry `class`, `target` and `rel`.
Version **8.x-2.2**. Core `^8 || ^9 || ^10 || ^11`. Depends on `link_attributes`.

Small ergonomics piece with a security-adjacent detail worth naming: `target="_blank"` without
`rel="noopener"` hands the opened page a handle on yours. Making `rel` settable where the link is
configured is what lets that be set rather than remembered.