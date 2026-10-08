<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Externalauth Gitlab OAuth2 Connector (externalauth_gitlab) — agent index

GitLab OAuth 2.0 login client. Adds a "Log in via Gitlab" local task under `/user`; the single controller route
handles both the redirect out to GitLab and the OAuth callback, then resolves the GitLab identity through the
External Authentication (`externalauth`) framework. Package `Custom`. License GPL-2.0-or-later. Version 2.0.3
(`2.0.x`). Core `^8 || ^9 || ^10 || ^11`.

## Dependencies

- `externalauth:externalauth` — provides `externalauth.externalauth` (`ExternalAuthInterface`); used for
  `login()` and `linkExistingAccount()`. Composer `drupal/externalauth:^2`.
- `omines/oauth2-gitlab` (`^3.0@dev`) — the League OAuth2 GitLab provider (`Omines\OAuth2\Client\Provider\Gitlab`),
  which pulls in `league/oauth2-client`. Used for the authorization URL, token exchange and resource owner.

## What it provides (from source)

- **Two routes** (`externalauth_gitlab.routing.yml`):
  - `externalauth_gitlab.login_controller_login` — path `/user/login/gitlab`, controller
    `LoginController::login`, requirement `_user_is_logged_in: FALSE`. Both starts the OAuth redirect and handles
    the callback. → [api/login-flow.md](api/login-flow.md)
  - `externalauth_gitlab.settings_form` — path `/admin/config/people/externalauth-gitlab-settings`, form
    `SettingsForm`, permission `administer externalauth_gitlab settings`. → [config/settings.md](config/settings.md)
- **One controller**: `src/Controller/LoginController.php` (`LoginController extends ControllerBase`) with
  `login(Request)` and private `doLogin(ResourceOwnerInterface, $token)`. → [api/login-flow.md](api/login-flow.md)
- **One config form**: `src/Form/SettingsForm.php` (`SettingsForm extends FormBase`, `ConfigFormBaseTrait`),
  editing config object `externalauth_gitlab.settings`. → [config/settings.md](config/settings.md)
- **One permission** (`externalauth_gitlab.permissions.yml`): `administer externalauth_gitlab settings`.
- **One config object**: `externalauth_gitlab.settings` with keys `client_id`, `client_secret`, `domain`.
- **Menu/task links**: settings menu link under `user.admin_index`
  (`externalauth_gitlab.links.menu.yml`); login local task on `user.page` (`externalauth_gitlab.links.task.yml`).
- **hook_help** in `externalauth_gitlab.module` (About text only).

## What it does NOT provide

No entities, no plugin types, no services of its own (uses core `externalauth.externalauth`,
`tempstore.private`, `config.factory`, `entity_type.manager`, `page_cache_kill_switch`), no Drush, and **no config
schema** (`config/schema/` is absent). `config/install/externalauth_gitlab.settings.yml` ships an empty stub
(no default values). Does not register new Drupal users — it only links to accounts that already exist.

## Install / operate

1. `composer require drupal/externalauth_gitlab` (pulls `drupal/externalauth` and `omines/oauth2-gitlab`).
2. `drush en externalauth_gitlab -y`.
3. Register an OAuth application on your GitLab instance; the redirect URI is your site's `/user/login/gitlab` URL.
4. At `/admin/config/people/externalauth-gitlab-settings` enter the GitLab **Client ID**, **Client secret** and
   **Domain** (the GitLab base URL), then save.
5. Ensure each intended user has a Drupal account whose email matches their GitLab account, then log in via the
   `/user` "Log in via Gitlab" local task.
