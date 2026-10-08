<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# How dynamic options are wired (options entity + alter hook)

This module defines **no element plugin and no plugin type**. It reuses Webform's built-in
`autocomplete` element and supplies its options dynamically through two pieces: a bundled
`webform_options` config entity and an options-alter hook.

## The bundled options entity

File `config/install/webform.webform_options.autocomplete_dynamic.yml`:

- id: `autocomplete_dynamic`
- label: `Dynamic Autocomplete options`
- category: `Dynamic Autocomplete`
- `likert: false`, `options: ""` (empty — populated at runtime)
- enforced module dependency on `webform_dynamic_autocomplete`

This is what appears as **"Dynamic Autocomplete options"** in an autocomplete element's Custom /
"Select options" chooser. (On a site where module config was not imported, load or re-import it;
it is provided via `config/install`, so re-installing the module recreates it.)

## The alter hook (runtime)

`webform_dynamic_autocomplete.module` implements the options-specific alter
`hook_webform_options_WEBFORM_OPTIONS_ID_alter()` as:

```php
function webform_dynamic_autocomplete_webform_options_autocomplete_dynamic_alter(array &$options, array &$element): void {
  $query           = \Drupal::request()->query->get('q');
  $config          = \Drupal::config('webform_dynamic_autocomplete.settings');
  $endpoint        = $config->get('webform_dynamic_endpoint_url');
  $query_parameter = $config->get('webform_dynamic_query_parameter');

  if (empty($endpoint) || empty($query_parameter)) {
    $options = [];
    return;
  }

  $url      = $endpoint . '?' . $query_parameter . '=' . $query;
  $response = @file_get_contents($url);
  if ($response === FALSE) { $options = []; return; }

  $check   = json_decode($response, TRUE);
  $options = is_array($check) ? $check : [];
}
```

Behavior notes for an agent:

- Webform passes the typed search term as the request query arg **`q`** (read directly here,
  independent of the configured `webform_dynamic_query_parameter`, which only names the *outbound*
  parameter to the external API).
- The request is a plain **GET** via `file_get_contents()` (relies on `allow_url_fopen`). There is
  no timeout, caching, header, or retry handling.
- Success requires the API to return JSON that decodes to a PHP array (a key/value map of option
  value → label). Non-array JSON, an empty/invalid response, or a missing endpoint/parameter all
  set `$options = []`.
- No result normalization beyond `json_decode(..., TRUE)`: the JSON keys become option values and
  the JSON values become option labels.

## Also in the module

- `hook_help()` for `help.page.webform_dynamic_autocomplete` documenting the settings path and
  usage steps.
- Nothing else: no services, no JS/CSS library, no controller, no permissions, no Drush.
