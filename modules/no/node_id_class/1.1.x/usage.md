<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Node ID Class assigns dynamic CSS IDs and classes to node wrappers and the body element using tokens like {node_id}, {bundle}, {node_title}, {node_author_uid}.

---

Node ID Class assigns dynamic CSS IDs and classes to node wrappers and the `<body>` element — using
tokens like `{node_id}`, `{bundle}`, `{node_title}` and `{node_author_uid}` to build the class/ID strings,
giving themers flexible per-node styling hooks. It depends on core Node.

Use it for token-driven per-node theming. It is a content-display/theming feature emitting CSS classes/IDs
derived from node tokens; the values are node metadata rendered as classes (node title becomes a
sanitized/machine-safe class), and it has no access-control role. Note: if using `{node_title}` in a class,
the module machine-safes it; still, be aware class values are emitted into markup. Configure which tokens
build the classes.

---

- Add CSS classes/IDs to node wrappers.
- Add classes to the body element.
- Use tokens for class strings.
- Support {node_id}/{bundle}/{node_title}.
- Include {node_author_uid}.
- Depend on core Node.
- Give per-node styling hooks.
- Emit node metadata as classes.
- Machine-safe token values.
- Have no access-control role.
- Configure which tokens build classes.
- Theme per node.
- Build dynamic classes.
- Add styling hooks.
- Configure the classes.
- Style nodes by token.
- Add node IDs.
- Handle per-node CSS.
- Emit token classes.
- Configure node classes.
