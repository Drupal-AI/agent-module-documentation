<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Rendering: template, MicroModal init, `{{ styles|raw }}` & libraries

The module contributes markup through **one** Twig template and one help hook; the JS options and the
`{{ styles|raw }}` design block are actually assembled by **ept_core** at view time (this module has
no preprocess of its own, and — unlike some siblings — no `theme_registry_alter`; the single template
uses the `paragraph__ept_micromodal__default` bundle suggestion that Paragraphs already provides).

## Hook (`Drupal\ept_micromodal\Hook\EptMicromodalHooks`)

Autowired via `ept_micromodal.services.yml`; `ept_micromodal.module` keeps a thin `#[LegacyHook]`
wrapper.

| Hook | Method | Effect |
|---|---|---|
| `hook_help` | `help()` (`src/Hook/EptMicromodalHooks.php:18`) | Returns the About text for `help.page.ept_micromodal` (module description + links to the Micromodal.js project). No rendering side effects. |

## Template `templates/paragraph--ept-micromodal--default.html.twig`

Builds the `paragraph ept-paragraph ept-micromodal-paragraph paragraph--type--… paragraph-id-<id>`
classes and sets the wrapper `<div id="paragraph-id-<id>">` (the id the JS matches on), then
`attach_library('ept_micromodal/ept_micromodal')`. Layout:

1. **Page title** — `field_ept_title` printed inside a wrapper chosen from
   `field_ept_settings…title_options.title_wrapper` (`h1`–`h5`, `none`, or default `h2`); when
   `title_options.strip_tags` is set it is `render`ed then `striptags('<span><br><i><img><svg>')`ed
   and printed `|raw` (matches the shared EPT title pattern — the field is already text-format
   filtered by `check_markup`).
2. **Trigger** — from `field_ept_settings.0['#ept_settings']['button_type']`: `button` →
   `<button data-micromodal-trigger="modal-micromodal-paragraph-id-<id>" aria-controls="…">`, else an
   `<a data-micromodal-trigger="…" href="javascript:;" aria-controls="…">`; label is
   `button_text`. (Auto-escaped — no `|raw`.)
3. **Modal** — `<div class="modal micromodal-slide" id="modal-micromodal-paragraph-id-<id>"
   aria-hidden="true">` with `modal__overlay` / `modal__container[role=dialog]`. Header prints
   `field_ept_micromodal_title` as `<h2 class="modal__title">`; the header "X" button
   (`modal__close`) is emitted only when `display_close_icon == 1` **or** the key is not defined.
   `<main class="modal__content">` prints `field_ept_text` (the body). Footer prints a
   `<button class="modal__btn" data-micromodal-close>` labelled `close_button_text`.
4. `content|without('field_ept_settings', 'field_ept_text', 'field_ept_micromodal_title', 'field_ept_title')`
   prints any remaining fields, then the template ends with `{{ styles|raw }}`.

All the `data-micromodal-trigger` / `id` / `aria-controls` values are derived from the integer
`paragraph.id()`, so no request data reaches the DOM ids.

### `{{ styles|raw }}`

`styles` is set by ept_core's `hook_preprocess_paragraph` (`EptCoreHooks::preprocessParagraph`) to the
string returned by the `ept_core.generate_css` service (`GenerateCSS::generateFromSettings`). That
service builds a `<style>.paragraph-id-<id>{ … }</style>` block from the paragraph's **design_options**
only (margins/border/padding/background/etc.) and passes each value through `Html::escape()`. The
design values come from the (privileged) editor's Settings tab; no request data reaches this block.

## MicroModal initialisation

1. At view time, ept_core's `hook_ENTITY_TYPE_view` (`EptCoreHooks::paragraphView`) — because the
   widget stored `pass_options_to_javascript = TRUE` — attaches
   `drupalSettings[<camelBundle>]['paragraph-id-<id>'] = ['paragraphClass' => 'paragraph-id-<id>', 'options' => <ept_settings>]`.
   For the `ept_micromodal` bundle the camelCased key is **`eptMicromodal`**.
2. `js/ept-micromodal.js` (`Drupal.behaviors.eptMicromodal`) uses `once('ept-micromodal-paragraph-once',
   '.ept-micromodal-paragraph', context)` and, for each element, calls
   `MicroModal.init({ disableScroll: drupalSettings.eptMicromodal[el.id].options.disable_scroll })`.
   `disable_scroll` is the only stored option read by the JS; all other trigger/close behavior is
   pure markup + Micromodal's own `data-micromodal-*` attribute wiring.
3. The Micromodal engine itself is the vendored `/libraries/micromodal/dist/micromodal.min.js` (from
   the `levmyshkin/micromodal` composer package), declared in the library below.

## Libraries (`ept_micromodal.libraries.yml`)

`ept_micromodal/ept_micromodal`:
- JS: `/libraries/micromodal/dist/micromodal.min.js` (external lib) + `js/ept-micromodal.js`.
- CSS (component): `css/ept-micromodal.css` (the `.modal*` styles and slide/fade keyframes).
- Dependencies: `core/drupal`, `core/once`, `core/drupalSettings`.

If the Micromodal library file is missing from `/libraries/micromodal/dist/`, the modal will not
initialise (only Drupal's own `js/ept-micromodal.js` loads; `MicroModal` is undefined).
