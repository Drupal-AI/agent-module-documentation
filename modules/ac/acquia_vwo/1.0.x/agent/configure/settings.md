# Configure Acquia VWO (settings)

All configuration lives in the single config object **`acquia_vwo.settings`** and is edited through
four tabbed `ConfigFormBase` forms under `/admin/config/system/acquia_vwo`. Every route requires the
`administer acquia vwo` permission. Install defaults ship in
`config/install/acquia_vwo.settings.yml`; the typed schema is `config/schema/acquia_vwo.settings.yml`.

## The four forms / routes

| Route | Path | Form class | Sets |
|---|---|---|---|
| `acquia_vwo.settings` | `/admin/config/system/acquia_vwo` | `SettingsForm` | `id`, `loading.timeout` |
| `acquia_vwo.settings.visibility` | `…/visibility` | `VisibilityForm` | `visibility.enabled`, `visibility.user_control`, `visibility.conditions` |
| `acquia_vwo.settings.vwoid` | `…/vwoid` | `ExtractIDForm` | `id` (parsed from pasted smart code) |
| `acquia_vwo.settings.field_mapping` | `…/field_mapping` | `FieldMappingForm` | `field_mapping.*` |

## Config keys (`acquia_vwo.settings`)

| Key | Type | Default | Meaning |
|---|---|---|---|
| `id` | string | `'NONE'` | VWO account id. Must be numeric or `NONE`. Empty/`NONE` ⇒ nothing is attached. |
| `loading.timeout` | integer | `2000` | ms the smart code waits for VWO settings before showing the un-tested page. |
| `visibility.enabled` | string | `'off'` | `off` = attach on every (non-admin) page; `on` = evaluate conditions. |
| `visibility.user_control` | string | `'nocontrol'` | `nocontrol` / `optout` (on by default, user can disable) / `optin` (off by default, user can enable). |
| `visibility.conditions` | sequence | request_path excluding admin/user/etc. | Core condition-plugin config, keyed by plugin id. |
| `field_mapping.content_section` | string | `''` | Node entity-reference→taxonomy field name for the VWO "content section" segment. |
| `field_mapping.content_keywords` | string | `''` | Field name for the "keywords" segment. |
| `field_mapping.persona` | string | `''` | Field name for the "persona" segment. |

## Account id (`SettingsForm`)

`src/Form/SettingsForm.php`. Textfield `id` (`#maxlength 20`, `#config_target
acquia_vwo.settings:id`) and number `timeout` (`#min 0`, `#max 9999`). `validateForm()` enforces the
id is `^\d+$` **or** the literal `NONE`, otherwise a form error is set — so the id written to config
through this form is always numeric or `NONE`.

## Extract Account ID (`ExtractIDForm`)

`src/Form/ExtractIDForm.php`. Paste the full VWO smart code into the `parse_area` textarea; on submit
`validateForm()` extracts the id with a regex — `var _vis_opt_account_id = (\d+);` (synchronous
snippet) or `var account_id = (\d+);` (asynchronous snippet) — and `submitForm()` saves the captured
digits to `acquia_vwo.settings:id`, then redirects back to `acquia_vwo.settings`. Only digits are
captured; anything else fails validation ("Unable to locate Account ID in pasted code.").

## Visibility (`VisibilityForm`)

`src/Form/VisibilityForm.php`. Two radio groups:

- `enabled` — `off` (attach the script to every page) or `on` (customize visibility).
- `user` → `visibility.user_control` — `nocontrol` / `optout` / `optin` (see user opt-in below).

When `enabled = on`, the form renders configuration forms for the core condition plugins that
`ConditionResolver` seeds (`request_path`, `user_role`, `entity_bundle:node`) inside vertical tabs;
they are stored under `visibility.conditions` and combined with boolean **AND** at runtime. Attach
decision: `VisibilityContext::shouldAttach()` returns FALSE if `id` is empty, TRUE if `enabled != on`,
otherwise the AND-combined result of the conditions.

## Field mapping (`FieldMappingForm`)

`src/Form/FieldMappingForm.php`. Three `select`s (Content Section / Content Keywords / Persona), each
`#config_target acquia_vwo.settings:field_mapping.*`. Options come from
`getTaxonomyTermFieldNames()`, which lists every **node** field-storage of type `entity_reference`
whose `target_type` is `taxonomy_term`. At render time `PageContext::getNodeData()` reads the mapped
fields off the current node, loads the referenced terms (translated to the current content language)
and emits their names under `window.VWO.data.acquia.drupal.taxonomy.<segment>`. Only nodes are
captured — not views or other entities.

## Per-user opt in/out

When `visibility.user_control` is `optout` or `optin` **and** `id` is numeric, `UserControl`
(`acquia_vwo.service.user.user_control`) adds a "VWO" checkbox to the user edit form
(`hook_form_user_form_alter`). The choice is saved to `user.data` (module `acquia_vwo`, key
`user_opt`, per uid) and mirrored into the browser's `localStorage` (`acquia_vwo_user_opt`) by the
`acquia_vwo/user_opt` library, where the injected `acquiaVwoUserOptOut()` gate reads it to decide
whether the VWO snippet runs for that visitor.

## Set it from code / drush

```php
\Drupal::configFactory()->getEditable('acquia_vwo.settings')
  ->set('id', '123456')                 // numeric account id (the UI validates this)
  ->set('loading.timeout', 2000)
  ->set('visibility.enabled', 'off')    // 'on' to use conditions
  ->set('visibility.user_control', 'nocontrol')
  ->set('field_mapping.content_section', 'field_tags')
  ->save();
```

```bash
ddev drush config:set acquia_vwo.settings id 123456 -y
```
