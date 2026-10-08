# How the admin theme is forced (the theme negotiator)

The behaviour is a single theme negotiator, `Drupal\layout_builder_admin_theme\Theme\
LBATAdminNegotiator`, implementing `ThemeNegotiatorInterface`.

## Service registration

```yaml
services:
  theme.negotiator.layout_builder_admin_theme:
    class: Drupal\layout_builder_admin_theme\Theme\LBATAdminNegotiator
    arguments: ['@config.factory']
    tags:
      - { name: theme_negotiator, priority: 501 }
```

Priority `501` places it above most core negotiators (the admin-route negotiator runs around
priority 100), so on Layout Builder routes this negotiator wins and its theme is used.

## `applies(RouteMatchInterface $route_match)` — when it fires

Returns `TRUE` only when **all** of these hold:

1. Config gate: `layout_builder_admin_theme.config:lbat_enable_admin_theme` is truthy.
   If it is `false`/unset, `applies()` returns `FALSE` immediately.
2. There is a route object on the match.
3. The route has a form default — `$route->getDefault('_entity_form') ?? getDefault('_form')`
   — i.e. it is a form route. Non-form routes never match.
4. The form is one of the Layout Builder editing forms:
   - `$form_class === RevertOverridesForm::class`
     (`Drupal\layout_builder\Form\RevertOverridesForm`), **or**
   - `$form_class === DiscardLayoutChangesForm::class`
     (`Drupal\layout_builder\Form\DiscardLayoutChangesForm`), **or**
   - the form id, split on `.`, has a **last segment equal to `layout_builder`** (this catches
     the main Layout Builder editing UI whose form default ends in `.layout_builder`).

The class name is compared with a leading backslash trimmed (`ltrim($form, '\\')`).

## `determineActiveTheme(RouteMatchInterface $route_match)` — which theme

```php
return $this->configFactory->get('system.theme')->get('admin');
```

It returns the site's configured **admin theme machine name** (`system.theme:admin`, e.g.
`claro`). So the theme Layout Builder editing uses is whatever the site's admin theme is — the
module has no theme setting of its own.

## Consequences an agent should know

- **The only on/off control is the config flag** — see
  [../configure/settings.md](../configure/settings.md).
- **It is scoped to Layout Builder form routes**, not to all admin/back-office pages. Regular
  front-end pages and non-Layout-Builder routes are unaffected.
- **Change the admin theme, change the result.** Setting a different `system.theme:admin` makes
  Layout Builder editing render in that theme instead.
- **No permissions/Drush/plugins.** The config form is gated by the core permission
  `administer site configuration`.
- To force a *different* theme on Layout Builder routes than the admin theme, you would need to
  register a competing `theme_negotiator` with a higher priority than `501`.
