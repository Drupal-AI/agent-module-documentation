<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Domain Access Simple Sitemap — manager, data model & hooks

## Service: `domain_simple_sitemap.manager`

Class `Drupal\domain_simple_sitemap\DomainSitemapManager`. Constructor args:
`@entity_type.manager`, `@domain.validator`.

- `addSitemapVariant(DomainInterface $domain)` — creates, if missing:
  1. a **`simple_sitemap_type`** config entity with `id` = the domain id, label
     `"<domain label> sitemap"`, `sitemap_generator: default`, and
     `url_generators: [domain_entity, custom, entity_menu_link_content, arbitrary]`;
     it sets the third-party setting `domain_simple_sitemap.sitemap_domain = <domain id>`;
  2. a **`simple_sitemap`** variant (id = domain id, `type` = that sitemap type, `status: TRUE`).
  Then it rebuilds the queue and generates (`simple_sitemap.generator`).
- `deleteSitemapVariant(DomainInterface $domain)` — deletes the `simple_sitemap_type` whose id
  is the domain id (which removes the variant).

```php
$mgr = \Drupal::service('domain_simple_sitemap.manager');
$mgr->addSitemapVariant($domain);   // e.g. after enabling the module on an existing domain
```

The identifying fact for any domain sitemap type/variant: its **id equals the domain id**, and
its `third_party_settings.domain_simple_sitemap.sitemap_domain` equals that same domain id.

## Hooks (implemented by the module, in `domain_simple_sitemap.module`)

- `hook_domain_insert` → `addSitemapVariant()` (auto-create on new domain).
- `hook_domain_update` → add or delete the variant depending on the domain's status (only on
  the active domain).
- `hook_domain_delete` → `deleteSitemapVariant()`.
- `hook_simple_sitemap_links_alter` → when `domain_simple_sitemap_replace_homepage` is on,
  rewrites a link whose path matches the domain front page to the domain base URL.
- `hook_form_simple_sitemap_type_edit_form_alter` → adds the "Select domain for this sitemap"
  select, stored via the entity builder as the `sitemap_domain` third-party setting.
- `hook_entity_type_build` → replaces the `simple_sitemap` entity class with
  `Drupal\domain_simple_sitemap\Entity\DomainSimpleSitemap`.

There is no `*.api.php`; the module invites no hooks of its own.
