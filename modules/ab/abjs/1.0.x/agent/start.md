<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# A/B Test JS (abjs) — agent index

Client-side split testing kept inside Drupal: **conditions** (who is eligible), **experiences**
(what changes), **tests** (which experiences, what traffic split). Admin under
`/admin/config/user-interface/abjs`. Core requirement `^9.3 || ^10 || ^11`.

**The permission split is the important part and it is drawn correctly:**
- **`administer ab test scripts and settings`** — `restrict access: TRUE`. Gates every
  condition/experience add, edit and delete route, i.e. everywhere **JavaScript is authored**.
  An experience is arbitrary JS injected into page views — this permission is equivalent to code
  deployment. Give it only to people who could deploy code.
- **`administer ab tests`** — not restricted. Lets a marketer create and run tests from snippets
  a developer already approved. This is the one to grant the marketing team.

`abjs.module` inlines the assembled script via `Markup::create($abjs_script)` — by design, and
sourced only from the restricted permission.

**Two delivery realities:**
- client-side variants **flicker** unless applied before first paint;
- they interact badly with **page caching** — the split has to be decided somewhere the cache does
  not flatten it.
