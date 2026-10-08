# Configure per-domain site settings

Two admin routes (both gated by permission `domain site settings`, `_admin_route: TRUE`):

| Route | Path | Handler | Purpose |
|---|---|---|---|
| `domain_site_settings.list` | `admin/config/domain/domain_site_settings` | `DomainSiteSettingsController::domainList` | Table of every `domain` entity (Name, Hostname, Edit link). This is the module's `configure` link. |
| `domain_site_settings.config_form` | `admin/config/domain/domain_site_settings/{domain}/edit` | `DomainConfigSettingsForm` | Edit one domain's settings. `{domain}` is upcast to a `domain` config entity. |

The list has no per-domain access filtering — the same permission exposes the Edit link and the edit
form for **every** domain; there is no notion of a user owning a subset of domains.

## The settings form

`DomainConfigSettingsForm` extends `ConfigFormBase`; editable config is
`domain_site_settings.domainconfigsettings`. Fields:

| Form field | Type | Stored key | Notes |
|---|---|---|---|
| Site name | textfield (required) | `<domain_id>.site_name` | Defaults to `system.site:name` until saved. |
| Slogan | textfield | `<domain_id>.site_slogan` | Defaults to `system.site:slogan`. |
| Email address | email (required) | `<domain_id>.site_mail` | Defaults to `system.site:mail`, or `ini_get('sendmail_from')` if empty. |
| Default front page | textfield | `<domain_id>.site_frontpage` | Relative path; alias resolved to system path on save. Empty → stored as `/user/login`. |
| Default 403 page | textfield | `<domain_id>.site_403` | Optional internal path. |
| Default 404 page | textfield | `<domain_id>.site_404` | Optional internal path. |

`domain_id` is carried in a hidden field and is the `domain` entity id (machine name), e.g. `default`.
Before any save, form defaults fall back to the current `system.site` values; once
`$config->get(<domain_id>)` is non-null the saved per-domain values are shown instead.

### Validation (`validateForm`)

- Front page: empty → coerced to `/user/login`; otherwise the alias is normalized to its system path.
- Front / 403 / 404: each non-empty value must start with `/` and pass
  `path.validator::isValid()` (so a user can only point at paths they can access).

### Storage layout

All domains share the one config object, flat-keyed by domain id. Example:

```yaml
# domain_site_settings.domainconfigsettings
default:
  site_name: 'Example One'
  site_slogan: 'First brand'
  site_mail: 'one@example.com'
  site_frontpage: '/node/1'
  site_403: '/403'
  site_404: '/404'
example_two:
  site_name: 'Example Two'
  # ...
```

Set it from PHP without the form:

```php
\Drupal::configFactory()
  ->getEditable('domain_site_settings.domainconfigsettings')
  ->set('default.site_name', 'Example One')
  ->set('default.site_mail', 'one@example.com')
  ->set('default.site_frontpage', '/node/1')
  ->save();
```

There is **no config schema** shipped for this object (no `config/schema/`), so the values are
untyped/unvalidated by the schema system.

## How values reach the site at runtime

`Configuration\DomainConfigOverride` (service `domain_site_settings.overrider`, tag
`config.factory.override` priority 5) implements `ConfigFactoryOverrideInterface::loadOverrides()`:

1. Only acts when `system.site` is among the requested names.
2. Resolves the active domain via `\Drupal::service('domain.negotiator')->getActiveDomain()`.
3. If `domain_site_settings.domainconfigsettings:<domain_id>` exists, overrides `system.site` with the
   per-domain `name`, `slogan`, `mail`, `page.403`, `page.404`, and `page.front` (front falls back to
   `/node` when unset).

So visiting a given domain transparently serves that domain's name/slogan/mail/front/error pages.
`getCacheableMetadata()` returns empty metadata (no cache contexts/tags added by the override).
