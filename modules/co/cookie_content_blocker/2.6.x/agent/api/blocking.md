<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Block content programmatically

Three entry points, all funnelling through the same element processors and the
`cookie_content_blocker_wrapper` theme wrapper.

## 1. The `#cookie_content_blocker` render-array property

`hook_element_info_alter` adds the pre-render callback
`cookie_content_blocker.element.processor:processElement` to **every** element type. Add the property
to any render array to block it:

```php
// Block with defaults (uses global settings).
$build['embed'] = [
  '#type' => 'markup',
  '#markup' => $iframe_html,
  '#cookie_content_blocker' => TRUE,
];

// Block with per-element overrides.
$build['embed']['#cookie_content_blocker'] = [
  'blocked_message' => $this->t('Accept marketing cookies to view this map.'),
  'button_text'     => $this->t('Show map'),
  'show_button'     => TRUE,
  'category'        => 'marketing',   // a cookie_content_blocker_category id
  'preview'         => [ /* render array shown behind the message */ ],
];
```

`DefaultProcessor` fills unset keys from `cookie_content_blocker.settings`; `CategoryProcessor` fills
from the named category config entity (and adds it as a cacheable dependency); `AttachedProcessor`
routes any `#attached['library']` through the blocked-library manager so those assets are withheld
too. The wrapper moves the rendered content into a `<script type="text/plain">` and renames inner
`<script>` → `<scriptfake>` so browsers do not fetch it until the front-end JS restores it.

## 2. The text filter tag

In text that passes the `cookie_content_blocker_filter`:

```html
<cookiecontentblocker data-settings="eyJjYXRlZ29yeSI6Im1hcmtldGluZyJ9">
  <iframe src="https://www.youtube.com/embed/…"></iframe>
</cookiecontentblocker>
```

`data-settings` is base64- or plain-JSON (`{"category":"marketing","blocked_message":"…"}`), decoded
via `Xss::filter(…, [])` + `json_decode`. The inner HTML is wrapped with `#cookie_content_blocker` and
rendered with `renderer->renderPlain()`. **The filter does not sanitize the wrapped HTML itself** — it
relies on the format's other filters, so only enable it on formats whose HTML is already restricted or
authored by trusted roles.

## 3. Extend: custom element processor

Register a service tagged `cookie_content_blocker_element_processor` implementing
`ElementProcessorInterface` (extend `ElementProcessorBase`, which is a `TrustedCallbackInterface`).
The `ElementProcessor` collector runs each processor whose `applies($element)` returns TRUE, in
service order. Example service:

```yaml
services:
  my_module.ccb_processor:
    class: Drupal\my_module\MyProcessor
    tags:
      - { name: cookie_content_blocker_element_processor }
```

## Front-end settings

`drupalSettings.cookieContentBlocker` carries `consentAwareness` (global) and
`categories[<id>].consentAwareness`. The JS (`js/cookieContentBlocker.js`, using `js_cookie`) reads
the configured cookie/event signals and, on consent, replaces the placeholder with the real content
(restoring `<scriptfake>` → `<script>`).
