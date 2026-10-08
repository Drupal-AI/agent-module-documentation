<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Redis Batch stores Drupal Batch API data in Redis instead of the database.

---

Redis Batch provides a Redis batch storage backend — storing Batch API progress/data in Redis instead of the database, so large or frequent batch operations don't hammer the DB and can scale better on sites already using Redis.

It's a performance/infrastructure module with no content or access role of its own. Depends on `redis`; supports Drupal 10.2+ and 11.

---

- Store batch data in Redis.
- Back the Batch API with Redis.
- Avoid DB load for batches.
- Scale batch operations.
- Suit Redis-using sites.
- Depend on `redis`.
- Support Drupal 10.2+ and 11.
- Carry no content/access role.
- Improve batch performance.
- Offload batch storage.
- Handle large batches.
- Support infrastructure.
- Reduce DB pressure
- Configure Redis storage
- Persist batch progress.
- Support scaling.
- Use Redis.
- Store progress fast
