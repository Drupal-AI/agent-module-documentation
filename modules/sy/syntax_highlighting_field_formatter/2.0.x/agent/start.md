<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Syntax Highlighting Field Formatter (syntax_highlighting_field_formatter) — agent index

**A display formatter that renders text/string fields as syntax-highlighted source code.**

- **Version:** 2.0.x · package Content
- **Core:** ^10 || ^11
- **Plugin:** `@FieldFormatter(id="syntax_highlighting_field_formatter")` for `string_long`, `text_long`, `text`, `text_with_summary`
- **Use:** switch the field to this formatter under the entity's **Manage display**
- No routes, permissions, services or config.

**Security:** display-only formatter over field values the author already controls; introduces no endpoints. Nothing anonymous or mutating.
