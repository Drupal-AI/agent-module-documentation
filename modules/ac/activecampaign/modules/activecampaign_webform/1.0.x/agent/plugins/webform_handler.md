<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# activecampaign_contact Webform handler

`Plugin/WebformHandler/ActiveCampaignFormHandler` (`src/Plugin/WebformHandler/ActiveCampaignFormHandler.php`),
extends `Drupal\webform\Plugin\WebformHandlerBase`.

## Plugin definition

```
@WebformHandler(
  id = "activecampaign_contact",
  label = "Active Campaign",
  category = "Automated marketing",
  description = "Send submission data to Active Campaign",
  cardinality = CARDINALITY_SINGLE,   // one per webform
  results = RESULTS_PROCESSED,
)
```

`create()` calls the parent and sets `$instance->activeCampaignApi = $container->get('activecampaign.api')`.

## Install & add

`drush en activecampaign_webform` (pulls in `activecampaign` + `webform`). Configure ActiveCampaign
credentials at `/admin/config/services/activecampaign`. Then on a Webform:
*Settings → Emails / Handlers → Add handler → Active Campaign*.

## Configuration (`defaultConfiguration()`)

| key | default | notes |
|---|---|---|
| `email_field` | `NULL` | required in the form; the Webform element whose value is the AC email |
| `first_name_field` | `NULL` | optional |
| `last_name_field` | `NULL` | optional |
| `debug` | `FALSE` | logs submitted + mapped values at debug level |
| `custom_active_campaign_field` | `field[active_campaign_field_id,0]: '[webform_field_machine_name]'` | YAML mapping of extra AC fields |

`buildConfigurationForm()` builds the three `#type => select` field pickers from
`$this->webform->getElementsInitializedAndFlattened()` (only elements with a `#title`, plus a
`None` option), and a `webform_codemirror` (YAML) textarea for the custom mapping under a
*Development settings* details group with the `debug` checkbox.
`submitConfigurationForm()` calls `applyFormStateToConfiguration()` and casts `debug` to bool.

## Submit flow (`submitForm()`)

1. `$data = $webform_submission->getData()`; pull the configured keys from `settings`.
2. `$contact_properties['email'] = $data[$email_field]` (always).
3. add `first_name` / `last_name` when the mapped field has a non-empty value.
4. `Yaml::parse($custom_active_campaign_field)`; if it differs from the default, for each
   `key => value` strip `[`/`]` from `value` to get the Webform machine name and, when
   `$data[$webform_id]` is non-empty, set `$contact_properties[$key] = $data[$webform_id]`
   (so the YAML **key**, e.g. `field[345,0]`, becomes the ActiveCampaign property).
5. `try { $response = $api->syncContact($contact_properties); if (!$response->success)
   log->error($response->error); } catch (\Exception $e) { log->error($e->getMessage()); }` —
   `syncContact()` posts to ActiveCampaign `contact/sync` (create-or-update).
6. if `debug === TRUE`: render the submitted `$data` and the mapped `$contact_properties`
   (`WebformYaml::encode`, wrapped in `<pre>`) via `renderer->renderInIsolation()` and log at
   `getLogger('activecampaign_webform')->debug()`.

## Theme

`activecampaign_webform_theme()` registers `webform_handler_activecampaign_contact_summary`
(template `templates/webform-handler-activecampaign-contact-summary.html.twig`, variables
`settings`, `handler`) for the handler's summary row.

## Caveats

- The maintainer documents the custom YAML mapping as unreliable ("sometimes the data is sent
  incorrectly … use at your own risk").
- `debug` should stay off in production (it writes submitted values to the log).
