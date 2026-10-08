# `[vvjp:FIELD]` tokens — first-row field values in Views text areas

`Drupal\vvjp\Hook\VvjpTokenHooks` registers a token namespace so you can print a rendered Views field
value inside a **header / footer / empty text** area of a VVJP-formatted display. In those areas the
normal Twig row tokens (`{{ title }}`) are not available; use `[vvjp:FIELD]` instead. Values are read
from the **first row** of the display's rendered fields.

## Forms

- `[vvjp:FIELD_NAME]` — rendered HTML of the field.
- `[vvjp:FIELD_NAME:plain]` — plain-text (stripped) value.

`FIELD_NAME` is the Views field machine name (e.g. `title`, `field_image`). Complex Views field
rewrites are not supported. To use these, the text area must have **"Use replacement tokens from the
first row"** enabled.

## Implementation

- `#[Hook('token_info')]` → `tokenInfo()` declares token **type `vvjp`** ("VVJP Parallax",
  `needs-data: 'view'`) with a single wildcard token `*` ("Field token").
- `#[Hook('tokens')]` → `tokens()` handles only `$type === 'vvjp'` and delegates to the shared
  resolver:

  ```php
  $this->tokenResolver->resolve('vvjp', $tokens, $data, $bubbleable_metadata, Parallax::class);
  ```

- The resolver is `vvj_core.token_resolver` (`Drupal\vvj_core\Service\TokenResolver`), injected via
  `@?vvj_core.token_resolver` — the `@?` makes it **nullable** so the container still compiles during
  the v1→v2 upgrade window before `vvj_core` is enabled. When it is `NULL`, `tokens()` returns `[]`
  (tokens resolve to empty) rather than erroring. Once `vvjp_update_10001` enables `vvj_core` and the
  container rebuilds, the real service is injected.

Cache metadata from the resolved field render is bubbled through the passed `BubbleableMetadata`.
Token replacement itself is unchanged from v1; only the resolution backend moved into `vvj_core`.
