<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Layout Builder + Block Decorator (lb_plus_lb_block_decorator) — agent index

Submodule of **lb_plus**. Adds **nested layout support** to `lb_block_decorator`.
Version **3.6.12**. Core `^10 || ^11`. Depends on `lb_block_decorator`, `lb_plus`.
No configuration of its own.

**The symptom it fixes:** `lb_block_decorator` walks core Layout Builder's flat structure. Under
`lb_plus`, blocks can be nested several levels deep, so decoration applies to top-level blocks and
silently stops applying to nested ones. If block decoration is inconsistent on an `lb_plus` site,
this is the missing piece.