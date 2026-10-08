# Configuring lang_dropdown

There is **no dedicated settings form**. The module's `configure` route is
`block.admin_display` (core's Block layout). You configure everything by placing the
**Language dropdown switcher** block and editing its block form, or by writing the
`block.block.{id}` config entity directly.

## Place the block (drush)

The block plugin id is `language_dropdown_block:language_interface` (see
[plugins/lang_dropdown.md](../plugins/lang_dropdown.md) for the derivative naming).

```php
drush php:eval '
\Drupal::entityTypeManager()->getStorage("block")->create([
  "id" => "mysite_langdropdown",
  "theme" => "olivero",
  "region" => "sidebar",
  "plugin" => "language_dropdown_block:language_interface",
  "settings" => [
    "id" => "language_dropdown_block:language_interface",
    "label" => "Choose language",
    "label_display" => "visible",
    "widget" => 2,        // Chosen
    "display" => 1,       // native language name
    "width" => 200,
    "showall" => 1,
    "hide_only_one" => 1,
  ],
])->save();
'
```

Unspecified keys fall back to the plugin's `defaultConfiguration()` (below), so a minimal
`settings` array is enough. Inspect a placed block with
`drush config:get block.block.mysite_langdropdown`.

## Settings keys (block `settings` mapping)

Schema: `block.settings.language_dropdown_block:*` (`config/schema/lang_dropdown.schema.yml`).

| Key | Type | Default | Meaning |
|---|---|---|---|
| `showall` | bool | `0` | List every enabled language even without a translation (missing ones redirect home). |
| `hide_only_one` | bool | `1` | Hide the block when only one language is available. |
| `tohome` | bool | `0` | Redirect to the front page when the language is switched. |
| `width` | int | `165` | Width of the dropdown element, in px. |
| `display` | int | `1` | Language label format — see below. |
| `widget` | int | `0` | Output type / widget style — see below. |
| `msdropdown` | mapping | see defaults | Options for the msDropdown widget (`visible_rows`, `rounded`, `animation`, `event`, `skin`, `custom_skin`). |
| `chosen` | mapping | see defaults | Chosen widget options (`disable_search`, `no_results_text`). |
| `ddslick` | mapping | see defaults | ddSlick widget options (`ddslick_height`, `showSelectedHTML`, `imagePosition`, `skin`, `custom_skin`). |
| `languageicons` | mapping | `{flag_position: 1}` | Flag position when Language Icons is enabled (0 before, 1 after). |
| `hidden_languages` | sequence | `[]` | Per-role map of language codes to hide from the dropdown. |

### `display` — language label format
- `0` Translated into current language
- `1` Language native name  *(default)*
- `2` Language code
- `3` Translated into target language

### `widget` — output type
- `0` Simple HTML select  *(default; no JS library needed)*
- `1` Marghoob Suleman msDropdown (needs the msDropdown JS library)
- `2` Chosen (needs the Chosen JS library)
- `3` ddSlick (needs the ddSlick JS library)

## `defaultConfiguration()` (baseline merged into every block)

```
showall=0, hide_only_one=1, tohome=0, width=165, display=1, widget=0,
msdropdown={visible_rows:5, rounded:1, animation:'slideDown', event:'click', skin:'ldsSkin', custom_skin:''},
chosen={disable_search:1, no_results_text:'No language match'},
ddslick={ddslick_height:0, showSelectedHTML:1, imagePosition:'left', skin:'ddsDefault', custom_skin:''},
languageicons={flag_position:1},
hidden_languages={}
```

## Language detection

The dropdown only switches what core's language negotiation exposes. Configure detection
at **Configuration > Regional and language > Languages > Detection and selection**
(`/admin/config/regional/language/detection`) so the URL/language changes take effect.
