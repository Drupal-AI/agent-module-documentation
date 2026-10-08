<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Node ID Class — agent index

Assigns **dynamic CSS IDs/classes to node wrappers + the body element** using tokens (`{node_id}`,
`{bundle}`, `{node_title}`, `{node_author_uid}`) — per-node theming hooks. Depends on core `node`. Version
**1.1.3**. Core `^10||^11`.

Content-display/theming — emits node metadata as (machine-safed) CSS classes; no access role. Configure
which tokens build the classes.
