<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# bamboo_token

`bamboo_token(token, data = {}, options = {})` — class `Token`, service
`bamboo_twig_token.twig.token`. Wraps `\Drupal::token()->replace("[$token]", $data, $options)`.

Pass the token **without** the surrounding brackets — the function adds them. `data` supplies the
objects some tokens need (e.g. `{'node': node}`); `options` are token-replace flags (e.g.
`{'clear': true}`).

```twig
{{ bamboo_token('site:name') }}                     {# site name; no data needed #}
{{ bamboo_token('site:url') }}
{{ bamboo_token('node:title', {'node': node}) }}
{{ bamboo_token('user:mail', {'user': user}, {'clear': true}) }}
```

Returns the replaced string. Unknown/uncleared tokens are left as-is unless `{'clear': true}` is
passed.
