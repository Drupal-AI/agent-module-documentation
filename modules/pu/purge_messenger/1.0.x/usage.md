<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Purge Messenger routes Purge cache invalidations through Symfony Messenger queues.

---

Purge integration with Symfony Messenger modifies the Purge module to use Symfony Messenger as the method for dispatching and executing cache invalidations — so purges are handled as Messenger messages (enabling async/distributed processing via Messenger transports) instead of Purge's default processors.

It's a performance/infrastructure integration with no content or access role of its own. Depends on `purge`, `sm` (Symfony Messenger), and core `serialization`; supports Drupal 10.5+ and 11.3+.

---

- Dispatch purges via Symfony Messenger.
- Execute invalidations as messages.
- Enable async purge processing.
- Support distributed processing.
- Use Messenger transports.
- Replace default Purge processors.
- Depend on `purge` and `sm`.
- Depend on core `serialization`.
- Support Drupal 10.5+ and 11.3+.
- Carry no content/access role.
- Queue invalidations.
- Integrate Messenger.
- Scale cache purging
- Handle purges asynchronously
- Support infrastructure.
- Route purges.
- Process invalidations.
- Integrate with Purge
