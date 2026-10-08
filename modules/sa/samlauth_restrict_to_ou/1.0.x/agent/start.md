<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# SAML Authentication Restrict to OU (samlauth_restrict_to_ou) — agent index

A small add-on for **`samlauth`** (SAML Authentication) that turns a SAML **Organizational Unit**
attribute into a login gate. It does its whole job from one event subscriber
(`SamlRestrictSubscriber`) that subscribes to samlauth's **`SamlauthEvents::USER_SYNC`**
(`samlauth.user_sync`) event. On each SAML login samlauth fires that event *after the IdP response is
validated but before the Drupal user is logged in or a new account is saved*; the subscriber reads
the OU value(s) out of a configured SAML attribute (default `dn`, parsed with the regex
`/OU=([^,]+)/i` to pull every `OU=…` component out of an Active-Directory Distinguished Name),
compares them against an admin-configured allow-list, and — if the user does not qualify — **throws
an exception to abort the login**. A second subscriber method on `KernelEvents::RESPONSE` just
re-formats the denied-access message with a little HTML.

Everything is driven by one config object, `samlauth_restrict_to_ou.settings`, edited on a single
settings form. There is no controller, no route besides that settings page, no plugin type, no
service others consume, no drush.

- Depends on: `samlauth:samlauth` (hard). Requires composer `drupal/samlauth:^3.0 || ^4.0@dev`.
- Core: `^10 || ^11`. Package: `SAML`. Version **1.0.5** (dir `1.0.x`). GPL-2.0-or-later.
- Settings page / `configure` route: **yes** — `samlauth_restrict_to_ou.settings` at
  `/admin/config/people/saml-restrict`, gated by the permission `administer samlauth_restrict_to_ou`
  (`restrict access: true`).
- Permissions: one (`administer samlauth_restrict_to_ou`). Config schema: yes. Plugin types: none.
  Drush: none. Routes with callbacks: none.

## What you'd do → where

- **Configure the restriction (attribute, allow-list, strict mode, denied message) / understand every
  config key and default** → [configure/settings.md](configure/settings.md)
- **Understand exactly how the gate is enforced, the matching semantics (exact vs any/all), and where
  in samlauth's flow it runs** → [events/user-sync.md](events/user-sync.md)

## Key facts (real machine names)

- Config object: `samlauth_restrict_to_ou.settings`. Keys: `enabled` (bool), `saml_attribute_name`
  (string, default `dn`), `allowed_ous` (string, newline-separated list), `strict_mode` (bool),
  `denied_message` (string). Schema: `config/schema/samlauth_restrict_to_ou.schema.yml`.
- Route + menu link: `samlauth_restrict_to_ou.settings` → `/admin/config/people/saml-restrict`,
  form `Drupal\samlauth_restrict_to_ou\Form\SettingsForm` (form id `samlauth_restrict_to_ou_settings`),
  permission `administer samlauth_restrict_to_ou`. Menu link parent `user.admin_index`.
- Permission: `administer samlauth_restrict_to_ou` (`restrict access: true`).
- Service: `samlauth_restrict_to_ou.restrict_subscriber` →
  `Drupal\samlauth_restrict_to_ou\EventSubscriber\SamlRestrictSubscriber`, args `@config.factory`,
  `@messenger`, tag `event_subscriber`.
- Events subscribed: `SamlauthEvents::USER_SYNC` (`samlauth.user_sync`, priority **10**) → `onUserSync`;
  `KernelEvents::RESPONSE` (priority **-10**) → `onResponse`.
- OU parsing: `preg_match_all('/OU=([^,]+)/i', $dn, …)` over the attribute value(s); comparison is
  case-insensitive **exact** match (values are `trim`+`strtolower`ed on both sides). Block signal:
  `throw new \Exception("SAML_OU_RESTRICT_BLOCK")`.
