<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Conword — settings, config object, routes, hooks

## Install / enable

`drush en conword`. No module dependencies. `composer suggest`: `drupal/csp` (strict CSP support);
`composer.json` declares a `conflict` with `drupal/csp <1.12`. A valid Conword GmbH contract +
customer ID are required for the widget to do anything.

## Route & permission

- Route **`conword.settings`** (`conword.routing.yml`): path `/admin/config/services/conword`,
  `_form: \Drupal\conword\Form\ConwordConfigForm`, `_permission: administer conword`,
  `_admin_route: TRUE`.
- Permission **`administer conword`** (`conword.permissions.yml`) — "Allows a user to configure the
  Conword settings." This is the only route/permission the module adds.
- Menu link `conword` (`conword.links.menu.yml`) under `system.admin_config_services`
  (*Configuration → Services*), `configure: conword.settings` in `conword.info.yml`.

## Config object `conword.settings`

Install defaults `config/install/conword.settings.yml`; schema `config/schema/conword.schema.yml`
(`type: config_object`, `FullyValidatable`). Keys:

- `customer_id` — string, `NotBlank`. Default: not set (form field is `#required`). Used only to
  build the external script URL.
- `conwordConfig.disable_language_switcher` — bool, default `false`.
- `conwordConfig.disable_rtl_attribute` — bool, default `false`.
- `visibility` — sequence of `condition.plugin.[id]`. Default install config:
  `request_path` with `negate: true` and a `pages` list (`/admin`, `/admin/*`, `/batch`,
  `/entity-browser/*/*`, `/media/*/*`, `/node/add`, `/node/*/*`, `/user/*/*`) — i.e. hide the widget
  on those paths.

## Config form `ConwordConfigForm` (`src/Form/ConwordConfigForm.php`)

- `getFormId()` = `conword_config_form`; `getEditableConfigNames()` = `['conword.settings']`.
- `create()` injects `plugin.manager.condition`, `context.repository`, `language_manager`.
- `buildForm()` — a *General settings* details group with three fields bound via `#config_target`:
  `customerId` → `conword.settings:customer_id` (required), `disableLanguageSwitcher` →
  `conwordConfig.disable_language_switcher`, `disableRtlAttribute` →
  `conwordConfig.disable_rtl_attribute`. A JS-`#states` warning notes that visibility is bypassed by
  the block when the language-switcher flag is on.
- **Visibility UI** — `buildVisibilityInterface()` renders one vertical-tab per condition plugin
  (`getDefinitionsForContexts()`), skipping `current_theme` and skipping `language` until the site is
  multilingual. Negation is forced to a fixed value for `entity_bundle:node`, `language`,
  `response_status`, `user_role`; `request_path` gets Show/Hide radios. Attaches
  `conword/conword.admin`.
- `validateForm()` / `submitForm()` — delegate to each condition's own
  validate/submitConfigurationForm via `SubformState`, then explicitly write
  `visibility` = collected condition config (there is no `#config_target` for plugin subforms) and
  `save()`.

## Runtime hooks (`conword.module`)

- `conword_theme()` — registers theme `conword` (no variables) → `templates/conword.html.twig`.
- `conword_page_attachments()` — when `conword__is_conword_active()` is TRUE, attaches library
  `conword/conword` and sets `drupalSettings.conword.conwordConfig` = the stored `conwordConfig`
  mapping.
- `conword_library_info_alter()` — for the `conword` library, appends an **external** JS asset
  `https://static.conword.io/js/v2/{customer_id}/conword.js` (attributes `id=conword-root`,
  `charset=utf-8`), reading `customer_id` from config. HTTPS; the customer ID is admin-set config, not
  request input; nothing is fetched server-side.
- `conword__is_conword_active()` — rebuilds a `ConditionPluginCollection` from `visibility`, wires
  runtime contexts from `context.repository`, and returns FALSE on the first failing/unsatisfiable
  condition (mirrors core block visibility evaluation).
