<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Appending lines with `hook_aitxt()`

The served `/ai.txt` file = the configured `aitxt.settings:content`, followed by lines contributed by any
module implementing `hook_aitxt()`. Contract is documented in `aitxt.api.php`.

## Signature
```php
/**
 * @return array  An array of strings to add to the ai.txt.
 */
function hook_aitxt(): array {
  return [
    'Disallow: *.foo',
    'Disallow: *.bar',
  ];
}
```

## How it is invoked
In `\Drupal\aitxt\Controller\AiTxtController::content()`:
`$this->moduleHandler->invokeAll('aitxt')` collects every implementation's returned array and
`array_merge`s it after the configured content. The combined lines are then `array_map('trim', …)`,
`array_filter`ed (empty lines dropped), and joined with `\n`. Each returned string becomes one raw line
of the `text/plain` output — no formatting is imposed, so return complete directive lines
(`Allow:` / `Disallow:` / `User-Agent:` etc.).

## Cache note
The response is tagged `aitxt` with context `url.site`. If your hook's output depends on state that can
change, invalidate the `aitxt` cache tag (`Cache::invalidateTags(['aitxt'])`) when that state changes so
the served file is regenerated.

Implement the hook in `MYMODULE.module` as `function MYMODULE_aitxt(): array { … }`.
