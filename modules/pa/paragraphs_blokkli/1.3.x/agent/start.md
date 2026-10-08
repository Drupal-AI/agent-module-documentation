<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Paragraphs Blokkli — agent index

**Visual, form-free editing for Paragraphs** (blökkli editor — drag-and-drop/in-place page building). Many
submodules (comment/conversion/fragments/graphql/library/scheduler/search/search_api/transform). Depends on
`paragraphs`; provides permissions. Version **1.3.6**. Core `^9||^10||^11`.

Content-editing/page-building — editing governed by its permissions **plus** underlying paragraph/entity edit
access (visual editor shouldn't bypass entity/field access; verify who can edit).
