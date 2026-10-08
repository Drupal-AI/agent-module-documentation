<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
G2 Glossary manages a node-based glossary of terms and definitions.

---

G2 Glossary **manages a node-based glossary** — providing glossary entries as nodes (term + definition) with
alphabetical browsing, cross-referencing and blocks (e.g. word of the day, random entry). It depends on core Node,
Taxonomy, Views, Filter, Path, Block and (legacy) Statistics and XML-RPC modules.

Use it to build a glossary section. It is a content-display feature; glossary entries are nodes following normal
node access and it provides its own permissions. Note: it declares a dependency on the contrib **XML-RPC** module
(XML-RPC was removed from core) — ensure that's acceptable, as XML-RPC endpoints have historically been an attack
surface (only enable the XML-RPC server if you actually need it). Configure the glossary.

---

- Manage a node-based glossary.
- Provide term/definition entries.
- Support alphabetical browsing + blocks.
- Depend on core Node/Taxonomy/Views.
- Provide its own permissions.
- Serve content display.
- Follow normal node access for entries.
- DEPEND on the contrib XML-RPC module (a historical attack surface).
- Only enable XML-RPC if actually needed.
- Configure the glossary.
- Handle the glossary.
- Manage terms.
- Configure the glossary.
- Show definitions.
- Handle entries.
- Browse terms.
- Configure content.
- Handle the display.
- List terms.
- Provide a glossary.
