<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
LOD provides JSON-LD export plugin scaffolding and standard JSON-LD output.

---

Linked Open Data (LOD) provides **JSON-LD export scaffolding and standard JSON-LD output** — a plugin
framework for exposing content as JSON-LD (Linked Open Data), so entities can be published as machine-readable
linked data. It requires PHP 8.1, depends on core Serialization and Views, provides its own permissions.

Use it to publish content as JSON-LD linked data. It is a decoupled/data-publishing feature. Security note: it
**exposes content as JSON-LD**, so ensure only content meant to be **public** is exposed (the export/Views
should respect content access — publishing linked data of restricted content is a disclosure risk), and gate
its permission appropriately. It has no access-control role of its own beyond its permission. Configure the
JSON-LD export.

---

- Export content as JSON-LD.
- Provide JSON-LD plugin scaffolding.
- Publish Linked Open Data.
- Require PHP 8.1.
- Depend on core Serialization and Views.
- Provide its own permissions.
- Expose only public content.
- Respect content access in the export.
- Avoid publishing restricted content as linked data.
- Have no access-control role of its own.
- Configure the JSON-LD export.
- Handle linked data.
- Export JSON-LD.
- Configure the export.
- Publish linked data.
- Handle the integration.
- Expose JSON-LD.
- Provide LOD.
- Restrict the export.
- Provide JSON-LD export.
