<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# WissKI API (wisski_api) — agent index

Submodule of **wisski**. **REST API** for reading and writing WissKI entities over HTTP.
Version **8.x-4.3**. Core `>=10.4 <12`.

**The most security-sensitive part of a WissKI install — say so before anything else.** Write
access writes into the triple store; read access exposes everything the store holds, which in a
museum or archive context includes data deliberately not public: donor details, valuations,
precise archaeological findspots, personal data about living people.

Settle before enabling, not after: which authentication applies, which roles may call it, and
whether **read and write are separately controlled**.

Documented from source (WissKI could not be enabled — see `wisski_core`); **verify the access model
directly against the release you deploy**.