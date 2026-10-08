<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configuring the Mautic connection

## Install & enable

```bash
composer require drupal/mautic_paragraph   # pulls mautic/api-library:^3.0 (+ 2 patches)
drush en mautic_paragraph -y
# For the paragraph type & fields to be installed, Paragraphs must be enabled:
drush en paragraphs -y
```

Hard deps are core `options` + `text`. The `mautic` **paragraph type** and its fields live in
`config/optional/`; they are installed by `mautic_paragraph_modules_installed()` (in
`mautic_paragraph.module`) whenever `paragraphs` becomes enabled — so enabling Paragraphs after
this module still creates them. The `mautic_block` **custom block type** and its fields are in
`config/install/` and are created immediately on module install.

## Settings form

- Route **`mautic_paragraph.route_settings`** → path **`/admin/config/services/mautic`**,
  form `\Drupal\mautic_paragraph\Form\MauticSettingsForm` (`getFormId()` =
  `mautic_paragraph_admin_settings`), menu link under *Configuration → Web services*
  (`mautic_paragraph.links.menu.yml`).
- Permission: **`administer mautic_paragraph`** (defined in `mautic_paragraph.permissions.yml`).
- Writes config object **`mautic_paragraph.settings`**.

Form fields (`MauticSettingsForm::buildForm()`):

| Element | Config key | Notes |
|---|---|---|
| Mautic Paragraph Connector (radios) | `connector` | Plugin id of the connector; AJAX-swaps the connector sub-form. |
| Limit (number) | `limit` | Max entities returned from the Mautic API list call (default 100). |
| Cache mautic form list for (select) | `cache` | Seconds to cache the fetched form list (default 3600; `0` = no caching). |
| *(connector sub-form)* | `connector_config` | Nested plugin config, rendered by the chosen connector. |

Submit button label is "Connect to Mautic". After save, `submitForm()` calls the connector's
`afterSubmit()` (the OAuth connector uses it to kick off token acquisition). A live **Status**
fieldset shows "Connection successfully established" or a failure message based on
`connector->getStatus()`.

Default install config (`config/install/mautic_paragraph.settings.yml`):

```yaml
connector: 'basic_auth'
cache: 3600
limit: 100
connector_config: {}
```

## Config schema

`config/schema/mautic_paragraph.schema.yml` defines `mautic_paragraph.settings` with `connector`
(string), `limit` (integer) and `connector_config` typed dynamically as
`plugin.plugin_configuration.mautic_paragraph_connector.[%parent.connector]`. Connector schemas:

- `...standard` — `scheme`, `base_url`, `port`, `path` (base for every connector).
- `...basic_auth` — adds `username`, `password`.
- `...oauth` — adds `client_id`, `client_secret`, `redirect_base_url`.

## Connector plugin type

Custom plugin type **`mautic_paragraph_connector`**:

- Annotation `src/Annotation/MauticParagraphConnector.php` (keys `id`, `label`, `description`).
- Manager `MauticParagraphConnector\MauticParagraphConnectorPluginManager` (service
  `plugin.manager.mautic_paragraph.connector`; alter hook `mautic_paragraph_connector_info`).
- Base `MauticParagraphConnectorPluginBase` implements `MauticParagraphConnectorInterface`,
  `PluginFormInterface`, `ContainerFactoryPluginInterface`. Common config: `scheme`, `base_url`,
  `port`, `path`. `getServerUri()` composes `scheme://host:port/path` and validates it with
  `Url::fromUri()`. `getList()` fetches Mautic forms via `MauticApi->newApi('forms', $auth, $url)`
  (cached in `cache.default` under key `mautic_form_list`); `fetchForms()` respects the `limit`
  setting; `getFormTitle($id)` looks a form name up in that list.

Shipped connectors (`src/Plugin/MauticParagraphConnector/`):

- **`basic_auth`** (`BasicAuthMauticParagraphConnector`) — HTTP Basic auth; adds `username` +
  `password` fields. Builds a `Mautic\Auth\ApiAuth` `BasicAuth` client. Password field left blank
  on re-save keeps the stored password.
- **`oauth`** (`OAuthMauticParagraphConnector`) — OAuth2 **Two-Legged (client credentials)**; adds
  `client_id` + `client_secret`. `getValidAuthenticationObject()` builds a `TwoLeggedOAuth2` auth,
  requests/validates an access token and stores the token data in Drupal **state**
  (`mautic_access_token_data`) — not in config. `afterSubmit()` starts the authorization.

## Service façade

`mautic_paragraph_api` (`src/MauticParagraphApi.php`) reads `mautic_paragraph.settings`, creates
the configured connector via the plugin manager, and delegates `getApiClient()`, `getStatus()`,
`getFormTitle($id)`, `getList($input, $auth)`, `getServerUri()` to it. Returns `NULL` when no
connector/config is set.

## Uninstall

`hook_uninstall` (`mautic_paragraph.install`) deletes `mautic_paragraph.settings`, the paragraph
and block types, their form/view displays, and all `field.field.*`/`field.storage.*` config for
`field_mautic*` / `field_mautic_block*`. Updates `9001` (drops legacy
`connector_config.redirect_base_url`) and `9002` (sets default `limit` = 100) also exist.
