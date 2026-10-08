<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Flexible Access grants access to entities based on a set of configurable access rules.

---

Flexible Access **grants access to entities based on configurable access rules** — a framework where admins
define rules that determine who may view/edit entities, layered on Drupal's entity access system. It provides its
own permissions.

Use it to implement custom entity-access policies without code. It is an **access-control** framework, and the key
consideration is that it **grants** access: rules return access results that can **allow** access core would
otherwise leave neutral (denied), so an **overly-broad or misconfigured rule can expose content** to users who
shouldn't see it. (Note: a `forbidden` result from any handler still wins, so it can't override an explicit deny,
but it can widen visibility.) Configure rules narrowly, test them against each role, and verify they don't
over-grant — especially for unpublished/private content. It composes with core entity access and any other access
modules. Configure the access rules carefully.

---

- Grant entity access via rules.
- Define who may view/edit entities.
- Layer on core entity access.
- Provide its own permissions.
- Serve access control.
- Implement no-code access policies.
- GRANT (allow) access core would leave denied.
- RISK exposing content via an overly-broad/misconfigured rule.
- Not override an explicit forbidden (forbidden still wins) but widen visibility.
- Configure rules narrowly + test per role + verify no over-grant (esp. unpublished/private).
- Compose with core + other access modules.
- Configure the access rules carefully.
- Handle flexible access.
- Grant access.
- Configure the rules.
- Gate entities.
- Handle the rules.
- Allow access.
- Verify the rules.
- Provide rule-based access.
