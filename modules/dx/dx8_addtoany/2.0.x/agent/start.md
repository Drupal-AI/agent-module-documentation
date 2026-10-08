<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# DX8 AddToAny (dx8_addtoany) — agent index

Bridges **AddToAny** share buttons into **Acquia Site Studio**'s element vocabulary.
Version **2.0.5**. Core `^9 || ^10 || ^11`.

The kind of small single-purpose integration a proprietary page builder generates a lot of — every
existing capability needs re-exposing in the builder's terms.

**AddToAny is a third-party script** that loads from its own domain and can set analytics cookies —
bridging it does not change that. On an EU-facing site it needs consent gating like any other
tracker.

**Naming note:** DX8 was Site Studio's original name, so a `dx8_` prefix marks a module written
before the rename — useful when judging how actively something is maintained.