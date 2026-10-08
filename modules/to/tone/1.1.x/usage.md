<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Lets editors store presentation values (colours, sizes, custom properties) as *tone* content entities and injects the resulting CSS onto entities that reference them.

---

A *tone type* (config bundle) is configured with three plugins: an **identity** (how the CSS selector/identifier is derived — Hash or EntityUuid), a **renderer** (how field values become CSS — Single CSS Property or a full declaration block), and an **attachment strategy** (inline `<style>`, or a generated public-files CSS asset). Tone content entities of that type hold the actual field values. `hook_entity_extra_field_info` + `tone_entity_view_alter` expose a "Tone From X" extra field on referencing entities' displays; when placed, the referenced tone renders its CSS scoped to a selector and attaches it to the build. Renderers sanitise values (stripping `{ } ;`) before composing declarations.

**Security note (by design):** the module's purpose is to let editors inject front-end CSS, which the README flags as inherently dangerous. Value renderers sanitise CSS separators (`src/Plugin/ToneRenderer/CssProperty.php:150`), but CSS injection remains a permission-gated capability. Access is controlled by `administer tone types` (`restrict access: true`) and `create/edit/delete/view tone` permissions; grant create/edit only to trusted roles. No anonymous or mutating endpoints beyond the standard permission-gated entity routes.

Setup: enable the module, create a tone type and pick its identity/renderer/attachment plugins and fields, add a tone entity-reference field to a content type, then drag the "Tone From …" extra field into the view-mode display.

---
- Store an editor-chosen colour as a tone entity.
- Apply a stored colour to elements via a CSS custom property.
- Render a single CSS property from a field value.
- Render a full CSS declaration block from fields.
- Attach generated CSS inline in a `<style>` tag.
- Write generated CSS to a public-files asset instead of inline.
- Derive the CSS selector/identifier from a hash.
- Derive the identifier from the entity UUID.
- Curate a list of tones for editors to pick from via an entity reference.
- Create/edit tones inline from the referencing entity form (with Inline Entity Form).
- Scope injected CSS per view mode.
- Restrict tone-type administration to trusted roles (restrict access).
- Restrict who can create/edit tones to limit CSS injection.
- Add a custom renderer plugin (ToneRenderer attribute/annotation).
- Add a custom attachment strategy plugin.
- Add a custom identity plugin.
- Translate tone entities (translatable content entity).
- Track tone revisions (revisionable, revision UI enabled).
- List and manage tones at `/admin/content/tone`.
