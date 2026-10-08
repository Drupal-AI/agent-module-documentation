<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# WissKI GND Adapter (wisski_adapter_gnd) — agent index

Submodule of **wisski**. Queries the **Gemeinsame Normdatei** (German National Library authority
file) directly. Version **8.x-4.3**. Core `>=10.4 <12`.

Referencing a GND identifier rather than typing a name is what makes a record **joinable** with
every other institution doing the same.

**Two consequences of live querying:** the service's availability becomes yours (check failure
behaviour), and authority records change — corrections propagate, which is the argument for it, but
the displayed label is not under the project's control.

**Two GND adapters exist** — this and `wisski_adapter_gnd_new`. Establish which a project uses.