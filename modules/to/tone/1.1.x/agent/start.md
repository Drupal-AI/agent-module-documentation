<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Tone (tone) — agent index

**Editor-supplied CSS as content entities: tone types wire an identity + renderer + attachment-strategy plugin; tones hold field values injected onto referencing entities.**

- **Version:** 1.1.x (1.1.0)
- **Core:** ^10.3 || ^11
- **Entities:** `tone` (revisionable, translatable content entity; admin_permission `administer tones`), `tone_type` (config bundle; admin_permission `administer tone types`)
- **Permissions:** `administer tone types` (restrict access), `administer tones`, `create tone`, `edit tone`, `delete tone`, `view tone`
- **Plugin types:** ToneRenderer (`plugin.manager.tone_renderer`), ToneAttachmentStrategy, ToneIdentity — attribute + annotation based
- **Renderers:** `tone_css_property` (Single CSS Property), CssDeclarationBlock. **Identities:** Hash, EntityUuid. **Strategies:** CssInline, CssPublicFiles
- **Hooks:** `hook_entity_extra_field_info`, `hook_entity_view_alter` (attach "Tone From X")
- **Links:** collection `/admin/content/tone`; tone types `/admin/structure/tone_types`
- See [configure/tone-types.md](configure/tone-types.md)

**Security:** by design a permission-gated **front-end CSS injection** surface (README warns explicitly). CSS values are sanitised of `{ } ;` (`CssProperty.php:150`) but grant create/edit tone + administer tone types only to trusted roles. Standard permission-gated entity routes; no anonymous endpoints. (Reported, not recorded.)
