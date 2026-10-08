<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# ECA Simplenews (eca_simplenews) — agent index

Integrates the **ECA** rules engine with the **Simplenews** newsletter module. It exposes newsletter
subscription operations as ECA plugins so subscription workflows can be built as no-code
Event-Condition-Action models. Package `ECA`. Version dir **1.0.x** (installed `1.0.0-alpha1`).
Core `^10.4 || ^11.2`. License GPL-2.0-or-later.

## What it actually is (from source)

- **Depends on** `eca` and `simplenews` (^4) — from `eca_simplenews.info.yml`.
- Ships **only ECA plugin classes** under `src/Plugin/`. There is **no** `.module`, `.services.yml`,
  `.routing.yml`, `.permissions.yml`, `composer.json`, `config/install` or `config/schema` file.
  So: **no events**, no routes, no permissions, no services, no config schema, no Drush.
- Provides **2 ECA actions** and **3 ECA conditions** (plugin ids discovered from PHP attributes).
- Every plugin resolves its target address from the `[user:mail]` token and delegates to Simplenews'
  `simplenews.subscription_manager` service or the `\Drupal\simplenews\Entity\Subscriber` entity.

## Plugins

- **Actions** (subscribe / unsubscribe, config forms, `[user:mail]` target, `newsletter_id` machine name) →
  [plugins/actions.md](plugins/actions.md)
- **Conditions** (is-subscribed / has-subscribed / self-unsubscribe history check) →
  [plugins/conditions.md](plugins/conditions.md)

## Quick reference

| Plugin id | Type | Class |
| --- | --- | --- |
| `eca_simplenews_subscribe_to_newsletter` | Action | `Plugin/Action/SubscribeToNewsletterAction` |
| `eca_simplenews_unsubscribe_from_newsletter` | Action | `Plugin/Action/UnsubscribeFromNewsletterAction` |
| `eca_simplenews_is_subscribed_condition` | Condition | `Plugin/ECA/Condition/IsSubscribed` |
| `eca_simplenews_has_subscribed_condition` | Condition | `Plugin/ECA/Condition/HasSubscribed` |
| `eca_simplenews_check_for_self_unsubscribes` | Condition | `Plugin/ECA/Condition/CheckForSelfUnsubscribesCondition` |

Install: `drush en eca_simplenews` (pulls in `eca` + `simplenews`), then build models in ECA's model
editor. No configuration page of its own.
