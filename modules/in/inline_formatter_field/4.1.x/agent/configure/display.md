# Inline Formatter Display submodule

`inline_formatter_display` (package `display`, depends on `inline_formatter_field`) lets a template
**replace a whole entity view display** — no IFF field required. It is implemented entirely with
hooks and a **third-party setting on the entity view display**, so it produces no new routes,
services or entities.

## Authoring UI — `hook_form_entity_view_display_edit_form_alter`

On any *Manage display* form (`EntityViewDisplayEditForm`) the module adds:

- a checkbox **"Use Inline Formatter Display"** (`inline_formatter_display_use`);
- a `text_format` field **`inline_formatter_display_formatted_display`** (shown only to users with
  permission `edit inline formatter display formats`; others get a "no permission" message), forced
  to the configured default editor format, default value `<h1>Hello World!</h1>`;
- library `inline_formatter_display/display_form` plus wrapper markup that lets the JS toggle between
  the normal field table and this editor.

`inline_formatter_display_save` (unshifted onto the form's submit handlers) writes two third-party
settings on the `entity_view_display` config entity under provider `inline_formatter_display`:

- `use` (boolean),
- `formatted_display` = `{value, format}` (with `\r\n?` normalized to `\n`).

Schema: `core.entity_view_display.*.*.*.third_party.inline_formatter_display` (`use`,
`formatted_display.value`, `formatted_display.format`).

## Render — `hook_entity_view_alter`

When `use` is set on the display, `inline_formatter_display_entity_view_alter` (module.php:123):

1. Renders `formatted_display` via `#type => processed_text` (its filter format).
2. `token->replace($value, [<entity_type> => $entity], ['clear' => $clear_tokens])` — entity tokens
   are substituted into the string (`clear_tokens` read from the editor settings).
3. **Strips most of the default build**: it removes every top-level `$build` key that is not a `#`
   property and not in the allow-list `['title', 'links', 'created', 'uid', <label key>]`. So the
   template is expected to render the entity's content itself; only those keys survive alongside it.
4. `hook_inline_formatter_display_context_alter(&$context, $entity)` runs.
5. Appends `$build['inline_formatter_display'] = ['#type' => 'inline_template', '#template' =>
   $value, '#context' => [<entity_type> => $entity, 'current_user' => …]]`.

## Usage notes

- This is the maintainer-recommended way to change an entity's display without a theme/template file
  or a computed field.
- Because it unsets non-allow-listed build keys, enabling it on a display makes the template
  responsible for the visible output. Test each affected view mode/bundle after enabling.
- The context and token behaviour mirror the base formatter — see
  [../fields/formatter.md](../fields/formatter.md).
