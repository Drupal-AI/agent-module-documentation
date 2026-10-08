<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# IO Builder — agent index

A **frontend page builder** letting content administrators build pages visually (drag-and-drop;
`io_builder_paragraphs` submodule). Provides permissions. Version **1.1.0-beta5**. Core `^8||^9||^10||^11`.

Content-editing/page-building — editing governed by its permissions **plus** underlying entity/field edit
access (the builder shouldn't bypass entity/field access; gate to trusted editors). No access role beyond
that.
