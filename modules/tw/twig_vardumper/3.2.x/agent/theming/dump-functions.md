# Using `dump()` / `vardumper()` in Twig

The module adds two **identical** Twig functions — `dump` and `vardumper` — available in any
Drupal `.html.twig` template once the module is enabled. Both call
`Symfony\Component\VarDumper\VarDumper::dump()` and produce the interactive `sf-dump` HTML widget.
`vardumper` exists as a distinct name in case another extension/theme already defines `dump`.

## The one hard requirement: Twig debug must be ON

Internally each call runs `if (!$env->isDebug()) { return FALSE; }`. So:

- **Twig debug enabled** → the functions render the VarDumper widget.
- **Twig debug disabled** (Drupal default) → they return `FALSE` and output **nothing**.

Enable Twig debug in dev by setting, in `sites/default/services.yml` (or a
`development.services.yml` included from `settings.php`):

```yaml
parameters:
  twig.config:
    debug: true
```

Then `drush cr`. (`drush -y config:set …` does not apply — `twig.config` is a container
parameter, not config; it lives in a services file and needs a cache rebuild.) This is why the
module is a *development* tool: leaving `{{ dump(...) }}` in a template is safe on prod because
debug is off there and nothing is emitted.

## Signatures

Both are **variadic** and marked `is_safe: ['html']` (output is not escaped):

```twig
{# Dump one variable #}
{{ dump(node) }}

{# Dump several at once #}
{{ vardumper(node, user, page) }}

{# Dump the ENTIRE current template context (no args) #}
{{ dump() }}
```

`needs_context` + `needs_environment` are set, so a no-argument call dumps the full template
context array; passing arguments dumps exactly those values instead.

## Typical usage (page.html.twig)

```twig
<header>{{ page.header }}</header>

{{ dump(page.content) }}      {# inspect the main content render array #}
{{ vardumper(page.content) }} {# same output, alternate name #}

{{ page.content }}
```

## Notes

- No configuration, permissions, or Drush commands — the whole surface is these two functions.
- Output is the `sf-dump` widget: expandable nodes, type colouring, and a search box.
- To render/inspect from PHP (e.g. in a test), see [../api/twig-extension.md](../api/twig-extension.md).
