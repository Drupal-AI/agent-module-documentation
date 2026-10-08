<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Parade (parade) — agent index

**Paragraphs-based page-building toolkit: preview widgets, call-to-action fields, view-mode layout and optional feature/integration submodules.**

- **Version:** 3.x (dev-3.x checkout; git branch 3.x)
- **Core:** ^10 || ^11 · **Package:** Paragraphs
- **Composer deps:** paragraphs, machine_name, geocoder, geofield, geophp, leaflet, geocoder_autocomplete, classy_paragraphs, view_mode_selector, field_group.
- **Widgets/formatters:** `InlineParagraphsPreviewerWidget`, `InlineParagraphsWidget`, `CallToActionWidget`/`CallToActionFormatter`, `LinkWithSelectedAttributeWidget`.
- **Submodules:** `parade_demo`, `parade_pack` (routes `_permission: administer site configuration`), `parade_conditional_field` (`administer paragraphs types`), `marketo_form`, `marketo_poll`, `linkedin_autofill`, `aggregated_leaflet_map`.
- **Security:** all module/submodule routes are permission-gated (`administer site configuration`, `administer paragraphs types`); no `_access: TRUE`, no anonymous or mutating public endpoints, no server-side untrusted-input sinks found. No security findings.

See [configure/pagebuilding.md](configure/pagebuilding.md)
