# Configure role-based front page overrides

Settings form `Drupal\front_page\Form\FrontPageSettingsForm` (form id `front_page_admin`) at route
`front_page.settings` → `/admin/config/system/front/settings` (also the module's `configure` route).
Requires permission `administer front page`. All values are stored in the config object
`front_page.settings`.

## Form fields → config keys

| Form field | Config key | Type | Notes |
|---|---|---|---|
| Enable Front page override | `enabled` | bool | Master switch; nothing redirects unless this is TRUE. |
| Disable front page redirects for the administrator role | `disable_for_administrators` | bool | Only meaningful/visible when the `authenticated` role override is enabled. Forced FALSE on save if `authenticated` is disabled. |
| Per role: Enable | `roles.<role_id>.enabled` | bool | Turn the override on for that role. |
| Per role: Weight | `roles.<role_id>.weight` | int | Lower weight wins when a user has several overriding roles. |
| Per role: Path | `roles.<role_id>.path` | path | Local redirect target, must start with `/`; may include query/fragment (e.g. `/node/51?page=5#anchor`). |

The form iterates every `user_role` entity (via `entity_type.manager`) and builds one details group per
role. `<role_id>` is the role machine name (e.g. `anonymous`, `authenticated`, `editor`).

### Validation (`validateForm`)

For each role marked enabled: `path` is required, must start with `/`, and must pass
`path.validator`->`isValid()` ("Either the path is invalid or you do not have access to it"). The target
is therefore constrained to a valid, accessible local path — it is not free-form.

### Set it with Drush / PHP

```php
$config = \Drupal::configFactory()->getEditable('front_page.settings');
$config->set('enabled', TRUE);
// Send anonymous visitors to /welcome, weight decides precedence across a user's roles.
$config->set('roles.anonymous', ['enabled' => TRUE, 'weight' => 0, 'path' => '/welcome']);
$config->set('roles.editor',    ['enabled' => TRUE, 'weight' => -10, 'path' => '/admin/content']);
// Never redirect admins even if the authenticated override is on:
$config->set('roles.authenticated', ['enabled' => TRUE, 'weight' => 10, 'path' => '/dashboard']);
$config->set('disable_for_administrators', TRUE);
$config->save();
```

```bash
ddev drush config:set front_page.settings enabled true -y
```

## What happens at runtime

`Drupal\front_page\EventSubscriber\FrontPageSubscriber::initData()` (service
`front_page.event_subscriber`) subscribes to `KernelEvents::REQUEST`:

1. Returns early on CLI/Drush, during Drupal install, in maintenance mode, and for non-`index.php`
   requests (cron).
2. Acts only when `enabled` is TRUE **and** `path.matcher`->`isFrontPage()` is TRUE (i.e. the visitor
   is on the front page).
3. If the current user has the `administrator` role and `disable_for_administrators` is TRUE, it does
   nothing.
4. Iterates the current user's roles, selecting the enabled `roles.<role>` entry with the **lowest**
   `weight`; that entry's `path` becomes the redirect target.
5. Prepends `/` if the path does not already start with `/`, `#`, or `?`, builds a `Url` with
   `Url::fromUserInput()` (current language, carrying the incoming request's query parameters), and sets
   a `Symfony\Component\HttpFoundation\RedirectResponse` on the event.
6. Triggers `page_cache_kill_switch` so the (role-dependent) front page is not page-cached.

The target is a redirect to a local path; the destination page still enforces its own access when the
user lands there.

## Config schema

`config/schema/front_page.schema.yml` defines `front_page.settings` (type `config_object`) with
`enabled`, `disable_for_administrators`, `home_link_path` (path — see
[home-links.md](home-links.md)) and a `roles` sequence of `front_page.settings.role`
(`enabled` bool, `weight` int, `path` path). No `config/install` default ships, so on enable the object
is empty until the form is saved. `front_page_user_role_delete()` clears `roles.<role>` when a role is
deleted; `front_page_update_8101()` migrated the legacy `enable` and `rid_*` keys to `enabled` /
`roles.*`.
