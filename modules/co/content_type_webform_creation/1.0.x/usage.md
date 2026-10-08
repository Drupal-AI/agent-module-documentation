<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Content Type Webform Creation builds a Webform automatically from an existing node content
type, mapping each selected content-type field to an equivalent Webform element.

---

A three-step admin wizard under `/admin/config/content/webform-generator` drives it: pick a
content type, select which of its fields to include (`WebformFieldSelectForm`), preview the
generated elements (`WebformPreviewForm`), then create/update the Webform. `FieldMapperService`
maps each `field_config` to a Webform element render array and `WebformGeneratorService`
assembles and saves the Webform entity. All routes require **"administer site configuration"**.

Use it to bootstrap a Webform that mirrors a content type (e.g. turn an "Event" node type into
an event-submission form) instead of rebuilding every field by hand, then refine the result in
the normal Webform UI. Only node-bundle `field_config` fields are considered; deleted fields
are skipped.

---

- Generate a Webform from a node content type.
- Choose which content-type fields become form elements.
- Preview generated Webform elements before saving.
- Map field types to matching Webform element types.
- Create a new Webform from a bundle's fields.
- Update an existing Webform id from a content type.
- Skip deleted fields during generation.
- Bootstrap a submission form mirroring a content type.
- Turn an Event content type into an event form.
- Refine the generated Webform in the Webform UI afterwards.
- Save time versus rebuilding fields manually.
- Restrict generation to site administrators.
- Prototype a form quickly from an existing schema.
- Keep a webform aligned with a content type's fields.
- Select only a subset of fields for the generated form.
- Reuse the generator to regenerate after adding fields.
- Hand off a generated webform to editors for tweaks.
