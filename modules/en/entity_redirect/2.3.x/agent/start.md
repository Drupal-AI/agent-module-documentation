<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Entity Redirect — agent index

Sends the user to a configurable destination **after add / edit / delete** of an entity, set
**per bundle** (content type, media type, vocabulary, contact form, paragraph type, profile,
webform). **No global settings page, no configure route** (`configure: null`), no Drush. One
permission: `set external entity redirects`.

- **Configure a bundle's redirect: the third-party-settings structure, destinations, permission** →
  [configure/redirects.md](configure/redirects.md)
- **How the redirect actually fires (form alter + submit handler)** →
  [api/mechanism.md](api/mechanism.md)

Key facts:

- Config path: `<bundle_config>` → `third_party_settings.entity_redirect.redirect.<action>`
  where `<action>` is `add` | `edit` | `delete` | `anonymous`; each has
  `{active, destination, url, external}` (+ `personalizable`).
- `destination` values: `default`, `add_form`, `edit_form`, `created`, `url` (local path),
  `previous_page`, `layout_builder` (needs `layout_builder`), `external` (needs the permission).
- Example bundle configs: `node.type.<b>`, `media.type.<b>`, `taxonomy.vocabulary.<b>`,
  `contact.form.<b>`, `paragraphs.paragraphs_type.<b>`, `profile.type.<b>`, `webform.settings`.
