<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Settings form & configuration

File: `src/Form/SettingsForm.php` — `SettingsForm extends FormBase` (uses `ConfigFormBaseTrait`).
Form id: `settings_form`. Editable config: `externalauth_gitlab.settings` (`SETTINGS` constant,
`getEditableConfigNames()`).

## Route & access

- Route `externalauth_gitlab.settings_form` — path `/admin/config/people/externalauth-gitlab-settings`.
- `requirements._permission: 'administer externalauth_gitlab settings'` (declared in
  `externalauth_gitlab.permissions.yml`).
- `options._admin_route: FALSE` (rendered with the front-end theme, not the admin theme).
- Menu link `externalauth_gitlab.settings` (parent `user.admin_index`, title "Gitlab Oauth2 settings") in
  `externalauth_gitlab.links.menu.yml`.

## Config object `externalauth_gitlab.settings`

Three string keys, all set by the form (`buildForm` / `submitForm`, which loops
`['client_id', 'client_secret', 'domain']` and saves each `#value`):

| Key | Form element | Meaning |
| --- | --- | --- |
| `client_id` | textfield "Client ID" | GitLab OAuth application ID. |
| `client_secret` | textfield "Client secret" | GitLab OAuth application secret. |
| `domain` | textfield "Domain" | Base URL of the GitLab instance (passed to the League Gitlab provider's `domain`). |

Notes:
- There is **no `config/schema/`** in the project, so these keys are unschemaed (`provides_config_schema: false`).
  `config/install/externalauth_gitlab.settings.yml` ships only the top-level `externalauth_gitlab:` key with no
  default values, so the three settings are empty until the form is saved.
- `LoginController::login()` throws `\InvalidArgumentException('Please finish setup of module first, missing
  config!')` if any of `client_id`, `client_secret` or `domain` is empty — configure all three before use.
- The values are read at login time via `configFactory->get('externalauth_gitlab.settings')`.

## GitLab side

Register an OAuth application on the GitLab instance named by `domain`. The redirect/callback URI is the site's
own `/user/login/gitlab` URL (the controller derives it from `Url::fromRoute('<current>', …, ['absolute' => TRUE])`).
The application needs a scope sufficient to read the user's profile/email, since identity resolution reads the
GitLab account email. See [../api/login-flow.md](../api/login-flow.md).
