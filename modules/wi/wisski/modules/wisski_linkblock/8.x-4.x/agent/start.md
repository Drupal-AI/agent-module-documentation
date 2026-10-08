<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# WissKI Linkblock (wisski_linkblock) — agent index

Submodule of **wisski**. Block of **links related to the current record**.
Version **8.x-4.3**. Core `>=10.4 <12`.

Surfacing connections as navigation is what turns a semantic database into something researchers
**explore** rather than only query.

**The design question is which relationships to surface.** A well-modelled record participates in
dozens; all of them is a wall nobody reads, none wastes the model. Choosing the few that answer
real research questions — what else did this person make, what else came from this site — is an
editorial decision that needs knowledge of the material.

Block visibility conditions let different record types surface different relationships without
templating.