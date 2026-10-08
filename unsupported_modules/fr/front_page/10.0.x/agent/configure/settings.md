# Configure Front Page

All state is the single config object **`front_page.settings`**. Permission for both forms:
`administer front page`.

## Config object: `front_page.settings`

| Key | Type | Meaning |
|---|---|---|
| `enabled` | boolean | Master switch. When false, no redirects happen at all. |
| `disable_for_administrators` | boolean | If true, users with the `administrator` role are never redirected (even when the `authenticated` override is enabled). |
| `home_link_path` | string (path) | Used by the outbound path processor to rewrite `<front>` / empty paths. Stored **without** a leading slash (e.g. `node/1`); the processor prepends `/`. |
| `roles` | mapping keyed by role id | Per-role override; each value is `{enabled: bool, weight: int, path: string}`. |

### Per-role override (`roles.<role_id>`)

```yaml
roles:
  anonymous:
    enabled: true
    weight: 0
    path: '/user/login'
  authenticated:
    enabled: true
    weight: 10
    path: '/dashboard'
```

- `path` must start with `/` and be a valid, accessible internal path (the settings form
  validates this; setting it in code skips validation).
- When a user has several enabled role overrides, the one with the **lowest `weight`** wins.

## Redirect behavior (runtime)

`FrontPageSubscriber` (subscribes to `KernelEvents::REQUEST`) acts only when:

- `enabled` is true **and** the request is the real front page (`path.matcher` `isFrontPage()`),
- not CLI/drush, not during install, not in maintenance mode, and the request is `index.php`.

It then picks the lowest-weight enabled role override for the current user and returns a
`RedirectResponse` to its `path` (carrying the current language and query string). The page
cache kill switch is triggered because the outcome depends on the user's roles. If the user
is an `administrator` and `disable_for_administrators` is true, no redirect occurs.

## Home-link rewriting

`FrontPagePathProcessor` (outbound path processor) rewrites a path of `/<front>` (or empty)
to `/<home_link_path>` when `home_link_path` is set. This changes where the theme's Home link
and `Url::fromRoute('<front>')` / `url('<front>')` point. Configure it on the **Home links**
form (`/admin/config/system/front/home-links`).

## Setting it in code

```php
$c = \Drupal::configFactory()->getEditable('front_page.settings');
$c->set('enabled', TRUE)
  ->set('disable_for_administrators', TRUE)
  ->set('roles.anonymous', ['enabled' => TRUE, 'weight' => 0, 'path' => '/user/login'])
  ->set('home_link_path', 'node/1')
  ->save();
```

Note: deleting a role deletes its override automatically (`front_page_user_role_delete()`).
