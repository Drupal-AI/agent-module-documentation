<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Webform Dynamic Autocomplete (webform_dynamic_autocomplete) — agent index

Makes a Webform autocomplete element fetch its options live from an external JSON API as the
user types, instead of from a static option list. Works by shipping a `webform_options` entity
you select under an autocomplete element, plus an options-alter hook that queries a site-wide
endpoint.

- Dependency: `webform`. Core: `^10 || ^11`. Package: Webform. Version dir `11.0.x` (11.0.1).
- Configure: `webform_dynamic_autocomplete.settings` → `/admin/config/webform_dynamic_autocomplete/settings`
  (permission `administer site configuration`).
- No element plugin, no plugin types, no permissions, no Drush, no config schema, no JS library.
  Total surface: one `ConfigFormBase`, one bundled `webform_options` entity, one alter hook, `hook_help`.

## Solution docs

- **Set the endpoint URL + query parameter (the settings form and config object)** → [configure/settings.md](configure/settings.md)
- **How dynamic options are wired: the `autocomplete_dynamic` options entity + the alter hook** → [plugins/element.md](plugins/element.md)

## Key facts

- Config object `webform_dynamic_autocomplete.settings`, keys `webform_dynamic_endpoint_url`
  (string) and `webform_dynamic_query_parameter` (string). No `config/schema`, no `config/install`
  default for this object — it does not exist until the settings form is saved. Both fields are
  `#required` on the form.
- Bundled options entity: `config/install/webform.webform_options.autocomplete_dynamic.yml`,
  id `autocomplete_dynamic`, label "Dynamic Autocomplete options", category "Dynamic Autocomplete",
  `options: ""` (empty — filled at runtime). Enforced dependency on this module.
- Runtime: `webform_dynamic_autocomplete_webform_options_autocomplete_dynamic_alter(&$options, &$element)`
  in the `.module` file reads `\Drupal::request()->query->get('q')` (Webform passes the typed term
  as `q`), builds `"$endpoint?$query_parameter=$term"`, does `@file_get_contents()` (GET), and sets
  `$options = json_decode($response, TRUE)` when that is an array, else `[]`.
- The external API must return JSON key/value pairs (option value → label). Missing config,
  unreachable endpoint, or non-array JSON all resolve to an empty option list.
- No custom element: you use Webform's own `autocomplete` element and choose the
  `autocomplete_dynamic` options under its Custom/"Select options" setting.
- Routes: only `webform_dynamic_autocomplete.settings` (the settings form). The typeahead request
  itself is served by Webform core's options-autocomplete route, not by this module.
