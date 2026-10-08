<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Unpublished 404 — agent index

Turns the **403** that Drupal returns for an unpublished node the visitor can't see into a **404**,
so the node's existence isn't leaked. Zero configuration — enabling the module is the whole setup.

- **Exactly when and how the 403→404 swap happens (the subscriber, the condition, the permission)** →
  [api/behavior.md](api/behavior.md)

Key facts:
- No configure route (`configure: null`), no config, no config schema, no permissions of its own,
  no Drush, no plugins, no dependencies beyond core.
- Service `unpublished_404.not_found` (`Drupal\unpublished_404\EventSubscriber\NotFound`) extends
  `HttpExceptionSubscriberBase`, handles `on403` at **priority 1000**, HTML responses only.
- Converts to 404 only when: the user lacks `view own unpublished content` **and** the request has a
  `node` route parameter **and** that node `->isPublished()` is FALSE. Otherwise the 403 stands.
