<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# WissKI GND Adapter, new (wisski_adapter_gnd_new) — agent index

Submodule of **wisski**. Newer **GND** adapter, alongside `wisski_adapter_gnd`.
Version **8.x-4.3**. Core `>=10.4 <12`.

Two adapters for one authority file means the provider's access paths moved (notably toward
lobid.org). **Newer adapter for a new project; for an inherited one, establish which is in use and
whether the older still resolves.**

**The failure is subtle**: an adapter that stops resolving does not visibly break — labels simply
stop updating while records keep referencing identifiers nobody is checking.