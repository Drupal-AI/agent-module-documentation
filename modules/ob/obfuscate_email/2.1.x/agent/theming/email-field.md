<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Field template, Twig `rot13` filter, and the client-side reveal

The second obfuscation path is a field template that hides any field named `field_email`, plus the
JavaScript that both paths share.

## Theme hook & template

`hook_theme()` registers:

```php
'field__email' => ['base hook' => 'field', 'template' => 'field--email'],
```

So `templates/field--email.html.twig` is used to render a field whose machine name is
**`field_email`** (the `field--email` suggestion). Override it with Drupal's theme suggestion
system (copy into your theme). The template:

- For an anchor-rendered email (`item.content['#title']`): builds
  `{{ item.content['#title']|replace({'.': '/dot/', '@': '/at/'})|rot13() }}` into `data-mail-to`
  on an `<a href="#" data-replace-inner="">`.
- For a plain-text email (`item.content['#context'].value`): emits a `<span data-mail-to=…
  data-replace-inner="@email">@email</span>`.

## The `rot13` Twig filter

Provided by `src/Twig/Rot13Extension.php` (service `obfuscate_email.rot13.twig`, tagged
`twig.extension`). It registers a single Twig filter `rot13` mapped to PHP `str_rot13`. Usable in
any template: `{{ 'some string'|rot13 }}`.

## Client-side reveal (`js/obfuscate_email.js`)

Library `obfuscate_email/default` (js + `core/drupal`) is attached to **every page** via
`hook_page_attachments_alter()`. `Drupal.behaviors.obfuscateEmailField`:

1. Selects all `[data-mail-to]` elements (and `[data-mail-click-link]` for click mode).
2. `normalizeEncryptEmail()` runs ROT13 again (its own inverse) then reverses `/dot/`→`.` and
   `/at/`→`@`, and `Drupal.checkPlain`s the result.
3. For an `<a>`, sets `href = "mailto:" + address`; then replaces the inner placeholder
   (`data-replace-inner`) — empty/`"true"` means replace the whole text, otherwise replace just
   that token — with the real address, and removes the data-attributes.
4. In click mode it defers all of that until the element is clicked (and marks it `link-processed`).

## Consequences an agent should know

- The transform is symmetric: ROT13 is its own inverse, and `/at//dot/` are literal placeholders.
- Only fields literally named `field_email` get the template; rename-based theming or the text
  filter covers other cases.
- Everything depends on JavaScript — there is intentionally **no** non-JS fallback.
