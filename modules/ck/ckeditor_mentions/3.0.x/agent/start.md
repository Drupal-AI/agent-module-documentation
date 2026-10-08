<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# CKEditor Mentions (ckeditor_mentions) — agent index

Adds `@`-mention autocomplete to **CKEditor 5**: type a marker (`@` by default) in a rich-text
field, pick a matching **user** or **node** from a dropdown, and the mention is inserted as an
`<a>` link carrying the target's uuid/id. A pluggable "mentions type" system, an events system
(also exposed to Rules/ECA), and two submodules extend it.

- Depends on core `ckeditor5` and `image`; Composer `masterminds/html5 ^2.1`, PHP `>=8.1`.
- **No settings page / `configure` route** — set up per **text format** in the CKEditor 5 plugin
  settings (the "Mentions" section), stored in `editor.editor.{format}`.
- Defines a permission, config schema, and a plugin type (`mentions_type`). No Drush.

Submodules (each ships inside this project; not documented here):
| Submodule | Adds |
|---|---|
| `ckeditor_mentions_entity` | a `mention` content entity recording each mention (parent/target) |
| `ckeditor_mentions_realname` | a `realname` mentions type that matches on the realname module's display names |

## Solution docs
- **Enable mentions on a text format / set marker, limits, bundle filter** → [configure/text-format.md](configure/text-format.md)
- **The permission that gates the autocomplete** → [permissions/permissions.md](permissions/permissions.md)
- **Add a custom mentions type (mention other entity types)** → [plugins/mentions-type.md](plugins/mentions-type.md)
- **React to a mention / filter suggestions (events, Rules/ECA)** → [events/events.md](events/events.md)
- **Read mentions out of an entity's fields (service API)** → [api/services.md](api/services.md)
- **Hooks it implements + alter hooks + query tags for integrators** → [hooks/hooks.md](hooks/hooks.md)

## Key facts
- Route: `ckeditor_mentions.ajax_callback` → `GET /ckeditor-mentions/ajax/{editor_id}/{plugin_id}/{match}` (`_permission: 'use inline mentions'`).
- Permission: `use inline mentions`.
- CKEditor 5 plugin id: `ckeditor_mentions_mentions` (class `…Plugin\CKEditor5Plugin\Mentions`); config path `editor.editor.{format}:settings.plugins.ckeditor_mentions_mentions.plugins.{type}`.
- Plugin type: `mentions_type` — manager `plugin.manager.mentions_type`, annotation `@MentionsType` (`Drupal\ckeditor_mentions\Annotation\MentionsType`), interface `MentionsTypeInterface`, base `MentionsTypeBase`, namespace `Plugin/MentionsType`, alter `hook_mentions_type_plugin_info_alter`. Built-ins: `user`, `node` (+ `realname` in a submodule).
- Service: `ckeditor_mentions.mention_event_dispatcher` (`MentionEventDispatcher`, `@internal`).
- Events: `ckeditor_mentions.mention`, `ckeditor_mentions.mention_subsequent`, `ckeditor_mentions.suggestion_event` (`CKEditorEvents` constants).
- Alter hooks: `hook_ckeditor_mentions_build_token_alter`, `hook_ckeditor_mentions_build_tokens_alter`.
- Install creates image style `mentions_icon` (40×40 scale-and-crop) for user avatars.
- Cache bin/service: `cache.ckeditor_mentions` (memory + default backend chain).
