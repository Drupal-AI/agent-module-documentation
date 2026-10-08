# CKEditor 5 integration (configure)

The module ships a CKEditor 5 plugin that adds an **Address suggestion** toolbar button and a
matching autocomplete route for text fields.

- CKEditor 5 plugin definition: `address_suggestion.ckeditor5.yml` →
  `address_suggestion_plugin` (JS plugin `addressSuggestion.AddressSuggestion`).
- Drupal plugin class: `Plugin\CKEditor5Plugin\AddressSuggestion`
  (`CKEditor5PluginConfigurableInterface`).
- Config schema: `ckeditor5.plugin.address_suggestion_plugin`.
- Route it drives: `address_suggestion.ckeditor` →
  `Controller\AddressSuggestion::ckeditor` at `/address/suggestion/{format}`.

## Enable

Add the **Address suggestion** button to a text format's CKEditor 5 toolbar
(`admin/config/content/formats/manage/<format>`). The config form (`buildConfigurationForm`) exposes:

| Key | Type | Meaning |
|---|---|---|
| `provider` | string | `AddressProvider` id to query (default `photon`). |
| `endpoint` | string (url) | Optional custom API URL, overrides the provider `api`. |
| `api_key` | string | Key for keyed providers. |
| `username` / `password` | string | Credentials for login providers (`post_ch`). |
| `token` | string | **Required.** A per-format token that the autocomplete route checks. Auto-generated (`Component\Utility\Random`) if left empty. |

`getDynamicPluginConfig()` hands the JS a ready URL:
`Url::fromRoute('address_suggestion.ckeditor', ['format' => <editor id>], ['query' => ['token' => <token>]])`
exposed as `address_suggestion.endpoint`.

## Route behavior — `ckeditor()`

`ckeditor(Request $request, $format)` returns provider results as JSON. Before querying it requires
**both**:

- the caller holds the `use text format <format>` permission, and
- the request `?token=` equals the token stored in that editor's `address_suggestion_plugin`
  settings (a mismatch forces a `403` JSON response `{data:{error:'Permission required'}, status:403}`).

On success it reads the provider/endpoint/api_key from the **editor (text-format) config**, applies
an optional `?country=`, and calls `getProviderResults($q, $settings)`.

## Autocomplete any custom `#autocomplete` textfield

Because the route is token-gated, you can wire it onto any Form API textfield by passing the format's
token:

```php
$token = \Drupal::service('editor.plugin.manager') // or read editor config for the format
  // token is the value saved in the 'full_html' editor's address_suggestion_plugin settings
  ;
$form['custom_text_field'] = [
  '#type' => 'textfield',
  '#title' => $this->t('Autocomplete Address'),
  '#autocomplete_route_name' => 'address_suggestion.ckeditor',
  '#autocomplete_route_parameters' => ['format' => 'full_html'],
  '#autocomplete_query_parameters' => ['token' => $token],
];
```

The user must have `use text format full_html`, and the passed `token` must match the one saved on
that format's Address-suggestion CKEditor plugin config.
