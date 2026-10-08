<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Hooks implemented

All three are OOP hooks declared with `#[Hook(...)]` on
`Drupal\orejime_register\Hook\OrejimeRegisterHooks` (service, `autowire: true`). The classic
`orejime_register.module` keeps thin `#[LegacyHook]` wrappers that delegate to the service, so both
the attribute and procedural dispatch resolve to the same code.

| hook | method | what it does |
|------|--------|--------------|
| `orejime_service_insert` (`hook_ENTITY_TYPE_insert`) | `orejimeServiceInsert(Orejime $entity)` | `Database::createColumn($entity)` — adds tinyint column `{name}_{id}` for the new consent service |
| `orejime_service_presave` (`hook_ENTITY_TYPE_presave`) | `orejimeServicePresave(Orejime $entity)` | `Database::updateColumn($entity)` — renames the column when a service's `name`/id changed (compares against the original entity) |
| `page_attachments` | `pageAttachments(&$page)` | attaches library `orejime_register/cookies-register` to every page |

`Orejime` = `Drupal\orejime\Entity\Orejime`, the `orejime_service` config entity defined by the
parent **orejime** module. This module never defines those entities; it only reacts to their
lifecycle to keep one register column per service (see [api/database.md](../api/database.md) for the
column mechanism).

## Library / JS

`orejime_register.libraries.yml` defines `cookies-register` (`js/cookies-register.js`, deps
`core/drupal` + `core/once`). The behavior `Drupal.behaviors.orejimeRegister` waits for
`window.orejime`, then on the consent manager's `update` event POSTs the full consent object to
`/orejime_register` (route `orejime_register.register`). There is no other integration point — a
site that uses the Orejime banner gets consent logging automatically once this module is enabled.

No `hook_uninstall`; `orejime_register.install` provides only `hook_schema()` and `hook_install()`
(the latter back-fills a column per existing `orejime_service`).
