<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# ECA Webform — events & actions

Everything here is consumed inside an ECA model (`eca.eca.<id>` config entity: `events`,
`conditions`, `gateways`, `actions`). ECA Webform adds **events** you start a model from and
**actions** you place in a model.

## Events (base plugin `webform`)

One derived event plugin (`src/Plugin/ECA/Event/WebformEvent.php`, deriver
`WebformEventDeriver`). Derivative id = `webform:<key>`. All 25 keys (each wraps a
`hook_webform_*` hook, dispatched from `src/Hook/WebformHooks.php`):

```
webform:access_rules                          webform:element_translatable_properties_alter
webform:access_rules_alter                    webform:handler_info_alter
webform:admin_third_party_settings_form_alter webform:handler_invoke_alter
webform:element_access                        webform:help_info
webform:element_alter                         webform:help_info_alter
webform:element_configuration_form_alter      webform:image_select_images_alter
webform:element_default_properties_alter      webform:options_alter
webform:element_info_alter                    webform:source_entity_info_alter
webform:element_input_masks                   webform:submission_access
webform:element_input_masks_alter             webform:submission_form_alter
webform:submission_query_access_alter         webform:submissions_post_purge
webform:submissions_pre_purge                 webform:third_party_settings_form_alter
webform:variant_info_alter
```

List them live: `drush php:eval 'foreach(array_keys(\Drupal::service("plugin.manager.eca.event")->getDefinitions()) as $id){ if(str_starts_with($id,"webform:")) print "$id\n"; }'`

**Tokens.** Each event exposes its hook args under the `webform` token namespace; the exact
keys depend on the event (see `buildEventData()` in `WebformEvent.php`). Common ones:
`[webform:element]`, `[webform:context]`, `[webform:account]`, `[webform:operation]`,
`[webform:submissions]`, `[webform:options]` / `[webform:option_id]`, `[webform:form_id]`,
`[webform:handler]` / `[webform:method_name]` / `[webform:args]`, `[webform:definitions]`,
`[webform:access_rules]`, `[webform:input_masks]`, `[webform:help_info]`, `[webform:variants]`.

**Collector events.** `webform:access_rules`, `webform:element_input_masks` and
`webform:help_info` are two-way: `EventSubscriber/EcaWebform.php` runs after the model and
reads the mutated `webform` DTO back out (`access_rules` / `input_masks` / `help_info`),
writing it into the event — so a model can *contribute* those values, not just read them.

Model YAML sketch (events array entry):

```yaml
events:
  ev_form:
    plugin: 'webform:submission_form_alter'
    label: 'On submission form build'
    configuration: {}
    successors:
      - { id: act_prefill, condition: '' }
```

## Actions (core `#[Action]` plugins)

Four actions, registered in the core action plugin manager (`plugin.manager.action`), each
also carrying `#[EcaAction]`. Config fields are all token-replaced.

| Action id | `type` (context object) | Config keys | Effect |
|---|---|---|---|
| `eca_webform_submission_get_data` | `webform_submission` | `field_name`, `token_name` | Reads element `field_name` via `getElementData()`, writes it to ECA token `token_name`. |
| `eca_webform_submission_set_data` | `webform_submission` | `field_name`, `field_value` | Writes `field_value` into element `field_name` via `setElementData()`. |
| `eca_webform_get_third_party_setting` | `webform` | `provider`, `setting_name`, `token_name` | Reads `$webform->getThirdPartySetting(provider, setting_name)` into token `token_name`. |
| `eca_webform_set_third_party_setting` | `webform` | `provider`, `setting_name`, `setting_value` | Writes `$webform->setThirdPartySetting(...)`. |

- `field_name` = the element **machine name**. The get/set-data actions' `access()` only
  allows the action when the submission's webform actually has that element, so it must
  resolve to a real element on the target webform.
- `type` is the object the action operates on — it must be supplied by the model context
  (e.g. the `webform_submission` produced by a submission event). The `*_third_party_setting`
  actions operate on a `webform` config entity.
- Config schema for the actions lives in `config/schema/eca_webform.schema.yml`
  (`action.configuration.eca_webform_*`).

Model YAML sketch (actions array entry):

```yaml
actions:
  act_get:
    plugin: 'eca_webform_submission_get_data'
    label: 'Get email'
    configuration:
      field_name: 'email'
      token_name: 'submitted_email'
    successors: []
```

Discover/inspect live:
`drush php:eval '$m=\Drupal::service("plugin.manager.action"); foreach(["eca_webform_submission_get_data","eca_webform_submission_set_data","eca_webform_get_third_party_setting","eca_webform_set_third_party_setting"] as $id){ print $id.": ".($m->hasDefinition($id)?"yes":"no")."\n"; }'`

## No configuration surface of its own

No settings form, no `configure` route, no permissions, no Drush. The only config it defines
is plugin schema (events + the four action configs). To operate the module you create/edit
`eca.eca.*` config entities (via the ECA modeller UI, imported YAML, or
`\Drupal::entityTypeManager()->getStorage('eca')->create([...])->save()`).
