<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Defines an example meta entity to be related with nodes — a submodule of **entity_meta_relation**.

---

This is one of entity_meta_relation's submodules. Defines an example meta entity to be related with nodes It exposes nothing on its own beyond that role and is governed by the parent module's configuration, permissions and behavior; enable it when you need this specific capability and leave it off otherwise, so the site only carries the parts of entity_meta_relation it actually uses.

See the parent module for the overall system this fits into.

---
- Enable entity_meta_example to add this capability.
- Extend entity_meta_relation with entity_meta_example.
- Keep it disabled if not needed.
- Depend on entity_meta_relation.
- Scope functionality to what you enable.
- Add only the sub-features you use.
- Compose the parent's feature set.
- Turn on per requirement.
- Reduce surface by enabling selectively.
- Combine with sibling submodules.
- Configure via the parent module.
- Review what it exposes before enabling.
- Match it to your use case.
- Keep the parent's permissions in force.
- Enable alongside the parent.
- Use it as part of the parent's system.