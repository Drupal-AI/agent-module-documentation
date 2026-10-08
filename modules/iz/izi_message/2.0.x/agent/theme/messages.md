# How messages become toasts (theme + JS pipeline)

Izi Message does not add a message API of its own. It hijacks core's
`status_messages` render element so anything already queued in
`\Drupal::messenger()` is emitted as an iziToast toast instead of the usual
in-page message block.

## Render pipeline

1. **`hook_element_info_alter`** (`izi_message.module`) replaces the `#pre_render`
   of the core `status_messages` element with
   `['\Drupal\izi_message\IziMessage::generatePlaceholder']`.
2. **`IziMessage::generatePlaceholder($element)`** (`src/IziMessage.php`, extends
   `Drupal\Core\Render\Element\RenderElement`) builds a `#lazy_builder` /
   `#create_placeholder` pointing at `IziMessage::renderMessages`, passing
   `$element['#display']`. When `#include_fallback` is set it also emits the
   core `<div data-drupal-messages-fallback class="hidden">` marker.
3. **`IziMessage::renderMessages($type = NULL)`** pulls the messages:
   - `$type` given → `\Drupal::messenger()->deleteByType($type)`
   - otherwise → `\Drupal::messenger()->deleteAll()`
   and, if any exist, returns a render array with `#theme => 'izi_message'`,
   `#message_list` (messages grouped by type), `#status_headings`, and
   `#attached['library'] => ['izi_message/izi_message']`.
4. **Theme hook `izi_message`** (`hook_theme`) renders
   `templates/izi-message.html.twig`: a `<div data-izi-messages style="display:none">`
   containing one hidden `<div data-izi-message data-type="{type}" data-title="{Type}">{{ message }}</div>`
   per message. `status` is mapped to iziToast's `success` type; `error`/`warning`
   pass through. `{{ message }}` renders the messenger's markup as-is (Twig treats
   the messenger `Markup` objects as safe, exactly like core's status-messages
   template).
5. **`Drupal.behaviors.iziMessage`** (`js/izi_message.js`) finds every
   `div[data-izi-message]`, reads its `dataset.type`, `dataset.title` and
   `innerHTML`, calls `iziToast[type](Object.assign(settings.iziMessage, {title, message}))`,
   then removes the source div. `settings.iziMessage` is the whole config object.

## Global options → drupalSettings

**`hook_preprocess_page`** copies `izi_message.settings` (minus `_core`) into
`$variables['#attached']['drupalSettings']['iziMessage']`, so the JS in step 5
applies your configured position/timeout/theme/animations to every toast. See
[../configure/settings.md](../configure/settings.md).

## Libraries

`izi_message.libraries.yml` defines two libraries:

| Library | Contents | Depends on |
|---------|----------|------------|
| `izi_message/izi_message` | `css/izi_message.css`, `js/izi_message.js` | `izi_message/iziToast` |
| `izi_message/iziToast` | `/libraries/iziToast/dist/css/iziToast.min.css`, `/libraries/iziToast/dist/js/iziToast.min.js` (v1.4.0, Apache-2.0) | — |

The iziToast library is **not** bundled. `hook_requirements` in
`izi_message.install` reports `REQUIREMENT_ERROR` until
`libraries/iziToast/dist/js/iziToast.min.js` is present; download it from
`https://github.com/marcelodolza/iziToast` into `/libraries/iziToast`.

## Overriding

- Override the toast markup by providing your own `izi-message.html.twig` (theme
  hook `izi_message`, variables `message_list`, `status_headings`).
- To change how options reach the JS, note they come straight from the config
  object via `hook_preprocess_page`; there is no alter hook.
- `src/Utility/HelpTemplate.php` only builds the `help.page.izi_message` output
  (used when the `markdown` module is absent); it is unrelated to message rendering.
