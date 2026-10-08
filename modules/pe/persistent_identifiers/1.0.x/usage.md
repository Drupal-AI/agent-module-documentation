<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Persistent Identifiers is a framework for third-party modules to mint and persist DOIs, ARKs, etc. for entities.

---

Persistent Identifiers provides a generalized framework that lets third-party modules mint and persist persistent identifiers — DOIs, ARKs, Handles and similar stable, citable identifiers — for Drupal entities. It is the base framework other modules (e.g. pid_field_set) build on to attach and manage PIDs on content.

It's a framework/developer module with no content or access role of its own; specific minting providers and credentials are configured by the modules built on it (store any registry credentials env-backed). Supports Drupal 10 and 11.

---

- Provide a persistent-identifier framework.
- Mint DOIs, ARKs, Handles.
- Persist identifiers on entities.
- Serve as a base for PID modules.
- Support third-party minting providers.
- Underpin pid_field_set.
- Store registry credentials env-backed.
- Carry no content/access role.
- Support Drupal 10 and 11.
- Attach PIDs to content.
- Manage stable identifiers.
- Support research/repository sites.
- Provide citable IDs
- Extend via providers
- Handle identifier lifecycle.
- Support scholarly content.
- Frame PID minting.
- Enable persistent IDs
