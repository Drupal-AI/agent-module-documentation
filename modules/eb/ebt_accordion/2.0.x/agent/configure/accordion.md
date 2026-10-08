# Configure an accordion block

There is **no module settings page**. You add an instance of the `ebt_accordion` block type, add one
Paragraph per accordion section, and set the accordion behaviour in the block's **Settings** tab
(the `field_ebt_settings` widget). Shared design defaults (colours, breakpoints, container widths)
live on the EBT Core settings form, route `ebt_core.settings`
(`admin/config/content/ebt-settings`).

## Add and fill in a block

1. Create a block: `block/add/ebt_accordion` (or add it inline in Layout Builder). The default form
   display groups fields into **Content** and **Settings** tabs (`field_group`).
2. Under **Content**, add one or more Paragraphs (`field_ebt_accordion`). Each Paragraph
   (`ebt_accordion` type) has **Title / Question** (`field_ebt_accordion_title`) and
   **Text / Answer** (`field_ebt_accordion_text`); both are required formatted-text (`text_long`)
   fields — HTML allowed by the chosen text format is rendered, so you can put Font Awesome `<i>`
   icons or emphasis in the question.
3. Under **Settings**, set the accordion behaviour (below). Place the block in a region or Layout
   Builder as usual.

## Accordion behaviour settings (`ebt_settings_accordion` widget)

Defined in `src/Plugin/Field/FieldWidget/EbtSettingsAccordionWidget.php`; stored inside the
`field_ebt_settings` value under the `ebt_settings` key. The widget also forces
`pass_options_to_javascript => TRUE` (hidden), which is what makes `ebt_core` attach the options to
`drupalSettings` at view time.

| Key | Form type | Default | Meaning / jQuery UI mapping |
|---|---|---|---|
| `styles` | radios | `default` | Visual preset — `default`, `text_only`, `plus_minus_left`, `plus_minus_right`. Selects which preset CSS library the template attaches and adds an `ebt-accordion-<preset>` class. |
| `collapsible` | checkbox | `1` | jQuery UI `collapsible` — allows all panels closed at once. |
| `closed` | checkbox | — | Start with all panels closed (requires `collapsible`). JS sets `active: false`. |
| `opened` | checkbox | — | Start with all panels open (JS slides all headers open after init). Mutually exclusive with `closed`. |
| `closed_in_tablet` | checkbox | — | When `opened`, still collapse if viewport ≤ `drupalSettings.ebtCore.tabletBreakpoint`. Visible only when `opened` is checked. |
| `closed_in_mobile` | checkbox | — | Same, against `mobileBreakpoint`. (Note: source reads the `closed_in_tablet` value as this field's `#default_value`.) |
| `active` | number | — | jQuery UI `active` — zero-based index of the initially open panel; negative counts back from the last. Disabled when `closed`. |
| `disable` | checkbox | — | jQuery UI `disabled` — renders the accordion inert. |
| `heightStyle` | radios | `content` | jQuery UI `heightStyle` — `auto`, `fill`, or `content`. |

Design options inherited from the parent widget (`ebt_core` `ebt_settings_default`) also apply:
margins/borders/paddings (numeric-validated), border colour/style/radius, background colour/image/video,
edge-to-edge, container max width. See ebt_core docs.

## Runtime flow (config → JS)

1. `ebt_core`'s `hook_ENTITY_TYPE_view` (`EbtCoreHooks::blockContentView`) runs for every `ebt_*`
   bundle. Because `pass_options_to_javascript` is TRUE, it attaches
   `drupalSettings.ebtAccordion['block-revision-id-<id>']` and
   `drupalSettings.ebtAccordion['plugin-id-block-content<uuid>']`, each `{ blockClass, options }`
   where `options` is the stored `ebt_settings`. (`ebtAccordion` is the camel-cased bundle name.)
2. `ebt_core`'s `hook_preprocess_block` builds the `styles` CSS string via `ebt_core.generate_css`
   from the design options and sets it as the `styles` template variable.
3. The block template (`block--block-content--ebt-accordion.html.twig`) attaches
   `ebt_accordion/jquery_ui_accordion` plus the preset library matching `styles`, adds the block
   classes, and prints `{{ styles|raw }}` (machine-generated CSS from validated design values).
4. `Drupal.behaviors.ebtAccordion` (`js/jquery_ui_accordion/jquery_ui_accordion.js`) iterates
   `drupalSettings.ebtAccordion`, finds `.<blockClass> .ebt-accordion-wrapper`, translates the option
   keys above into jQuery UI options, calls `.accordion(options)`, and marks the block
   `accordion-added` so it initialises once.

## Set the widget from code

```php
\Drupal::service('entity_display.repository')
  ->getFormDisplay('block_content', 'ebt_accordion', 'default')
  ->setComponent('field_ebt_settings', [
    'type' => 'ebt_settings_accordion',
    'settings' => [],
  ])->save();
```

The behaviour values themselves are stored per block instance in `field_ebt_settings`, not in the
form-display config.
