<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Nodeinfo enables NodeInfo and/or NodeInfo2 support, exposing standardized server-metadata endpoints used for federated/social-web instance discovery.

---

Nodeinfo adds support for the NodeInfo and NodeInfo2 protocols — standardized JSON endpoints that
publish metadata about a server instance (software name/version, protocols, usage stats, open
registration) for the federated social web ("fediverse") and instance-discovery tools. Enabling it
lets a Drupal site advertise this machine-readable metadata at the well-known NodeInfo endpoints.

Use it if a Drupal site participates in (or is catalogued by) fediverse tooling that reads NodeInfo.
Note that NodeInfo intentionally **discloses server metadata** — software and version, and optionally
usage statistics — so be aware you are publishing that information publicly; expose only what you are
comfortable revealing (version disclosure can aid fingerprinting). It is an integration/protocol
feature with no access-control role beyond serving the public metadata document.

---

- Expose NodeInfo/NodeInfo2 endpoints.
- Publish server metadata as JSON.
- Advertise instance info to the fediverse.
- Support instance-discovery tools.
- Serve well-known NodeInfo documents.
- Enable NodeInfo or NodeInfo2.
- Publish software name/version.
- Optionally publish usage stats.
- Participate in federated tooling.
- Understand it discloses server metadata.
- Mind version fingerprinting.
- Expose only comfortable info.
- Catalogue the site for fediverse tools.
- Advertise open-registration status.
- Provide machine-readable metadata.
- Serve public instance data.
- Have no access-control role.
- Support the social web.
- Publish protocol support.
- Enable instance discovery.
