<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
MMPP allows users to make their profile private.

---

MMPP (Make My Profile Private) **lets users make their user profile private** — a per-user toggle so a
user's profile page/data is hidden from others. It depends on core User.

Use it to give users profile privacy. It is an access-control/privacy feature and it is implemented
**correctly**: it adds a "private" base field and registers a **custom entity access handler**
(`MmppAccessHandler`) that governs **view access to the user entity** — allowing the profile's **owner** and
administrators, and returning `AccessResult::forbidden()` for others when the profile is marked private. Because
enforcement is at the **entity access handler** level (not a display hook), it is respected everywhere entity
access is checked — the canonical profile page, **JSON:API, REST and Views** — so a private profile's data does
**not** leak through the API (a common failure this module avoids). It has no broader access-control role.
Enable it and let users toggle privacy.

---

- Let users make profiles private.
- Add a per-user privacy toggle.
- Hide the profile from others.
- Depend on core User.
- Add a 'private' base field.
- Register a custom entity access handler.
- Enforce at the ENTITY ACCESS layer (API-safe).
- Allow owner + admins; forbid others when private.
- Be respected by JSON:API/REST/Views (no API leak).
- Have no broader access-control role.
- Enable it + let users toggle.
- Handle profile privacy.
- Hide profiles.
- Configure the privacy.
- Make profiles private.
- Gate profile access.
- Handle the access handler.
- Protect profiles.
- Enforce correctly.
- Provide profile privacy.
