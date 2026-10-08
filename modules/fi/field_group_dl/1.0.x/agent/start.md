<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Field Group Definition List (field_group_dl) — agent index

**Renders a Field Group as a semantic HTML definition list (`<dl>`) on entity view displays.**

- **Version:** 1.0.x
- **Core:** ^9 || ^10 || ^11
- **Depends on:** `field_group`
- **Plugin:** `field_group_dl` FieldGroupFormatter (id `field_group_dl`, view context only) in `src/Plugin/field_group/FieldGroupFormatter/DefinitionList.php`
- **Theme:** `field_group_dl` hook + `template_preprocess_field_group_dl()` in the `.module`; template `templates/field-group-dl.html.twig`
- **Config:** none of its own — uses Field Group's per-display formatter settings (id, classes)
- **Routes / permissions / services:** none

**Security:** No routes, permissions, services, or writable config; output-only display formatter. No anonymous or mutating endpoints; no security-relevant surface.
