# Configuration

You configure Config Role Split by creating one or more **Role Split** entities.
Each one describes which role permissions the module should manage during config
sync, and how. Remember: **nothing happens on the running site** — the effect only
shows up when you export or import configuration.

## Open the admin screen

1. Log in as a user with the **Administer config role split** permission.
2. Go to **Configuration → Development → Configuration synchronization → Config
   Role Split** (`/admin/config/development/configuration/config-role-split`).
3. Choose **Add** to create a Role Split (edit and delete are on the same screen).

## The Role Split form, field by field

- **Label** — a human‑friendly name for this split (for example "Production admin
  extras"). Admin‑facing only.
- **Machine name** — the internal id, generated from the label.
- **Mode** — how the managed permissions are handled during sync. Pick one:
  - **Split** (the default) — fully remove the managed permissions from exported
    config, storing them only in this split, and merge them back on import. Use this
    when a permission should live *only* in the split and never in shared config.
  - **Fork** — like split, but non‑destructive on export: it won't strip
    permissions that are already present in the sync directory. A gentler, additive
    variant.
  - **Exclude** — the inverse: treat the managed permissions as a blocklist and
    remove them on import so they can never reach active config.
- **Weight** — the order this filter runs relative to other splits (smaller /
  negative runs first). Leave at `0` unless you have several splits that must apply
  in a defined order.
- **Status (enabled)** — only enabled splits run during sync.
- **Roles and permissions** — the heart of the split: a map of **role → the list of
  permissions** the filter should manage for that role. You only list the roles and
  the specific permissions you want the filter to touch — everything else passes
  through untouched. Roles are identified by their machine name (for example
  `administrator`, `authenticated`) and permissions by their exact permission
  string (for example `access devel information`, `access content`).

### Example

A split named *Production admin extras* in **split** mode, managing one permission
on `administrator` and one on `authenticated`, would look like this as
configuration:

```yaml
id: prod_admin
label: 'Production admin extras'
weight: 0
status: true
mode: split
roles:
  administrator:
    - 'access devel information'
  authenticated:
    - 'access user profiles'
```

With this active, `access devel information` is stripped out of the exported
`user.role.administrator.yml` and re‑applied on every import — so you can keep it on
staging without it ever landing in production config.

## What each mode does, at a glance

| Mode | On export | On import |
|------|-----------|-----------|
| **split** | remove the managed permissions from the exported role | merge them back onto the role |
| **fork** | remove only managed permissions not already in the sync directory | merge them onto the role |
| **exclude** | add them back to the export if the site already has them | remove them so they never reach active config |

The filter also recalculates each role's config *dependencies* to match the
permissions that remain, so exported role files stay valid.

## Seeing the effect

Because this is a config‑sync filter, there's no live change to observe. To verify
a split, run an export and inspect the resulting role file:

```bash
drush config:export
# then diff the sync directory's user.role.<id>.yml against the site's active permissions
```

There are no Drush commands specific to this module — you drive it entirely through
core's `drush config:export` / `drush config:import`.

## Per‑environment overrides

A split's **weight** and **status** can be overridden per environment in
`settings.php`, for example to disable a split on production:

```php
$config['config_role_split.role_split.prod_admin']['status'] = FALSE;
```

Because the filter plugins are derived from these entities and cached, clear caches
after changing an override for it to take effect. The `roles` and `mode` are always
read from the stored config, so deployments stay deterministic.
