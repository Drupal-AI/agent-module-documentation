<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
WissKI Linkblock supplies a block of links related to the current WissKI record.

---

Records in a semantic collection are connected — an object to its maker, a maker to their other works, a place to what was found there — and those connections are the reason for modelling the data this way. Surfacing them as navigation is what turns a database into something a researcher can explore rather than only query.

This submodule provides a block for that, placeable through block layout like any other.

The design question is which relationships to surface. A record in a well-modelled collection may participate in dozens; showing all of them produces a wall of links nobody reads, and showing none wastes the model. Choosing the few that answer the questions researchers actually ask — what else did this person make, what else came from this site — is an editorial decision informed by knowing the material.

Because it is a block, visibility conditions apply, so different relationships can be surfaced on different record types without templating.

---

- Show links related to a record.
- Surface a maker's other works.
- Link to other finds from a site.
- Turn a database into something explorable.
- Place related links in a sidebar.
- Choose which relationships to surface.
- Show different links per record type.
- Avoid a wall of unread links.
- Support researcher browsing.
- Use block visibility conditions.
- Reveal the value of a data model.
- Configure the block per placement.
- Review which links researchers follow.
- Audit relationship display across types.
- Document which relationships are surfaced.
- Adjust links as a model evolves.
