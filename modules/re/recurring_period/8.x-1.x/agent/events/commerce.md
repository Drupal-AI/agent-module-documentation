<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Commerce referenceable-plugin-types integration

`Drupal\recurring_period\EventSubscriber\ReferenceablePluginTypesSubscriber`
(service `recurring_period.referenceable_plugin_types_subscriber`) registers the `recurring_period`
plugin type so it can be targeted by Commerce's plugin-reference field (`commerce_plugin_item`),
letting site builders/entities store a reference to a configured recurring-period plugin.

- Subscribes to `CommerceEvents::REFERENCEABLE_PLUGIN_TYPES` and adds
  `$plugin_types['recurring_period'] = t('Recurring period')` in `onPluginTypes()`.
- **Conditional on Commerce being installed.** `getSubscribedEvents()` checks
  `class_exists(\Drupal\commerce\Event\CommerceEvents::class)` and returns an empty subscription array
  when the class is absent, so the subscriber is inert without Commerce (Commerce is not a dependency
  of this module).

No configuration. If Commerce is present, the plugin type simply appears among the referenceable
plugin types; otherwise nothing happens.
