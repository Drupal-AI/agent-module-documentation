<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Attaches a LaTeX input toolbar (built on the markItUp library) to every textarea that matches a jQuery selector you configure, giving authors buttons that insert LaTeX/TeX markup.

---

On every page the module attaches its `markitup` and `texbar` libraries plus a `drupalSettings.texbar.selector` value; client-side JS then binds a LaTeX button set to textareas matching that selector. The single admin setting (`/admin/config/content/texbar`, permission `administer texbar`) is the **jQuery selector** for which textareas get the toolbar. The button sets live in `sets/` and the module includes a CodeMirror-modes config; a `LibraryBuilder` service assembles the asset library and a Drush command (`texbar.commands`, using library discovery + an HTTP client + state) can fetch/build the third-party editor assets.

It is an authoring convenience for sites that publish mathematics (research, education): the toolbar only inserts text into a field, so it changes editing UX, not storage — actual LaTeX rendering (e.g. MathJax) is a separate concern. Note the library is attached on all pages, so scope the selector to the fields that need it. Saving the settings form flushes all caches so the new selector takes effect.

---
- Add a LaTeX toolbar to node body textareas
- Target specific textareas with a jQuery selector (e.g. `#edit-body-0-value`)
- Give authors buttons to insert common LaTeX commands
- Configure the selector at `/admin/config/content/texbar`
- Restrict toolbar administration with the `administer texbar` permission
- Help researchers enter mathematical notation in content
- Provide a math-input aid on an education site's forms
- Insert TeX fragments without memorising syntax
- Attach the toolbar to a custom module's textarea
- Use the markItUp button sets shipped in `sets/`
- Fetch/build the editor assets via the module's Drush command
- Pair with a MathJax/KaTeX renderer for display of the entered LaTeX
- Standardise LaTeX entry across a content type
- Flush caches automatically on selector change
- Add math toolbars to comment textareas by selector
