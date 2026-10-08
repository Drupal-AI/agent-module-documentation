<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
CKEditor Mentions adds `@`-mention autocomplete to CKEditor 5: typing a marker offers matching users or nodes, and picking one inserts a link to that entity — with submodules extending it to arbitrary entities, to real-name display, and to a stored record of every mention.

---

The pattern is familiar from every collaboration tool and the value is the same: mentioning a person or piece of content creates a machine-actionable reference rather than a name in prose. The module registers a CKEditor 5 plugin (`ckeditor_mentions_mentions`) whose settings appear on each text format, an AJAX callback at `/ckeditor-mentions/ajax/{editor_id}/{plugin_id}/{match}` that returns candidate suggestions as you type, and a pluggable "mentions type" system — built-in `user` and `node` types, plus a `realname` type in a submodule — so you choose which entity types are mentionable and by which marker. Each mention is stored as an `<a>` carrying the target's uuid and plugin, and on save the module scans an entity's text fields and dispatches events (`ckeditor_mentions.mention`, `ckeditor_mentions.mention_subsequent`, `ckeditor_mentions.suggestion_event`), also exposed to Rules and ECA, so a mention can drive a notification or workflow — usually the real reason to install it. The `ckeditor_mentions_entity` submodule persists a `mention` content entity per mention (parent/target), and `ckeditor_mentions_realname` matches on the realname module's display names. Requirements are PHP 8.1+, core `ckeditor5` and `image`, and `masterminds/html5` for parsing; configuration is per text format and gated by the `use inline mentions` permission (source read from 3.0.0-beta6).

---

- Mention a colleague in a comment or node body.
- Autocomplete usernames while typing after `@`.
- Mention published nodes as well as users.
- Link each mention to the target's canonical URL or alias.
- Show real names instead of usernames (realname submodule).
- Persist a record of every mention as an entity (entity submodule).
- Notify a user when they are first mentioned.
- Re-notify (or not) on subsequent mentions of the same target.
- Trigger a Rules or ECA workflow from a mention.
- Filter suggestions programmatically before they reach the editor.
- Restrict a node mentions type to specific bundles.
- Set a distinct marker per mentions type (e.g. `@` users, `#` nodes).
- Limit how many suggestions the dropdown shows.
- Require a minimum number of typed characters before lookups fire.
- Add a custom mentions type for taxonomy terms or other entities.
- Build an internal discussion or collaboration feature.
- Reference a person in an editorial review note.
- Reduce copy-pasted usernames and broken profile links.
- Migrate a CKEditor 4 mentions setup to CKEditor 5.
- Support a community or intranet platform's @-mentions.
