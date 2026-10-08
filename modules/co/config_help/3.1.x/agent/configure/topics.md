<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Managing configurable help topics

**Collection:** `/admin/config/development/config-help` lists all topics (editable config topics + read-only plugin topics). Add/edit via `HelpTopicForm`, delete via the standard delete form. All require `administer config help`.

A `config_help` topic exports these keys: `id`, `label`, `top_level` (whether it appears on the main Help page), `related` (ids of related topics, wired with the autocomplete at `/config-help/autocomplete-topic`), `body`, and `body_format` (the text format used to render it; the module ships a `help` format + editor). The body is stored chunked (`HtmlChunker`, `HelpTopicBody`/`HelpTopicBodyChunk` form elements) so rich HTML survives the configuration schema.

Because topics are configuration, they participate in config import/export and, with Configuration Translation enabled, become translatable. Only topics created here are editable — plugin/YAML topics provided by modules and themes stay read-only and are shown together with yours. The contributed Configuration Update Manager can diff/update config topics shipped by modules.
