<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Interact Chat block, `__widget` render element & template

Three ways to surface the widget, all producing the same container `<div>` and attaching the
`adaptive_interact_client/widget` external loader (see [../config/settings.md](../config/settings.md)).

## 1. The block plugin

`src/Plugin/Block/InteractWidgetBlock.php` — `InteractWidgetBlock extends BlockBase implements
ContainerFactoryPluginInterface`, declared with the `#[Block]` attribute:

- id `adaptive_interact_client_chat_block`
- admin_label *"Interact Chat Block"*
- category *"Adaptive Interact"*

Injected services (`create()`): `config.factory`, `current_user`, `entity_type.manager`,
`file_url_generator`.

`checkConfigured()` (private) returns FALSE unless both `server_url` and `widget_id` are set on
`adaptive_interact_client.settings`. When not configured, both `blockForm()` and `build()` short-circuit
with a bold "You need to set the server URL and widget ID…" message (`build()` restricts it with
`#allowed_tags => ['strong']`).

`blockForm()` per-instance settings (saved by `blockSubmit()` into `$this->configuration`):

| Key | Widget | Purpose |
|---|---|---|
| `widget_id` | textfield | Overrides the default widget ID for this placement; blank → site default. |
| `prompt` | textarea | One or more initial prompts (newline-separated) shown as choice bubbles. |
| `input_prompt_text` | **hidden** input | Overrides the user input-area placeholder text. |
| `button_type` | select | `icon` / `text` / `icon_text`. |
| `display_type` | select | `modal` (default) or `inline`. |
| `button_text` | textfield | Custom launch-button text. |

`build()` assembles a `$data` array (`buttonType`, `displayType`, and — only when non-empty — `prompt`,
`inputPromptText`, `buttonText`, `avatarUrl`) and returns:

```php
[
  '#theme' => 'adaptive_interact_client__widget',
  '#id'    => $this->configuration['widget_id'] ?: config('adaptive_interact_client.settings')->get('widget_id'),
  '#data'  => Json::encode($data),
]
```

`blockAccess()` returns `AccessResult::allowedIf(TRUE)` — the block relies on normal Block Layout
visibility/placement rather than its own access gate (there is a `@todo` to add a condition). It is a
public-facing chat launcher, so treat placement/visibility as the control.

## 2. The render element / theme hook

`adaptive_interact_client_theme()` (in `adaptive_interact_client.module`) registers
`adaptive_interact_client__widget` with variables `id` (NULL default) and `data` (NULL default). Use it
directly from code:

```php
$build['chat'] = [
  '#type' => 'adaptive_interact_client__widget',
  '#id'   => '123456789',                 // widget ID
  '#data' => '{"prompt":"Tell me about…"}', // JSON string
];
```

Template `templates/adaptive-interact-client--widget.html.twig`:

```twig
{{ attach_library('adaptive_interact_client/widget') }}
<div class="adaptive-interact-widget" data-aiw-id="{{ id }}" data-aiw="{{ data }}"
     tabindex="0" aria-label="Ask a question using our AI search tool"></div>
<div id="sr-announcer" class="visually-hidden" role="status" aria-live="polite" aria-atomic="true"></div>
```

`id` and `data` are printed into HTML attributes and Twig auto-escapes them; `data` is a JSON string of
admin/site-builder-supplied options. The remote loader script reads `data-aiw-id` / `data-aiw` and builds
the actual UI (button, modal/inline panel, prompt bubbles). Override this template in a theme to customize
markup. The `sr-announcer` live region supports accessible transcript announcements.

## 3. Manual placement in Twig

Any template can embed the widget directly:

```twig
{{ attach_library('adaptive_interact_client/widget') }}
<div class="adaptive-interact-widget" data-aiw-id="[widget-id]" data-aiw="[json-config]"></div>
```

## The avatar helper

`_adaptive_interact_client_get_avatar()` (in `.module`): if `avatar_field` is configured **and** the current
user is authenticated, it loads the user, and when that image field exists and is non-empty, returns the
file's absolute URL via `file_url_generator->generateAbsoluteString(...)`. `InteractWidgetBlock::build()`
adds it to the widget `data` as `avatarUrl` when present. Returns FALSE (omitted) otherwise. This exposes the
signed-in user's own avatar URL to the browser widget — no other user's data.

## Data keys the browser widget understands (per README)

`prompt`, `avatarUrl`, `buttonType` (`text`/`icon`/`icon_text`), `buttonText`. If you supply your own launch
button inside the container with class `aiw-modal--button--open`, `buttonType`/`buttonText` are unnecessary.
