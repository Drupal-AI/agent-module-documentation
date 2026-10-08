# Configuration

Configuration Tweak has two parts: a small settings form where you turn each tweak
on or off, and a per-item opt-in you add to the config YAML of the specific fields
or Entity Browser widgets you want affected. A tweak only changes an item that has
*both* been enabled here and opted in on that item.

## Open the settings form

1. Log in as a user with the **Administer site configuration** (`administer site
   configuration`) permission.
2. Go to **Configuration → Development → Config tweak**, or navigate directly to
   `/admin/config/development/config_tweak`.

The form lets you toggle which dependency-stripping tweaks are active.

## Tweak 1 — entity-reference target dependencies

When enabled, this tweak removes the dependency that an entity-reference field
records on its target bundles, which is a common source of circular dependencies and
config-report churn. To opt a specific field in, add `dependencies_optional: yes` to
that field's configuration (in its `field.field.*.yml`), alongside the handler
settings:

```yaml
settings:
  handler_settings:
    dependencies_optional: yes
    target_bundles:
      ...
```

## Tweak 2 — Entity Browser view widget dependency

When enabled, this tweak removes the dependency that an Entity Browser records on its
view widget. This one **requires the patch** from drupal.org issue 3035036 to be
applied. To opt a specific Entity Browser widget in, add `dependencies_optional: yes`
to that widget in its `entity_browser.browser.*.yml`:

```yaml
widgets:
  <widget-uuid>:
    settings:
      dependencies_optional: yes
      view: <view_id>
```

## Applying your changes

After enabling the tweaks and adding the `dependencies_optional: yes` opt-ins,
re-export your configuration (for example `drush cex`). The affected dependencies
will no longer be written into the exported config, which is what keeps the
Configuration updates report clean and stabilises your config diffs across
environments. Enable only the tweaks and opt in only the items you actually need —
the effect is limited to what is written into exported configuration and nothing
else.
