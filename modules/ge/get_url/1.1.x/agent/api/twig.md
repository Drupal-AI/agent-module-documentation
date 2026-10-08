<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Twig API — get_url

## Function
```twig
{{ get_url('/node/42') }}
```
Returns the URL **alias** for the given internal path, or an empty string.

## Signature
`get_url(string $nodeId): \Drupal\Core\Render\Markup|string`

Registered by `Drupal\get_url\TwigExtension::getFunctions()` with `['is_safe' => ['html']]`.

## Input rules (`src/TwigExtension.php::getUrl`)
- Must be a string matching `^/[a-zA-Z_-]+/\d+$` — e.g. `/node/42`, `/article/12`, `/taxonomy_term/5`. Anything else → `''`.
- Resolved via `path_alias.manager::getAliasByPath($nodeId)`.
- If the resolved alias is external (`UrlHelper::isExternal`) → `''` (guard against alias-to-external).
- Result is `Html::escape()`'d, then wrapped in `Markup::create()`.

## Notes for agents
- This does **not** load an entity or fetch a remote URL; it only maps a path to its alias string. No SSRF surface.
- Because it returns the *alias* (not a full `Url`), concatenate with the scheme/host yourself if you need an absolute URL.
- Pass the numeric id yourself: `{{ get_url('/node/' ~ node.id) }}`.
