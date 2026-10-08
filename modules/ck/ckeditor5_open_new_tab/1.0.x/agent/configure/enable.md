# Enabling & customizing

No settings form. The feature is active once the module is enabled and a text format uses CKEditor 5
with the core **Link** button.

## Enable

```bash
ddev drush en ckeditor5_open_new_tab -y
```

Then at *Admin → Configuration → Content authoring → Text formats and editors*, edit a CKEditor 5
format that has the **Link** toolbar button. Editors will see an **"Open in new window"** checkbox in the
link balloon/dialog; ticking it writes `target="_blank"` on the anchor.

## Make the `target` attribute survive filtering

If the format's **Limit allowed HTML tags and correct faulty HTML** filter is on, ensure the anchor is
allowed to carry `target`, e.g. include `<a href hreflang target>` in the allowed tags. Otherwise the
filter strips `target` on save/display and the new-tab behavior is lost. On unrestricted formats
(e.g. Full HTML) no change is needed.

## Mechanism (for customization / replication)

`ckeditor5_open_new_tab_ckeditor5_plugin_info_alter()` clones the `ckeditor5_link` plugin definition and
overrides its `drupal.class` to
`Drupal\ckeditor5_open_new_tab\Plugin\CKEditor5Plugin\CKEditor5Link`. That subclass extends
`CKEditor5PluginDefault` and, in `getDynamicPluginConfig()`, appends to
`$static_plugin_config['link']['decorators']`:

```php
[
  'mode' => 'manual',
  'label' => t('Open in new window'),
  'attributes' => ['target' => '_blank'],
]
```

This is the standard CKEditor 5 [manual link decorator](https://ckeditor.com/docs/ckeditor5/latest/features/link.html)
pattern. To add more decorators (e.g. a `rel="noopener"` toggle) you would decorate/override the same
`getDynamicPluginConfig()` in a similar plugin-info-alter. There is no other API surface.
