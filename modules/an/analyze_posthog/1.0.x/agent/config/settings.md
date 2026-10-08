<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configuration: PostHog credentials, date range, and conversion goals

## Install & enable

```bash
composer require drupal/analyze_posthog
drush en analyze_posthog -y   # pulls in analyze (>=1.1.0) and key
```

`hook_install` (`analyze_posthog.install`) shows a warning linking to the settings form;
`hook_uninstall` deletes the `analyze_posthog.settings` config object.

## Settings form

`Drupal\analyze_posthog\Form\PostHogSettingsForm` (a `ConfigFormBase`, form id
`analyze_posthog_settings`) at **`/admin/config/analyze/posthog`**, route
`analyze_posthog.settings`, permission **`administer analyze settings`** (defined by the
`analyze` module). This is the module's `configure` route. Editable config:
**`analyze_posthog.settings`**.

Fields:

- **`host`** (textfield) — PostHog base URL, e.g. `https://us.posthog.com`,
  `https://eu.posthog.com`, or a self-hosted URL. `validateForm()` rejects any value not starting
  with `https://`. `submitForm()` stores it `rtrim`-ed of a trailing `/`.
- **`project_id`** (textfield) — the PostHog project ID (usually a number).
- **`personal_api_key`** (`key_select`) — selects a **Key module** entity holding the PostHog
  **personal API key** (`phx_…`). Config stores the *key id*, not the secret; the value is
  resolved at request time via `key.repository`.
- **`date_range`** (select) — default reporting window: 7 / 14 / 28 / 90 / 180 / 365 days
  (default 28).
- **`cache_ttl`** (select) — cache lifetime for PostHog responses: 3600 / 21600 / 43200 / 86400 s
  (default 21600 = 6 h).
- **Conversion Goals** table (`conversion_goals`) — repeatable rows, each with *Label*, *Event*,
  *Fixed value*, *Value property*, *Currency*. On submit each non-empty row becomes an array
  `{id, label, event, value, value_property, currency}`; `id` is
  `Html::cleanCssIdentifier(strtolower($label))`. `validateForm()` requires both label and event
  when either is set and forbids duplicate events. The *Event* cell is a live dropdown of the
  project's frequent custom events when configured (see `getAvailableEvents()`), else a textfield.

On save, if the module is now configured, `submitForm()` calls `PostHogClient::testConnection()`
and shows a success/error message. A "View reports" button appears when configured.

## config/install defaults (`analyze_posthog.settings.yml`)

```yaml
personal_api_key: ''
host: ''
project_id: ''
date_range: 28
cache_ttl: 21600
conversion_goals: []
```

## config/schema (`analyze_posthog.schema.yml`)

`analyze_posthog.settings` is a `config_object` with `personal_api_key` (string), `host`
(string), `project_id` (string), `date_range` (integer), `cache_ttl` (integer), and
`conversion_goals` (sequence of `analyze_posthog.conversion_goal`). Each goal maps: `id`, `label`,
`event`, `currency` (strings), `value` (float), `value_property` (string).

## "Configured" definition

`PostHogClient::isConfigured()` returns TRUE only when the **resolved API key**, **host**, and
**project_id** are all non-empty. Every report and plugin method short-circuits to a "not
configured" message otherwise.

## Permissions

- **`access posthog analytics`** (this module) — view the Analyze tab data and the
  `/admin/reports/posthog` report. Granting it exposes analytics; it does not grant config
  access.
- **`administer analyze settings`** (from `analyze`) — reach the settings form and the "Configure
  settings" links.

## Recommended: store the key via env, not config

Create the Key with the env provider so the secret never lands in config or the DB:

```bash
ddev dotenv set .ddev/.env --posthog-personal-api-key=phx_xxx && ddev restart
drush key:save posthog_key --label='PostHog API Key' --key-type=authentication \
  --key-provider=env \
  --key-provider-settings='{"env_variable":"POSTHOG_PERSONAL_API_KEY","base64_encoded":false,"strip_line_breaks":true}' \
  --key-input=none -y
```

Then select `posthog_key` in the settings form's *Personal API key* field.
