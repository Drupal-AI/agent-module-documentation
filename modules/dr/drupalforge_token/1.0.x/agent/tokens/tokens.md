<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The `drupalforge` token

## Install & enable

```bash
composer require drupal/drupalforge_token
drush en drupalforge_token -y
```

No dependencies, no permissions, no configuration form. Enabling the module makes the token available.

## The token

- **Group / type:** `drupalforge`
- **Token:** any **numeric** template id, e.g. `[drupalforge:71]`, `[drupalforge:12]`.
- **Where the id comes from:** it is the Drupal Forge template id you want to launch. `71` is Drupal
  CMS (the JS default when no id is present). Pick the id from drupalforge.org for the template you want.

There is **no `hook_token_info()`**, so these tokens are *dynamic* — they will **not** show up in a
token browser ("Browse available tokens"). Type the token by hand; only numeric ids are recognized.

## What it outputs

`TokenHooks::tokens()` (`src/Hook/TokenHooks.php`) matches `$type == 'drupalforge'` and, for each
numeric token key `$template`, renders and returns:

```html
<webform-component host="https://www.drupalforge.org" templateid="71"></webform-component>
```

built as a core render array:

```php
[
  '#type' => 'html_tag',
  '#tag'  => 'webform-component',
  '#attributes' => [
    'host'       => 'https://www.drupalforge.org', // hard-coded
    'templateid' => $template,                      // the numeric token key
  ],
  '#attached' => ['library' => ['drupalforge_token/webform-component']],
]
```

The `host` attribute is a fixed literal; `templateid` is always the numeric token key
(`is_numeric($template)` guards it). Non-numeric tokens are left untouched.

## Where to use it

Anywhere Drupal runs token replacement **and** the result is rendered as markup: node/body or other
long-text field values whose text format runs the *Replace tokens* filter (or via a contrib field/
widget that calls `\Drupal::token()->replace()`), token-aware blocks, or programmatic
`Token::replace($text, [], ...)` calls. Because the replacement is an HTML element, the surrounding
context must allow that markup (e.g. a *Full HTML*-class format, not a plain-text one).

Example body text (with a token-replacing text format):

```
Try this template live: [drupalforge:71]
```

## What happens in the browser

The attached library `drupalforge_token/webform-component` (`js/webform-component.js`) defines the
`webform-component` custom element (`class WebformComponent extends HTMLElement`). On
`connectedCallback()` it:

1. Reads `host` and `templateId` attributes (falls back to `71` = Drupal CMS).
2. Checks a `template_<id>` cookie for an in-progress application; if found, re-fetches
   `<host>/submission/<id>?embed=1`.
3. Otherwise fetches `<host>/form/starshot-quickstart?embed=1&template=<id>`, rewrites relative asset
   URLs to absolute (`correctResourceUrl()`), and injects the returned HTML.
4. Wires up the embedded quickstart form: submit handler (POSTs the form back to Drupal Forge),
   username/password copy buttons, optional reCAPTCHA, a provisioning countdown, and an
   "app ready" poll that reloads when the launched site is up.

All fetches target the hard-coded `https://www.drupalforge.org` host; the module contributes no
server-side HTTP. The widget renders styled inline (max-width ~494px card) via injected CSS.

## Notes / caveats

- **Not a token-browser token** — no `hook_token_info()`, so it is invisible to the UI token picker.
- **Requires a markup-allowing, token-processing context** — in a plain-text field the raw
  `[drupalforge:NN]` string will show instead of a widget.
- **Third-party embed** — the rendered widget loads content and a form from drupalforge.org; it only
  works when that service is reachable, and the launch flow is served entirely by Drupal Forge.
