<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configure Simple Less & declare Less libraries

Simple Less has **no config entity or dedicated settings form**. It stores its four settings inside
core's `system.performance` config under an `ipless` mapping and adds its fields to the core
Performance form via `ipless_form_alter()`. `configure` route = `system.performance_settings`.

## The four settings (`system.performance` → `ipless.*`, all booleans)

| Key | Form label | Meaning |
|---|---|---|
| `ipless.enabled` | "Less compilation enabled" | Master switch. When off, the `less:` library key is stripped and nothing compiles. |
| `ipless.modedev` | "Less developer mode" | Recompile the current page's Less on every request. |
| `ipless.sourcemap` | "Enable SourceMap" | Emit source maps (dev mode only). |
| `ipless.watch_mode` | "Enable watch mode" | Live-refresh CSS in the browser without reload (dev mode only; attaches the `ipless/ipless.watching` library). |

`sourcemap` and `watch_mode` are only usable when `modedev` is checked (enforced with `#states`).

## Via the UI

1. Go to **Configuration → Development → Performance** (`/admin/config/development/performance`).
2. In the **Less CSS** fieldset (inside "Bandwidth optimization"), tick **Less compilation enabled**.
3. Optionally tick **Less developer mode**, then **Enable SourceMap** / **Enable watch mode**.
4. **Save configuration**. (The module's submit handler writes the whole `ipless` value to
   `system.performance`.)

## Via drush (scriptable)

```bash
# Enable compilation; turn on dev mode too:
drush cset system.performance ipless.enabled 1 -y
drush cset system.performance ipless.modedev 1 -y
drush cget system.performance ipless        # read the whole ipless mapping back
```

Or set the whole mapping in PHP:

```php
\Drupal::configFactory()->getEditable('system.performance')
  ->set('ipless', ['enabled' => TRUE, 'modedev' => FALSE, 'sourcemap' => FALSE, 'watch_mode' => FALSE])
  ->save();
```

By default (fresh install) the `ipless` key is **absent** from `system.performance`; the getters treat
missing as FALSE.

## Declaring Less files in a `*.libraries.yml`

```yaml
base:
  version: 1.0
  less:
    theme:
      css/styles.less: { output: css/gen/styles.css }
      css/foo.less: {}
```

When `ipless.enabled` is TRUE, `hook_library_info_alter()` compiles each `less` entry to
`public://ipless/{extension}-{library}--{file}.css` and injects it as the library's `css`. When
disabled it removes the `less` key (and the library entirely if it had no other `css`/`js`).

## Requirement

The `wikimedia/less.php` Composer package must be installed (provides the `Less_Parser` class). If it
is missing, the module adds a warning message and skips compilation.
