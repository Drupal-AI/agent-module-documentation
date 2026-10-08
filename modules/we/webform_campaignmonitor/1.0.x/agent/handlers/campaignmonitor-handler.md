<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The `campaignmonitor` Webform handler

`src/Plugin/WebformHandler/WebformCampaignMonitorHandler.php` extends `WebformHandlerBase`.

## Plugin annotation

```
@WebformHandler(
  id = "campaignmonitor",
  label = "CampaignMonitor",
  category = "CampaignMonitor",
  cardinality = CARDINALITY_UNLIMITED,   // many handlers per form
  results = RESULTS_PROCESSED,
  submission = SUBMISSION_REQUIRED,
  tokens = TRUE,
)
```

## Injected services (`create()`)

- `webform.token_manager` → `$tokenManager` (token replacement + token tree link).
- `campaignmonitor.subscription_manager` → `$cmSubscriptionManager` (performs the subscribe).
- `campaignmonitor.manager` → `$cmManager` (provides `getLists()`).

All Campaign Monitor connectivity is in the **campaignmonitor** module; this handler holds no
credentials and makes no HTTP call itself.

## Configuration keys (`defaultConfiguration`)

| key | default | meaning |
|-----|---------|---------|
| `list` | `''` | target list id, or a token (via `webform_select_other`) |
| `email` | `''` | machine name of the form's email element |
| `double_optin` | `TRUE` | single vs double opt-in |
| `mergevars` | `''` | YAML of merge vars; `name:` used as subscriber name |
| `interest_groups` | `[]` | present in config but **no form control** — always empty |
| `control` | `''` | optional checkbox element that gates the subscription |

`buildConfigurationForm()` builds the List (`webform_select_other`), Email (select filtered to
`#type == 'email'` elements), Control (select filtered to `#type == 'checkbox'` elements), Merge
vars (`webform_codemirror`, yaml mode) and Double opt-in controls, plus a token tree link.
`getSummary()` shows the resolved list name.

## Submission flow (`postSave`)

```php
if ($update) return;                       // new submissions only
$fields = $webform_submission->toArray(TRUE);
if (!empty($this->configuration['control'])
    && empty($fields['data'][$this->configuration['control']])) {
  return;                                   // control checkbox unticked -> skip
}
$configuration = $this->tokenManager->replace($this->configuration, $webform_submission);
$email     = $fields['data'][$configuration['email']];
$mergevars = Yaml::decode($configuration['mergevars']);
$name      = $mergevars['name'];            // assumes a 'name' key exists
$this->cmSubscriptionManager->userSubscribe(
  $configuration['list'], $email, $name, $mergevars,
  $configuration['interest_groups'], $configuration['double_optin']
);
```

## Notes for agents

- There is **no error handling** here. Whether an API failure is queued/retried, surfaced, or
  silently swallowed is entirely up to `campaignmonitor.subscription_manager::userSubscribe()` —
  read that module to know the failure behaviour.
- The **control field** is the only opt-in mechanism. Without it, every new submission subscribes.
- Because `mergevars` is decoded and `['name']` read unconditionally, an empty YAML block triggers
  a PHP warning; keep at least `name:` present.
- The list can be a **token** (Other field), so the destination list can vary per submission.
