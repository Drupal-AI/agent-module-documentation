<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Session Entity provides an entity that is stored in the user's session.

---

Session Entity provides an **entity type stored in the user's session** — rather than the database — so
per-visit, ephemeral data (including for anonymous users) can be modelled as an entity that lives only in the
session. It provides its own permissions, in the Session package.

Use it for per-session, ephemeral entity data. It is a developer/data feature. Security/data notes: the data
lives in the **session** (per-user, not shared, cleared when the session ends), so it is a poor place for data
that needs persistence or cross-user integrity; and **avoid storing sensitive data in the session** beyond
what's necessary (session data is only as protected as the session store). It has no broad access-control role
beyond its permission. Define and use the session entity.

---

- Store an entity in the session.
- Model per-visit ephemeral data.
- Support anonymous per-session data.
- Provide its own permissions.
- Live only in the session.
- Serve developers.
- KNOW session data is ephemeral (not persistent).
- Avoid storing sensitive data in the session.
- Know it's only as protected as the session store.
- Have no broad access-control role beyond permission.
- Define the session entity.
- Handle session entities.
- Store session data.
- Configure the entity.
- Use session storage.
- Handle the entity.
- Store per-session data.
- Model ephemeral data.
- Use the entity.
- Provide session entities.
