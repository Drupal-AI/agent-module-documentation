<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Field Token Value adds a Field API field type whose stored value is produced from a configurable token string (e.g. `[node:title] — [node:changed]`) that is resolved and saved automatically on every entity save.

---

The module provides a `field_token_value` field type (with a `field_token_value_default` widget and a `field_token_value_text` formatter) plus a `token` dependency. You add the field to a bundle like any other field, then configure a **Field value** token string and a **Remove empty tokens** flag in the field's instance settings — the edit form shows a Token browser and no visible input, because the value is not typed by editors. On `hook_entity_presave`, the `field_token_value.field_value_generator` service (`FieldValueGenerator`) walks every field on the entity, and for each field provided by this module it runs `Token::replace()` on the configured string using the entity as the token context (mapped via `token.entity_mapper`), then writes the result into the field. The `field_token_value_text` formatter renders the stored string wrapped in an HTML tag chosen from a list of **wrappers**, and can optionally link the value to the entity. Wrappers are a small YAML plugin type: any module or theme ships an `EXTENSION.field_token_value.yml` file whose entries (`title`, `summary`, `tag`, optional `attributes`) are collected by the `field_token_value.wrapper_manager` (`WrapperManager`); the module itself defines common tags (`p`, `div`, `span`, headings, `blockquote`, `strong`, `no_tag`, …). Two alter hooks (`hook_field_token_value_output_alter`, `hook_field_token_value_wrapper_info_alter`) let other modules change the rendered output or the available wrappers.

---

- Build a "display title" field that combines several fields, e.g. `[node:title] ([node:field_year])`, for use in Views.
- Add a "last updated" line like `This page was last updated [node:changed]` without custom code.
- Concatenate first and last name tokens into a computed full-name field on a profile entity.
- Generate a machine-friendly slug-ish label from other field tokens on save.
- Produce a canonical heading string wrapped in an `<h2>` via the formatter's wrapper.
- Create a derived field that always mirrors another field's value through a token.
- Output a token-built string as a `<blockquote>` for a testimonial content type.
- Display a computed value linked to the entity by enabling the formatter's "Link" option.
- Keep an author byline field (`By [node:author]`) in sync automatically on every edit.
- Provide a Views-exposable text field assembled from multiple source fields.
- Add a static-plus-token sentence such as `Order #[commerce_order:order_number]` to an order entity.
- Strip out unresolved tokens by leaving "Remove empty tokens" enabled so empty replacements vanish.
- Keep empty token markers visible for debugging by disabling "Remove empty tokens".
- Define a project-specific wrapper (e.g. a `div` with a CSS class) in a `mymodule.field_token_value.yml` file.
- Render the computed value with no wrapper at all using the `no_tag` wrapper.
- Attach CSS/JS to a particular wrapper via `hook_field_token_value_output_alter()`.
- Rename or re-tag an existing wrapper's summary via `hook_field_token_value_wrapper_info_alter()`.
- Populate a summary/teaser text field from body and metadata tokens.
- Compose an SEO meta-description-style string from entity tokens for downstream use.
- Provide a read-only computed label on taxonomy terms or media entities (any fieldable entity).
- Standardise a naming convention across content by baking it into a token field.
- Avoid writing a custom computed-field plugin just to concatenate tokens into text.
- Feed a token-built string into other modules that read field values on the entity.
- Show a friendly "Filed under [node:field_category]" caption via the text formatter.
