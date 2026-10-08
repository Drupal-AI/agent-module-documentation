<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Plugin type: `mask_field_widget`

Mask decides which field widgets can carry a mask through a **YAML-discovered plugin type**,
managed by `plugin.manager.mask_field_widget`
(`Drupal\mask\Plugin\FieldWidgetPluginManager`). Discovery reads every module's
`<module>.mask_field_widgets.yml` (`YamlDiscovery('mask_field_widgets', ...)`).

## Declaring supported widgets

The plugin **id is the field widget plugin id** you want to mask. Mask's own
`mask.mask_field_widgets.yml`:

```yaml
string_textfield: {}
telephone_default: {}
```

To let another module's (or a core) widget support masks, ship in *your* module a file
`mymodule.mask_field_widgets.yml`:

```yaml
# Enable masking on the "email_default" widget, for example.
email_default: {}
```

That is usually all you need — each entry uses the default plugin class
`Drupal\mask\Plugin\FieldWidgetPlugin` and default option set:

```php
'element_parents' => ['value'],   // where in the widget element the #mask goes
'defaults' => ['value' => '', 'reverse' => FALSE,
               'clearifnotmatch' => FALSE, 'selectonfocus' => FALSE],
'class' => 'Drupal\\mask\\Plugin\\FieldWidgetPlugin',
```

## Customising behaviour

Override `element_parents` (if the widget's text input is nested somewhere other than
`['value']`) or point `class` at your own subclass of `FieldWidgetPlugin` implementing
`FieldWidgetPluginInterface` (`getWidgetType()`, `getFieldWidgetThirdPartySettings()`,
`fieldWidgetThirdPartySettingsForm()`, `fieldWidgetSettingsSummaryAlter()`,
`fieldWidgetFormAlter()`). The three `hook_field_widget_*` implementations in `mask.module`
look up the plugin by the widget's plugin id and delegate to these methods, so registering the
id is what makes "Mask settings" appear on that widget's cog.

> Note: the README calls the file `*.mask_widget_types.yml`, but the discovery name is
> **`mask_field_widgets`** — the file must be `<module>.mask_field_widgets.yml`.
