<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Views Negate (views_negate) — agent index

**Adds a "Negate" (not-equal / not-in) checkbox to string and list Views contextual filters, like the exclude option on numeric arguments.**

- **Version:** 2.0.x (installed 2.0.1)
- **Core:** ^8 || ^9 || ^10 || ^11
- **Depends on:** core `views`
- **Plugin:** `StringNegate` Views argument (`src/Plugin/views/argument/StringNegate.php`), registered via `views_negate.views.inc`
- **UI:** a "Negate" checkbox under a string/list contextual filter's **MORE** fieldset; applies not-equal, or NOT IN when "Allow multiple values" is on
- **Config schema:** `config/schema/views_negate.schema.yml`
- **Routes/permissions/services:** none

**Security:** No routes, permissions, services, or external calls. Configured only within the Views UI (standard Views admin access). No anonymous or mutating endpoints.
