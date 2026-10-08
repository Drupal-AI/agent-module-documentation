<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# WissKI Authority Document (wisski_authority_document) — agent index

Submodule of **wisski**. Authority **document** integration — **currently only lobid.org/gnd**
(its own description says so). Version **8.x-4.3**. Core `>=10.4 <12`.

**Distinct from the GND adapters:** querying gives a label for an identifier; the *document* gives
variant names, dates, relationships and identifiers in other systems — which is what makes
**reconciliation** possible, matching on more than a string.

A framework with **one implementation** — another authority service means development, not
configuration.

**Budget for reconciliation.** Matching a few thousand names is not an afternoon's work, and the
unmatched residue needs a person.