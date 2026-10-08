<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# CAS Attributes — agent index

Maps attributes returned by a CAS server onto Drupal **user fields**, **roles** and **tokens**.
Extends `drupal/cas` (^3.0) and requires `token`.

Key facts:

- One config object: **`cas_attributes.settings`**. One settings form:
  route `cas_attributes.settings` → `/admin/config/people/cas/attributes`
  (permission `administer account settings`). A read-only helper page lists the current
  user's attributes at `/admin/config/people/cas/attributes/available`.
- No permissions of its own, no Drush commands, no plugin types, no services beyond one
  event subscriber (`Drupal\cas_attributes\Subscriber\CasAttributesSubscriber`, autowired).
- Token: **`[cas:attribute:<name>]`** (attribute name lower-cased; array modifiers such as
  `:first`, `:last`, `:count`, `:join` are supported).
- Sync frequency values are the enum `SyncFrequency`: **0 = Never, 1 = Initial registration
  only, 2 = Every login**.

Docs:

- **All settings keys, field mappings, role mappings, drush recipes** →
  [configure/settings.md](configure/settings.md)
- **Tokens: format, allow-list, where attributes come from** → [api/tokens.md](api/tokens.md)
- **The event subscriber: what runs when, comparison methods, deny rules** →
  [api/events.md](api/events.md)
