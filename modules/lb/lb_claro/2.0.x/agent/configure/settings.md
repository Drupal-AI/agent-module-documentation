<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# lb_claro — configuration

The module has **no settings form** (`configure` is null). Its only configurable value is the
off-canvas tray's initial width.

## Config object

`lb_claro.settings` (schema `config/schema/lb_claro.schema.yml`, default in
`config/install/lb_claro.settings.yml`):

| Key | Type | Default | Meaning |
|---|---|---|---|
| `off_canvas_initial_width` | integer | `800` | Initial width (px) of the Layout Builder off-canvas dialog tray. |

Set it with drush:

```bash
ddev drush cset lb_claro.settings off_canvas_initial_width 960 -y
ddev drush cget lb_claro.settings off_canvas_initial_width
```

Or manage it through configuration export/import (`config/sync`) like any other config object.

## How the width is applied (off-canvas renderer decorator)

There is no runtime hook reading this value on a normal page. Instead the module swaps the core
off-canvas main-content renderer at container-build time:

- `Drupal\lb_claro\LbClaroServiceProvider` (implements `ServiceModifierInterface`) is discovered
  automatically (class name = `{CamelModule}ServiceProvider` in the module root). In `alter()` it
  takes core's `main_content_renderer.off_canvas` definition, sets its class to
  `Drupal\lb_claro\OffCanvasRenderer`, and appends two constructor arguments: the string `'side'`
  (the dialog position) and a reference to `@config.factory`.
- `Drupal\lb_claro\OffCanvasRenderer` extends core's `OffCanvasRenderer`. Its `renderResponse()`
  calls the parent, then — **if** the AJAX response's first command carries
  `dialogOptions.width` — overwrites that width with
  `lb_claro.settings:off_canvas_initial_width`.

Consequences worth knowing:
- The override only fires when core already produced a `dialogOptions.width` on `$commands[0]`
  (the standard off-canvas open command). It replaces, it does not add.
- Because the service is decorated globally, another module that also decorates
  `main_content_renderer.off_canvas` can conflict — last service provider to alter wins.
- Changing the value takes effect on the next off-canvas open after a cache rebuild is **not**
  required for the config read (it is read live via `config.factory` per response), but a container
  rebuild **is** required if you want to change the decoration itself.
