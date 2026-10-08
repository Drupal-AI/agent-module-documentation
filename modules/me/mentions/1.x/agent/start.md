<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Mentions (mentions) — agent index

Records/renders/reacts to **@-mention patterns** in content (links to the referenced user/entity).
Version **dev**.

**Security:** mention patterns come from user content — confirm mentions render as **safe, escaped
links** (no markup injection) and that mentioning respects **user visibility** (shouldn't disclose
accounts the user couldn't otherwise see).