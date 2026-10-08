<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Wingsuit Page Manager (wingsuit_page_manager) — agent index

Submodule of **wingsuit_companion**. **Theme negotiator** for Page Manager pages.
Version **8.x-2.2**. Core `^8 || ^9 || ^10 || ^11`. Depends on `text`.

Page Manager takes over routes and renders variants; the theme they render in is not always what a
site expects. A page against the wrong theme loses libraries, templates and styling — and the
symptom looks like a broken page, not a theme problem.

**Debugging note:** theme negotiators compose by **priority**. If a Page Manager page still renders
in the wrong theme after installing this, competing negotiators and their priorities are where to
look.