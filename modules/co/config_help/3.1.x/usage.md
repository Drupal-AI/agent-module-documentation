<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Configurable Help extends core's Help Topics system so administrators can create and edit help topic pages that are stored as configuration (the `config_help` config entity). Because topics are config, they can be translated, imported, and exported like any other site configuration. Editable configurable topics are displayed seamlessly alongside the read-only plugin/YAML topics that modules and themes provide.

---

Each topic has an id, label, top-level flag, related-topic ids, and a filtered body (stored as chunked configuration and rendered through a text format, default `help`). The admin collection lives at `/admin/config/development/config-help` with add/edit/delete forms; a topic-id autocomplete endpoint (`/config-help/autocomplete-topic`) helps wire up "related" topics and is gated by the `administer config help` permission. A custom form element chunks the HTML body so it round-trips through configuration schema.

Setup: enable the module (requires core Help and Filter), then add topics at the collection route. Only topics you create here are editable — module/theme-provided plugin topics remain read-only. With Configuration Translation enabled, topics become translatable.

---

- Create a new configurable help topic
- Edit the body of an existing configurable topic
- Mark a topic as top-level (listed on the main Help page)
- Link related topics via the autocomplete field
- Choose the text format used to render a topic body
- Delete a configurable help topic
- Translate a topic with Configuration Translation
- Export help topics as configuration
- Import help topics into another environment
- Display configurable topics alongside core plugin topics
- Restrict topic administration to `administer config help`
- Use the topic-id autocomplete at `/config-help/autocomplete-topic`
- Reference a topic from a route/token via provided tokens
- Keep documentation versioned in config management
- Build a site help system editable by non-developers
