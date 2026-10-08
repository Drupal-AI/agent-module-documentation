<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Tone — configuring tone types and reference fields

**1. Create a tone type** at `/admin/structure/tone_types/add`. Choose:
- **Identity** — `Hash` or `EntityUuid`: determines the CSS selector/identifier scoping the injected rules.
- **Renderer** — `Single CSS Property` (`tone_css_property`: one/more property names + a value field) or `CSS Declaration Block`.
- **Attachment strategy** — `CssInline` (a `<style>` tag on the build) or `CssPublicFiles` (a generated CSS file in `public://`).
- Add fields to the tone type (e.g. a colour or text field) to source the values.

**2. Create tones** at `/tone/add/{tone_type}` (or inline, see below) and fill the value fields.

**3. Reference tones from content:** add an entity-reference field targeting the `tone` entity type to a content type, and set its widget. With `inline_entity_form` enabled, editors can create/edit/delete tones directly on the host form.

**4. Attach on display:** on the host content type's *Manage display* for the relevant view mode, drag the **Tone From X** extra field out of *Disabled* into the active region, and ensure the tone reference field's formatter is *Rendered entity*. The referenced tone then renders its CSS (via the type's renderer) scoped by the identity and attached by the strategy.

**Renderer value safety:** `CssProperty::sanitize()` trims and cuts the value at the first `{`, `}` or `;` before building `selector { prop: value }`. This blocks trivially breaking out of the declaration, but the feature is still deliberate CSS injection — keep `create tone`/`edit tone`/`administer tone types` on trusted roles only.
