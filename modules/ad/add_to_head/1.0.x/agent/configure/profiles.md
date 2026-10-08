<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configure: Add To Head profiles

## Admin route

- Overview: `/admin/config/development/add-to-head` (route `add_to_head.admin`).
- Add: `/admin/config/development/add-to-head/add` (route `add_to_head.add_profile`).
- Edit: `/admin/config/development/add-to-head/{profile}/edit` (route `add_to_head.edit_profile`).
- Delete: `/admin/config/development/add-to-head/{profile}/delete` (route `add_to_head.delete_profile`).
- All four routes require permission **`administer add to head`** (`restrict access: TRUE` —
  it lets a user inject arbitrary markup/JS into every page, so only grant to trusted roles).
- `info.yml` sets `configure: add_to_head.admin`, so this is the module's "Configure" link on
  `/admin/modules`.

## Where profiles are stored

Profiles are **not** config entities. They all live in one config object:

```
add_to_head.settings
  add_to_head_profiles:      # associative array, keyed by the profile's own machine `name`
    <name>:
      name: <name>            # string, must match ^[a-z0-9-]+$ (enforced by the edit form)
      code: <string>          # raw HTML/JS/CSS to inject verbatim (rendered via Markup::create — no escaping)
      scope: head|scripts|styles
      paths:
        visibility: include|exclude
        paths: "<newline-separated Drupal internal paths, '*' wildcard, '<front>' supported>"
      roles:
        visibility: include|exclude
        list: [<role_id>, ...]
```

This matches `config/schema/add_to_head.schema.yml` exactly (a `sequence` of `mapping` in the
schema, but in practice the module always stores/reads it as an array keyed by `name`, not by
numeric index — see `AddToHeadParamConverter::convert()`, which does
`array_key_exists($value, $settings) ? $settings[$value] : FALSE`, and
`AddToHeadProfileForm::submitForm()`, which does `$settings[$name] = [...]`).

The `{profile}` route parameter is resolved by `AddToHeadParamConverter` (param type
`add_to_head_profile`): it looks up `$value` as a key in `add_to_head_get_settings()`, so
`{profile}` in URLs is the profile's `name`, not a numeric delta.

## Scopes — which hook renders each

| `scope` value | Hook | Where it lands |
|---|---|---|
| `head` | `add_to_head_page_attachments_alter()` (`hook_page_attachments_alter`) | Appended to `$attachments['#attached']['html_head']`, one entry per profile keyed `add-to-head--<name>`. Renders early in `<head>`, before CSS and JS. |
| `scripts` | `add_to_head_page_bottom()` (`hook_page_bottom`) | Appended to page bottom output, cache key `add_to_head_<name>` with cache context `user.permissions`. Where "bottom" lands in the DOM depends on the active theme (often near `</body>`). |
| `styles` | `add_to_head_css_alter()` (`hook_css_alter`) | **No-op.** The form/schema accept `styles`, but the implementation body is commented out (`// @todo this does not work yet.`). A `styles`-scope profile is saved but never rendered anywhere. |

Code is inserted **unescaped** via `Markup::create($profile['code'])` — this is by design (the
module's whole purpose is raw markup injection), which is why the permission is
`restrict access: TRUE`.

## Path visibility

`add_to_head_match_page($profile)` compares the current path (and its alias, and `$_GET['q']`)
against `paths.paths` using `path.matcher`:
- `visibility: exclude` (default) → shown on every page **except** the listed paths.
- `visibility: include` → shown **only** on the listed paths.
- `paths.paths` is empty and visibility is `exclude` → matches nothing, so "no paths" +
  `exclude` = shown on **all** pages.
- `paths.paths` is empty and visibility is `include` → shown on **no** pages.

## Role visibility

`add_to_head_match_role($profile)` intersects the current user's roles with `roles.list`:
- `visibility: exclude` (default) → shown for every role **except** an intersecting one; if
  `roles.list` is empty, shown for everyone.
- `visibility: include` → shown only if the user has at least one role in `roles.list`; if
  `roles.list` is empty, shown for **no one**.

A profile only renders when both the path check and the role check pass
(`_add_to_head_profile_visible()`).

## Reading / writing via config API or drush

```bash
# list all profiles
drush cget add_to_head.settings add_to_head_profiles

# read one profile by name
drush php:eval '
  $p = \Drupal::config("add_to_head.settings")->get("add_to_head_profiles")["my-profile"] ?? NULL;
  print_r($p);
'
```

To write a profile from code (matches exactly what the admin form produces — see
`api/helpers.md` for the `add_to_head_set_settings()` helper):

```php
$settings = \Drupal::config('add_to_head.settings')->get('add_to_head_profiles') ?? [];
$settings['my-profile'] = [
  'name' => 'my-profile',
  'code' => '<meta name="example" content="1">',
  'scope' => 'head',
  'paths' => ['visibility' => 'exclude', 'paths' => ''],
  'roles' => ['visibility' => 'exclude', 'list' => []],
];
\Drupal::configFactory()->getEditable('add_to_head.settings')
  ->set('add_to_head_profiles', $settings)
  ->save();
```

Clear caches (`drush cr`) after writing profiles via the config API directly — the admin form
does this implicitly via its own cache invalidation, but a raw config write does not always
bust the render cache for anonymous/page-cached responses.
