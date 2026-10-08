<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# JSON Template — agent index

Loads **client-side JS templates (Handlebars/Mustache, etc.)** for front-end rendering — infrastructure
used by modules/themes (e.g. Recombee). Version **1.0.5**. Core `^9.5||^10||^11||^12`.

Developer/JS feature — ensure data passed into templates is escaped (use the engine's escaping, not raw
interpolation) to avoid client-side injection. No content/access behaviour of its own.
