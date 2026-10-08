<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Generic components (generic_components) — agent index
**Reusable Single Directory Components (HTML tag, wrapper, spacer, field range, comment) for any theme.**

- **Version:** 1.0.x
- **Core:** ^10 || ^11
- **Provides:** SDCs under `components/` (`generic_html_tag`, `generic_html_wrapper`, `generic_spacer`, `field_range`, `comment`, `comment_links`)
- **Use:** `{{ include('generic_components:<component>', {...}) }}`; designed to pair with Display Builder.
- No routes, permissions, services, or config.

**Security:** no routes/permissions/endpoints; component props are builder-supplied (not request input) and constrained by prop schemas (e.g. HTML tag pattern `^[a-zA-Z0-9-]+$`); standard SDC/Twig auto-escaping applies.
