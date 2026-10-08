# User Redirect — configuration

## Settings form

- Route: `user_redirect.settings`
- Path: `/admin/people/users/redirect/form/settings`
- Permission required: `administer user redirect settings` (`restrict access: true`)
- Menu: appears under *Administration » People* (`user.admin_index`).
- Form id: `config_settings_form` (`UserRedirectSettingsForm`, a `ConfigFormBase`).

The form renders every non-anonymous role in two draggable tables — **Login** and
**Logout** — each column being *Role*, *Redirect URL*, *Weight*. It also has an **Ignore
paths** textarea and an **Ignore the above paths for** checkbox set (`login`, `logout`).

## Config object: `user_redirect.settings`

There is **no `config/install`** file, so this object does not exist until the form is saved
once. Structure after saving:

```yaml
login:
  administrator:
    redirect_url: '/admin/content'   # internal ('/...') or external ('https://...')
    weight: 0
  content_editor:
    redirect_url: '/dashboard'
    weight: -1
logout:
  authenticated:
    redirect_url: '/'
    weight: 0
ignore:                              # array of path patterns (aliases), one per entry
  - '/user/reset/*'
ignore_for:                          # which flows the ignore list suppresses
  login: 'login'                     # value = key when ticked, 0 when not
  logout: 0
```

- Keys under `login` / `logout` are **role machine ids** (`administrator`, `content_editor`,
  `authenticated`, plus any custom role). Anonymous is excluded.
- Empty `redirect_url` = no redirect for that role.
- `ignore` defaults (in the form) to `/user/reset/*` if never set; stored as an array
  (the form splits the textarea on newlines and drops empty lines).
- `ignore_for` defaults to `['login']`.

## Reading / writing with drush

```bash
# read
drush config:get user_redirect.settings

# set a login redirect for the administrator role
drush config:set user_redirect.settings login.administrator.redirect_url '/admin/content' -y
drush config:set user_redirect.settings login.administrator.weight 0 -y

# set a logout redirect for authenticated users to the front page
drush config:set user_redirect.settings logout.authenticated.redirect_url '/' -y
```

## Validation (on form save)

A Redirect URL is accepted when it is a valid internal path (via `path.validator`) OR passes
`UrlHelper::isValid($url, TRUE)` OR is external (`UrlHelper::isExternal()`). Otherwise the
form shows "Redirect URL is invalid." Empty is always allowed.

## Permission

```yaml
administer user redirect settings:
  title: 'Administer User Redirect Settings'
  restrict access: true
```

Gates the settings form only. There is no per-user or runtime permission — the redirect
itself runs for every logging-in/out user based on their roles.
