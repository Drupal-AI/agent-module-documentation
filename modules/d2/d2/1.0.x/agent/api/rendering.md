<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# D2 rendering API

How to turn D2 source into an SVG from code, and how rendering is wired.

## Enable
`drush en d2` (and `d2_filter` if you want the text filter). Ensure the `d2` binary is installed — the
`consensus/php-d2` library expects it at `<vendor>/consensus/d2-cli/d2`. The README documents a Composer
`package`/`post-install-cmd` recipe to fetch a `terrastruct/d2` release into that path.

## The helper — `Drupal\d2\D2Helper` (`src/D2Helper.php`)

```php
use Drupal\d2\D2Helper;
$svg = (new D2Helper())->getSvg($d2_input, $d2_options = []);
```

`getSvg(string $d2_input, array $d2_options = []): string`:
1. Builds cache id `'d2:' . hash('sha256', $d2_input)`.
2. If present in the default cache bin (`\Drupal::cache()`), returns the cached SVG string.
3. On miss: collects extra flags via `\Drupal::moduleHandler()->invokeAll('d2_command_options')`, calls
   `(new \Consensus\PhpD2\D2())->generateSvg($d2_input, array_merge($command_options, $d2_options))`, stores the
   result in cache, returns it.

Note the cache is keyed only on the input string, not on `$d2_options` — two calls with the same source but
different options return the first cached SVG. Caching is unbounded/permanent (no expiry, no tags) until the
`cache` table/bin is cleared.

### Error handling
If the CLI process fails, the library throws `Symfony\Component\Process\Exception\ProcessFailedException`.
`getSvg()` catches it, logs the CLI stderr to the `d2` logger channel, then:
- if the current user lacks `view d2 diagram errors` → returns `''` (empty string, nothing rendered);
- otherwise → shows the error via `messenger()->addError()` (error interpolated through the `%error`
  placeholder) and returns `'<pre>' . $d2_input . '</pre>'`.

## Uncached / direct render — `Consensus\PhpD2\D2::generateSvg()`
`getSvg()` wraps the library; call the library directly to skip Drupal caching:

```php
use Consensus\PhpD2\D2;
$svg = (new D2())->generateSvg($d2_input, $d2_options);
```

The library runs `[<path-to-d2>, "-", "-"]` merged with `array_filter($d2_options)` via Symfony Process, feeds
`$d2_input` on STDIN, and returns STDOUT. Arguments are passed as an argv array (not a shell string) and the
diagram source travels on STDIN. It resolves the binary path from the Composer `ClassLoader` vendor dir.

## Extending the CLI invocation — `hook_d2_command_options()`
Implement in any module to append global flags to every render (`d2.api.php`):

```php
function mymodule_d2_command_options() {
  return '--sketch';
}
```

Returned values from all implementations are merged (via `invokeAll`) ahead of the per-call `$d2_options`.

## Permission
- `view d2 diagram errors` (`d2.permissions.yml`, title "View D2 diagram errors") — only controls error
  visibility on a failed render, as described above. There is no separate "render diagrams" permission; who can
  supply D2 source is governed by whatever surface calls the helper (custom code, or the `d2_filter` text
  format's own permissions).
