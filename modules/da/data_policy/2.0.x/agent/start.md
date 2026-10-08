<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Data Policy (data_policy) — agent index

Versioned **data-policy / privacy statement** with an **enforced agreement step** and a per-user,
per-revision **consent record**. An admin authors one or more `data_policy` entities and references
them from a free-text *consent text* using `[id:N]` tokens (`[id:N*]` = required); a request
subscriber redirects users who have not agreed to the current required revision. Submodule
`data_policy_export` exports consent records to a private CSV. From the Open Social ecosystem.
Version **2.0.9**, core `^10.2 || ^11`, depends on core `block` and `path_alias`.

## WARNING — enabling this module breaks `module_installer` (verified on Drupal 11.4.x)

`DataPolicyServiceProvider::alter()` replaces the core `module_installer` class and appends two
arguments:

```php
$container->getDefinition('module_installer')
  ->setClass(DataPolicyModuleInstaller::class)
  ->addArgument(new Reference('entity_type.manager'))
  ->addArgument(new Reference('config.factory'));
```

Result: `\Drupal::service('module_installer')` throws
`ServiceCircularReferenceException: Circular reference detected for service "module_installer"`.
Reproduced live on this site. Consequences:

- **All `drush pm:*` commands disappear** ("There are no commands defined in the \"pm\" namespace")
  — this is why `drush pm:list` errors while the module is enabled.
- **No module can be installed or uninstalled**, including `data_policy` itself.
- The site keeps serving pages, so the breakage is silent until someone tries to install something.
- **Recovery:** manually remove `data_policy` from `core.extension` config and rebuild caches.

This is an availability/operational defect, not a code-execution or access-control vulnerability.

## Core mechanism

- The policy statement is a **revisionable `data_policy` content entity**; its text is the
  `field_description` (`text_long`) field. See [entities](entities/data-policy-and-user-consent.md).
- A **`user_consent` content entity** is created per user per policy revision, holding a `state`
  (0 undecided / 1 not agree / 2 agree). See [entities](entities/data-policy-and-user-consent.md).
- Enforcement is driven by a **free-text consent text** (`data_policy.data_policy:consent_text`)
  containing `[id:N]` / `[id:N*]` tokens, evaluated by `RedirectSubscriber` on every request.
  See [consent flow](consent/enforcement-and-agreement.md).
- Admin config: **inform blocks** (config entities of explanatory pop-up text per page) and the
  **settings form**. See [config](config/inform-blocks-and-settings.md).
- **`data_policy_export`** submodule adds a VBO CSV export of consent records.
  See [submodule](submodules/data-policy-export.md).

## Key routes

| Route | Path | Access |
|-------|------|--------|
| `data_policy.data_policy.agreement` | `/data-policy-agreement` | user needs consent (`needConsent()`) |
| `data_policy.data_policy` | `/data-policy` | allowed if any policy is configured (public) |
| `data_policy.description` | `/inform-consent/{informblock}` | allowed if the inform block exists (public) |
| `entity.data_policy.collection` | `/admin/config/people/data-policy` | `administer data policy entities` |
| `data_policy.data_policy.settings` | `/admin/config/people/data-policy/settings` | `administer data policy settings` |
| `entity.informblock.collection` | `/admin/config/system/inform-consent` | `administer inform and consent settings` + `overview inform and consent settings` |
| `entity.user_consent.collection` | `/admin/reports/user-consents` | `overview user consents` |
| (view) `data_policy_agreements` | `/admin/reports/data-policy-agreements` | `overview user consents` |

## Permissions (data_policy.permissions.yml)

`administer inform and consent settings`, `overview inform and consent settings`,
`edit inform and consent setting`, `change inform and consent setting status`,
`overview user consents`, `administer data policy settings`,
`administer data policy entities` (restrict access), `edit data policy`,
`view all data policy revisions`, `access data policy revisions`,
`revert all data policy revisions`, `delete all data policy revisions`,
`without consent` (skip the whole enforcement flow).

## Services

- `data_policy.manager` (`DataPolicyConsentManager`) — the consent brain: parses the consent text,
  resolves active revisions, computes what the current user still owes, creates `user_consent`
  entities, and builds the agreement checkboxes.
- `data_policy.redirect_subscriber` (`RedirectSubscriber`) — KERNEL::REQUEST subscriber (priority
  28) that redirects un-consented users to the agreement form.

## Extension points

- `hook_data_policy_destination_alter($current_user, $destination)` — alter the post-agreement
  redirect destination (see `data_policy.api.php`).
- `data_policy_export` defines a plugin type `Plugin/DataPolicyExportPlugin`
  (`@DataPolicyExportPlugin` annotation) for adding extra CSV columns.
