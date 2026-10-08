# Configuration

All of Login Switch's behavior lives on a single settings form. The module ships with
everything switched off, so nothing changes until you configure it here.

## Open the settings form

1. Log in as a user with the **Administer site configuration** permission (an
   administrator by default).
2. Go to **Configuration → People → Login Switch**, or navigate directly to
   `/admin/config/people/login-switch`.

## How the form is organized

The form has three parallel sections — one for each authentication route:

| Section | Core route it controls | Default path |
|---------|------------------------|--------------|
| **Login** | `user.login` | `/user/login` |
| **Register** | `user.register` | `/user/register` |
| **Password** | `user.pass` | `/user/password` |

Each section offers the same three controls, described below. They work
independently, so you can (for example) move login, disable registration, and leave
password reset untouched.

### Enable / disable this override (the checkbox)

Each route has a checkbox that turns Login Switch's handling of that route **on**.
While it is unchecked, the route is left exactly as Drupal core ships it. Check it to
activate the path field below — and to decide the route's fate based on what you type
there.

### New path

When the override is switched on, whatever you type in the **path** field becomes the
route's new address. Type it **without a leading slash** — for example `secret-login`
moves the login form to `/secret-login`. (The form trims any stray slashes for you.)

Here is the key rule to remember:

- **Override on + a path filled in** → the route moves to that path.
- **Override on + the path left empty** → the route is *denied* entirely (it returns
  an access‑denied response). This is how you fully switch off, say, public
  registration.

### Add noindex header

Each route also has a **noindex** checkbox. Tick it and Login Switch adds an
`X‑Robots‑Tag: noindex` header whenever that page is served, telling search engines
to keep it out of their results. This works whether or not you have moved or disabled
the route — it simply tags the page as "do not index." It is a clean way to keep your
login, registration, and password pages private without editing `robots.txt`.

## Save

Click **Save configuration**. The form rebuilds Drupal's router for you, so the new
paths take effect immediately. If the old paths still seem to work, run `drush cr` to
clear caches.

## A worked example

Say you want to move the login form to `/staff-login` and hide it from search
engines, and to switch off public registration completely:

- **Login** section: tick the override checkbox, type `staff-login` in the path
  field, and tick the noindex checkbox.
- **Register** section: tick the override checkbox and leave the path field empty
  (this denies the registration route).
- **Password** section: leave it alone.

Save, and `/user/login` now lives at `/staff-login` (unindexed) while
`/user/register` returns access‑denied. As a bonus, because login handling is active,
anonymous visitors hitting `/user` get a 404 instead of a tell‑tale redirect to the
login page.

## Setting it per environment

Because everything is a single config object (`login_switch.settings`), you can
override the paths per environment from `settings.php` — for example, keep the real
`/user/login` open on your dev site but hide it on production:

```php
$config['login_switch.settings']['login_disabled'] = TRUE;
$config['login_switch.settings']['login_route'] = 'secret-login';
```

Note that setting the path alone is not enough — the matching `*_disabled` flag must
be `TRUE` for the override to apply. Run `drush cr` after changing config this way.
