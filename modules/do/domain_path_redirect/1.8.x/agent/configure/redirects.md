# Managing per-domain redirects

There is **no settings form**. The module's whole surface is the `domain_path_redirect` content
entity and its admin routes. Each redirect record is scoped to one domain via an extra `domain`
reference field; everything else is inherited from the Redirect module's entity.

## Routes (`domain_path_redirect.routing.yml`)

| Route | Path | Handler | Access requirement |
|---|---|---|---|
| `domain_path_redirect.list` | `/admin/config/search/domain_path_redirect` | `_entity_list: domain_path_redirect` | `_permission: administer redirects` |
| `domain_path_redirect.add` | `…/domain_path_redirect/add` | `_entity_form: domain_path_redirect.default` | `_entity_create_access: domain_path_redirect` |
| `entity.domain_path_redirect.canonical` | `…/edit/{domain_path_redirect}` | `_entity_form: domain_path_redirect.edit` | `_entity_access: domain_path_redirect.update` |
| `entity.domain_path_redirect.edit_form` | `…/edit/{domain_path_redirect}` | `_entity_form: domain_path_redirect.edit` | `_entity_access: domain_path_redirect.update` |
| `entity.domain_path_redirect.delete_form` | `…/delete/{domain_path_redirect}` | `_entity_form: domain_path_redirect.delete` | `_entity_access: domain_path_redirect.delete` |

Menu/task/action links: `.list` under `system.admin_config_search` (menu), an "Add redirect" action
link on the list, and a "Domain URL Redirects" local task. Entity access resolves through the
`admin_permission: administer redirects` on the entity type, so all of the above effectively require
**`administer redirects`** (defined by the Redirect module — there is no per-domain permission split).

## Entity fields

The entity class `Drupal\domain_path_redirect\Entity\DomainPathRedirect` **extends**
`Drupal\redirect\Entity\Redirect`, so it inherits all of Redirect's base fields and adds/overrides a few:

| Field | Type | Source | Notes |
|---|---|---|---|
| `rid` | integer (id) | Redirect | Primary key. |
| `type` | bundle | Redirect | Default bundle `domain_path_redirect` (set in `preCreate()`). |
| `language` | langcode | Redirect | `LANGCODE_NOT_SPECIFIED` = "- All languages -". |
| `redirect_source` | link source (path + query) | Redirect | The "from" path (no leading `/`, no `<front>`, no `#`). Entity label. |
| `redirect_redirect` | link | Redirect | The "to" URL (internal or external, per Redirect's link field). |
| `status_code` | integer | Redirect | HTTP status; form defaults to `redirect.settings:default_status_code`. |
| `hash` | string | Redirect | Recomputed in `preSave()` — see below. Unique key. |
| `enabled` | boolean | this module (`enabled` published key) | Default TRUE. Only `enabled = 1` rows are matched. |
| `domain` | entity_reference → `domain` | this module | The domain the redirect applies to. Default = active domain via `getCurrentDomainId()` → `domain.negotiator::getActiveId()`. Revisionable, translatable, autocomplete widget. |

The **hash** is what scopes a redirect to a domain. `preSave()` calls
`DomainPathRedirect::generateDomainHash($source_path, $domain_target_id, $source_query, $language)`,
which base64-hashes a serialized, ksort-normalised array of `source` (lower-cased path), `language`,
`domain`, and optional `source_query`. The same `(source, language, query)` on two different domains
produces two different hashes — that is how the same path can redirect differently per domain. The
add/edit form rejects duplicates by recomputing this hash and calling `loadByProperties(['hash' => …])`.

## Form behaviour (`DomainPathRedirectForm`)

- On the **add** form, the source/destination can be pre-filled from GET params `source`,
  `redirect`, `source_query`, `redirect_options`, `language` (`prepareEntity()`), mirroring core
  Redirect's add form. The record is still only created on submit by an authorized user.
- `validateForm()` rejects: source `<front>`, source containing `#`, source starting with `/`,
  source URL identical to destination URL (self-loop), and a duplicate hash on the same domain.
- The domain autocomplete has an AJAX callback (`updatePreview`) that shows the domain's base path as
  a `#field_prefix` on the source element, so an editor sees which domain the "from" path is under.

## Create / manage without the UI

Programmatically (an admin-context script — entity access still applies through the UI, but direct
entity ops bypass it):

```php
$redirect = \Drupal::entityTypeManager()
  ->getStorage('domain_path_redirect')
  ->create(['type' => 'domain_path_redirect']);
$redirect->setSource('offers');                       // no leading slash
$redirect->setRedirect('internal:/node/25');          // or an external URL
$redirect->set('domain', 'example_com');              // target domain machine name
$redirect->setStatusCode(301);
$redirect->set('enabled', TRUE);
$redirect->setLanguage(\Drupal\Core\Language\Language::LANGCODE_NOT_SPECIFIED);
$redirect->save();                                    // preSave() computes the domain-scoped hash
```

Drush: no dedicated commands. Use `drush php:eval` with the snippet above, or
`drush entity:delete domain_path_redirect <id>` to remove one.

## Config & schema

The module defines **no config object of its own**; it reads the Redirect module's `redirect.settings`
(`default_status_code`, `passthrough_querystring`). Shipped config:

- `config/install/views.view.domain_path_redirect.yml` — the default admin listing view (see
  [views/views.md](../views/views.md)).
- `config/optional/language.content_settings.domain_path_redirect.redirect.yml` — enables
  `language_alterable: true` for the bundle (a language selector on the form) even though the entity
  itself is `translatable: FALSE`.
- `config/schema/domain_path_redirect.schema.yml` — schema only for the `views.filter.domain_autocomplete`
  Views filter plugin.

Because redirects are **content**, they are not part of a config export — plan a content migration or
entity export when moving redirects between environments.
