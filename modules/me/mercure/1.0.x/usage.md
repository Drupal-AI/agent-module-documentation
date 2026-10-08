<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Mercure integrates the Mercure Component with Drupal.

---

Mercure integrates the Mercure protocol/component with Drupal — enabling real-time, server-sent updates
(pub/sub over SSE) so a front end can subscribe to a Mercure hub and receive live updates when Drupal
publishes. Use it for real-time features (live content updates, notifications) in decoupled/interactive
setups.

Security-relevant points: Mercure uses **JWT** to authorize publishing (and, for private topics, subscribing)
— the **JWT secret/key that signs publisher tokens must be kept confidential** (store it as a secret; anyone
with it can publish to any topic), and for **private updates** ensure subscribers are properly authorized
(the hub enforces subscriber JWTs). Run the Mercure hub over **HTTPS/WSS**. It has no Drupal access-control
role of its own beyond the token model. Configure the Mercure hub URL and JWT keys.

---

- Enable real-time server-sent updates.
- Integrate the Mercure protocol.
- Publish live updates to a hub.
- Let front ends subscribe for live updates.
- Support decoupled/interactive real-time.
- Use JWT to authorize publishing.
- Keep the JWT publisher secret confidential.
- Store the JWT key as a secret.
- Authorize subscribers for private topics.
- Run the hub over HTTPS/WSS.
- Have no Drupal access-control role beyond the token model.
- Configure the Mercure hub URL + JWT keys.
- Handle real-time updates.
- Publish to Mercure.
- Configure the hub.
- Handle JWT tokens.
- Secure the hub.
- Configure real-time.
- Handle credentials securely.
- Enable pub/sub.
