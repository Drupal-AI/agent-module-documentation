<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
SM Transport Doctrine adds a Doctrine DBAL transport for the Symfony Messenger (sm) module.

---

Doctrine transport for Symfony Messenger provides a Doctrine (DBAL) transport for the SM (Symfony Messenger) module — so messages can be queued in a database table via Doctrine DBAL, giving a database-backed transport option for async message processing without an external broker.

It's an infrastructure/developer module with no content or access role of its own. Depends on `dbal`; requires Drupal 10.1+.

---

- Provide a Doctrine DBAL transport.
- Back Symfony Messenger with a DB.
- Queue messages in a DB table.
- Avoid an external broker.
- Support async processing.
- Build on the SM module.
- Depend on `dbal`.
- Require Drupal 10.1+.
- Carry no content/access role.
- Support infrastructure.
- Store messages in the DB.
- Configure the transport.
- Provide a transport option
- Handle message queuing
- Support developers.
- Use Doctrine DBAL.
- Queue via database.
- Integrate with SM
