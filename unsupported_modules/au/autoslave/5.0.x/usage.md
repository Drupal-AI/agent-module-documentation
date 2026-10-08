<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
AutoSlave automatically routes read queries to replica servers.

---

AutoSlave **automatically routes read database queries to replica (slave) servers** — offloading SELECTs to
one or more read replicas while writes go to the primary, to scale read-heavy sites, handling replication-lag
edge cases. It depends on core System, provides its own permissions, in the Database package.

Use it to scale database reads across replicas. It is a performance/infrastructure feature. Operational note:
routing reads to replicas requires **correctly configured replication** and awareness of **replication lag**
(a read right after a write may hit stale data) — AutoSlave manages this but verify behaviour for consistency-
sensitive flows. It has no content or access role beyond its permission. Configure the replica connections.

---

- Route read queries to replicas.
- Offload SELECTs from the primary.
- Scale read-heavy sites.
- Depend on core System.
- Provide its own permissions.
- Handle replication-lag edge cases.
- Require correctly configured replication.
- Be aware of replication lag (stale reads).
- Verify consistency-sensitive flows.
- Have no content/access role beyond permission.
- Configure the replica connections.
- Handle read routing.
- Route reads.
- Configure the replicas.
- Scale reads.
- Handle the database.
- Offload queries.
- Balance reads.
- Set the connections.
- Provide read-replica routing.
