<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The Mautic form field, formatter & widget

## Entities & fields (config)

Two bundles are provided (see [config/settings.md](../config/settings.md) for how/when each is
installed):

**Paragraph type `mautic`** (`config/optional/paragraphs.paragraphs_type.mautic.yml`):

| Field | Type | Purpose |
|---|---|---|
| `field_mautic_title` | string | Optional heading shown above the form. |
| `field_mautic_text` | text (text_default) | Optional intro/body text. |
| `field_mautic_formid` | **list_integer** | The selected Mautic form id (the embed target). |
| `field_mautic_layout` | list (hidden by default) | Layout/style choice → CSS class. |

**Block type `mautic_block`** (`config/install/block_content.type.mautic_block.yml`): analogous
fields `field_mautic_block_title` (string), `field_mautic_block_text` (text), and
`field_mautic_block_formid` (**list_integer**).

The two `*_formid` **field storages** are `list_integer` with an empty `allowed_values` and
`allowed_values_function: mautic_paragraph_form_list`. That callback (in `mautic_paragraph.module`)
calls `mautic_paragraph_api->getList()` and maps each Mautic form to `id => name`, so the select
options ARE the live Mautic form list.

## Formatter `mautic_form_list`

`src/Plugin/Field/FieldFormatter/MauticFormatter.php` (label "Mautic Formid list",
`field_types = { list_integer }`). Selected on *Manage display* for the form-id field (it is the
default formatter in both bundles' view displays).

`viewElements()`:

1. `$url = $this->mauticParagraphApi->getServerUri();` — the admin-configured Mautic base URL.
2. For each item, build `['#theme' => 'mautic_field_formatter', '#id' => $item->value,
   '#base_url' => $url]`.
3. Adds `#cache` tags: `config:mautic_paragraph.settings` merged with the entity's own tags.

The theme hook `mautic_field_formatter` (registered in `hook_theme`) renders
`templates/mautic-field-formatter.html.twig`, whose entire body is:

```twig
<script type="text/javascript" src="{{ base_url }}/form/generate.js?id={{ id }}"></script>
```

So the embed is a single client-side `<script>` that loads Mautic's own `form/generate.js`
generator for the selected form id from the configured Mautic instance. `base_url` is
admin-configured (resolved via `Url::fromUri()` in the connector's `getServerUri()`); `id` is a
`list_integer` value the editor picked from the Mautic form list. Both are passed as theme
variables and Twig-autoescaped.

## Widget `autocomplete_mautic`

`src/Plugin/Field/FieldWidget/AutocompleteWidget.php` (label "Autocomplete mautic forms list",
`field_types = { list_integer }`). An alternative to the default options select. On the bundle's
*Manage form display* you can choose this widget so editors type-ahead by form name instead of
scanning a select list.

- `formElement()` renders a textfield with `#autocomplete_route_name =
  mautic_paragraph.autocomplete.forms`; if a value exists it prefills `"<Form name> (<id>)"` via
  `mauticParagraphApi->getFormTitle($value)`.
- `massageFormValues()` extracts the integer id from the `"name (id)"` string using
  `EntityAutocomplete::extractEntityIdFromAutocompleteInput()`, so the stored value stays a plain
  integer.

## Autocomplete endpoint

Route `mautic_paragraph.autocomplete.forms` →
`/admin/mautic_paragraph/autocomplete/forms` → `FormAutocompleteController::handleAutocomplete()`
(`_format: json`, permission `access content`). Reads `?q=`, runs it through `Xss::filter()`,
calls `mauticParagraphApi->getList($input)` and returns `[{label: name, value: "name (id)"}, …]`.
The form list is cached (see the `cache` setting), so the endpoint normally reads from cache
rather than hitting Mautic on every keystroke.

## Rendering & layout

`hook_ENTITY_TYPE_view_alter` (`mautic_paragraph_paragraph_view_alter`) runs for the `mautic`
paragraph: if `field_mautic_layout` + title + text are set it adds
`p--view-mode--<layout>` / `p-mautic--view-mode--<layout>` wrapper classes and attaches the
`mautic_paragraph/mautic-layout` CSS library (image-left/right/full styling). The paragraph
template `templates/paragraph--mautic.html.twig` prints the title/text inside a
`.paragraph-mautic-info` div followed by `content.field_mautic_formid` (the script embed). Admin
form-widget alters attach `mautic_paragraph/admin_mautic_layout` (a colorpicker/JS lib) to the
layout field in the paragraph edit UI.
