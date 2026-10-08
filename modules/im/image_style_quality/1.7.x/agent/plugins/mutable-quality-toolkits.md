# Plugin type: `mutable_quality_toolkits`

The module defines a YAML-discovery plugin type that maps each **image toolkit** to the config
object + key that holds its quality setting. This is how the effect knows what to override for the
active toolkit.

- Manager service: `image_style_quality.mutable_quality_toolkit_manager`
  (`MutableQualityToolkitManager`, extends `DefaultPluginManager`, uses `YamlDiscovery`).
- Discovery file name: `<module>.mutable_quality_toolkits.yml`.
- Alter hook: `hook_mutable_quality_toolkits_alter()` (via `alterInfo('mutable_quality_toolkits')`).
- `getActiveToolkit()` returns the definition for `system.image:toolkit` (the site's active toolkit).

## Shipped definitions

`image_style_quality.mutable_quality_toolkits.yml`:

```yaml
gd:
  config_object: system.image.gd
  config_key: jpeg_quality
imagemagick:
  config_object: imagemagick.settings
  config_key: quality
imagick:
  config_object: imagick.config
  config_key: jpeg_quality
```

Each key is the toolkit id; `config_object`/`config_key` is the config the effect overrides at
apply time with the style's `quality` value.

## Add support for another toolkit

Ship your own discovery file in a module, e.g. `mymodule.mutable_quality_toolkits.yml`:

```yaml
mytoolkit:
  config_object: mymodule.mytoolkit.settings
  config_key: output_quality
```

Or adjust existing definitions with:

```php
function mymodule_mutable_quality_toolkits_alter(array &$definitions) {
  $definitions['gd']['config_key'] = 'jpeg_quality';
}
```

The definition id must match the toolkit's plugin id so `getActiveToolkit()` resolves it from
`system.image:toolkit`.
