<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Wrapper plugin type

The formatter's **Wrapper** option is backed by a lightweight YAML plugin type managed by
`field_token_value.wrapper_manager` (`WrapperManager`, a `DefaultPluginManager` using
`YamlDiscovery`). It is the only plugin type this module defines.

## Discovery

Any module or theme provides wrappers in a file named `EXTENSION.field_token_value.yml` in its
base directory. The manager also fires the alter `field_token_value_wrapper_info` (see
[hooks/hooks.md](../hooks/hooks.md)) and is cache-tagged `field_token_value`.

## Definition shape

```yaml
# mymodule.field_token_value.yml
my_callout:
  title: 'Callout box'          # option label in the formatter select
  summary: 'Wrap the value in a styled callout div'  # shown in the display summary
  tag: div                       # the HTML element used to wrap the value ('' = no tag)
  attributes:                    # optional; any HTML attributes
    class:
      - callout
      - callout--info
```

The module's own `field_token_value.field_token_value.yml` defines the built-ins:
`blockquote`, `div`, `em`, `h1`–`h6`, `i`, `p`, `pre`, `s`, `section`, `small`, `span`, `strong`,
`sub`, `sup`, and `no_tag` (empty tag → rendered as raw `#markup`, no wrapper).

## How the formatter uses it

`FieldTokenValueTextFormatter::viewElements()` looks up the selected wrapper via
`WrapperManager::getDefinition($id)`, sets the render element's `#tag` to `tag`, applies any
`attributes`, then invokes `hook_field_token_value_output_alter()`. An empty `tag` renders the
value as plain `#markup`. `WrapperManager::getWrapperOptions()` supplies the select options
(id → title).

## Reading wrappers programmatically

```php
$wm = \Drupal::service('field_token_value.wrapper_manager');
$options = $wm->getWrapperOptions();        // ['p' => 'p — Basic paragraph', ...]
$def     = $wm->getDefinition('blockquote'); // ['title'=>..., 'summary'=>..., 'tag'=>'blockquote', ...]
```

No PHP class is needed for a wrapper — it is pure YAML data.
