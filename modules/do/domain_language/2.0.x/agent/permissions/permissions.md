<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Permissions

`domain_language.permissions.yml` defines exactly one:

| Permission | `restrict access` | Effect |
|---|---|---|
| `bypass language restrictions` | true | *"Allows users to access all languages for all domains."* Users holding it skip **both** override branches in `DomainLanguageOverrider::loadOverrides()`, so they see the site-wide `system.site` default language and the unfiltered `language.negotiation` prefixes/domains on every domain. |

The admin form itself is **not** gated by this module: `domain_language.admin` requires
`administer domains`, which comes from Domain Access.

```bash
drush role:perm:add content_editor 'bypass language restrictions'
drush php:eval 'foreach (\Drupal\user\Entity\Role::loadMultiple() as $r) { if ($r->hasPermission("bypass language restrictions")) print $r->id() . "\n"; }'
```

Two things worth knowing before granting it:

- The bypass affects **config overrides**, so a user with the permission may see a different
  default language, different URL prefix behaviour and a different language switcher than an
  anonymous visitor on the same domain. That makes it a poor permission to give a role you use for
  QA-ing the public experience — grant it to a dedicated maintenance role instead.
- Because the override skip is decided per request from `current_user`, config caching is keyed by
  the domain (`getCacheSuffix()`) and the `url.site` context — **not** by permission. On a site
  with a shared render/config cache, verify that pages rendered for a bypassing user are not
  reused for other users before relying on this in production.

The language switcher alter (`hook_language_switch_links_alter`) does **not** check the
permission — the interface switcher is filtered for everyone, including bypassing users.
