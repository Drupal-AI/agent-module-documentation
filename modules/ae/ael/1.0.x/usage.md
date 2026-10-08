<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
As Event Listener (ael) lets modules register event listeners with Symfony's `#[AsEventListener]` PHP attribute instead of hand-tagging services in *.services.yml.

---

As Event Listener is a small framework helper for developers. In Drupal you normally subscribe to events by writing an `EventSubscriberInterface` service tagged `event_subscriber`. Symfony ships an `#[AsEventListener]` attribute that registers a class (or a single method) as a listener declaratively, but Drupal's container does not enable it out of the box. This module's `AelServiceProvider` turns on container autoconfiguration for that attribute (and registers Symfony's kernel event aliases), so any autoconfigured/autowired service class or method carrying `#[AsEventListener]` is tagged `kernel.event_listener` automatically. It has no UI, routes, permissions, entities or config — it only changes how listeners can be declared. Requires Drupal 11.3+. (The feature is proposed for core in issue #3376163; this module provides it until then.)

---

- Register an event listener with `#[AsEventListener]` on a class.
- Register a single method as a listener with `#[AsEventListener]`.
- Set the target event via the attribute's `event:` argument.
- Order listeners with the attribute's `priority:` argument.
- Avoid writing an `EventSubscriberInterface` for simple listeners.
- Avoid hand-adding the `event_subscriber` service tag.
- Use `__invoke()` as a class-level listener callback.
- Keep listener wiring next to the listener code (attribute-based).
- Rely on `autoconfigure: true` / `autowire: true` service defaults.
- Modernize event handling in a custom module.
- Use Symfony kernel event aliases in Drupal.
- Adopt the pattern ahead of it landing in Drupal core.
- Reduce `*.services.yml` boilerplate for event wiring.
- Register multiple listeners on one class via repeated attributes.
- Provide a framework/developer dependency for another module.
- Prototype event handling quickly during development.
- Standardize listener declaration across a codebase.
- Enable declarative listeners without a compiler pass of your own.
