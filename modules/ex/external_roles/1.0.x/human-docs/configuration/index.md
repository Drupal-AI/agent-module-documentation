# Configuration

External Roles is configured in two places, both outside the admin UI: you
**define the role→permission mapping in `settings.php`**, and you **assign
external roles to users in code**. This page walks through both, and closes with
the cache rule that keeps the grants correct.

## Why there's no admin form

The mapping deliberately lives in `settings.php` rather than in editable site
configuration. That keeps it server-side and admin-controlled — the grants can't
be tampered with through the site's UI. This is the safe-by-design choice for
driving permissions from an external identity source, and it's worth preserving:
resist the urge to move the mapping into user-editable config.

## Step 1 — Define external roles in `settings.php`

Add a `$settings['external_roles']` array. Each key is an external role's machine
name; each entry gives the role a human-readable name and the list of Drupal
permissions it should grant:

```php
$settings['external_roles'] = [
  'alpha' => [
    'name' => 'Alpha',
    'permissions' => [
      'access foo',
    ],
  ],
  'beta' => [
    'name' => 'Beta',
    'permissions' => [
      'access foo',
      'access bar',
    ],
  ],
];
```

Every permission you list here is granted to every user who carries that external
role. **Treat each line as a privilege decision** — keep high-privilege
permissions (anything named *administer …*, and similar) out of roles your
identity provider assigns widely, so you don't accidentally over-grant.

## Step 2 — Assign external roles to users in code

External roles are attached to users through the module's `ExternalRolesUser`
wrapper. The most common place to do this is `hook_user_presave()`:

```php
function my_module_user_presave(\Drupal\user\UserInterface $user): void {
  $wrapped_user = new \Drupal\external_roles\ExternalRolesUser($user);
  $wrapped_user->addExternalRole('alpha');
  $wrapped_user->addExternalRole('beta');
}
```

If you authenticate with **OpenID Connect**, a natural place to assign roles is
the user-info save hook, mapping the identity provider's reported roles onto your
external roles (validate them first):

```php
function my_module_openid_connect_userinfo_save(\Drupal\user\UserInterface $account, array $context) {
  $roles = /* roles from the identity provider */;
  $wrapped_user = new \Drupal\external_roles\ExternalRolesUser($account);
  foreach ($roles as $role) {
    if (!my_module_validate_role($role)) {
      continue;
    }
    $wrapped_user->addExternalRole($role);
  }
}
```

## Step 3 — Rebuild the cache after any change

The Access Policy API relies heavily on caching to work out permissions
efficiently (the module registers a `user.external_roles` cache context). **For
security reasons, you must rebuild the cache whenever the external-roles
definition changes** — otherwise stale, cached grants can linger. Run:

```bash
drush cr
```

## Advanced: a custom roles repository

The `settings.php` array is the built-in source, but the mapping is served through
a swappable `ExternalRolesRepositoryInterface`. If you'd rather keep definitions
in, say, a YAML file shipped with a module, you can implement your own repository
class and override the `external_roles.repository` service to point at it. This is
purely optional — the `settings.php` approach above is the minimal, recommended
setup.
