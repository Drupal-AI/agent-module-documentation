<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
CKEditor Entity Browser adds one or more Entity Browser buttons to CKEditor 5's link dialog, so an editor can search for and select existing content and have its URL dropped into the link field instead of typing an address.

---

Linking to internal content in CKEditor normally means knowing the target's URL: an editor leaves the editor, finds the page, copies its address, and comes back — which is how a content body ends up full of `/node/123` links, links to the wrong page, and links to a staging domain someone pasted once. This module wires Drupal's Entity Browser (its search/filter Views UI) into the CKEditor 5 link UI. Each Entity Browser you enable becomes a button in the link balloon; clicking it opens the browser (loaded through an iframe so every Entity Browser widget gets its own JS/CSS assets), you pick a row, and the module writes the selected entity's canonical internal path (e.g. `/node/5`) back into the link input. The value is delivered by `postMessage` from the iframe to the editor document and, when the core entity-link-suggestions autocomplete is present, the module nudges it so the entity link resolves the same way it would if you had typed the path yourself. Only entities that expose a `canonical` link template can be inserted, and only one at a time. There is no new field type, widget, permission, config form, or Drush command — configuration is entirely per text format, on the CKEditor 5 plugin settings of the format, and everything is driven by the existing Entity Browser entities you have already built.

---

- Let editors link to internal content by searching for it in the link dialog instead of typing a URL.
- Add a "Select content" button to CKEditor 5's link balloon for each configured Entity Browser.
- Reuse an existing Entity Browser (a View with a bulk-select form) as the content picker for links.
- Offer several pickers at once — e.g. one browser for articles, another for media or documents.
- Filter and search the candidate content using the Entity Browser's own View exposed filters.
- Enable the picker only on the text formats where editors need it, per format.
- Stop editors copying and pasting `/node/123`-style paths by hand.
- Reduce links that point at the wrong page or at a staging domain.
- Insert exactly one link at a time (recommended: turn on "Use field cardinality" so the browser shows radio buttons, not checkboxes).
- Combine with Linkit's CKEditor 5 link plugin, which can share the same link UI.
- Feed the inserted path into core's entity-link-suggestions autocomplete so it resolves to an entity link.
- Rename or re-weight the buttons per Entity Browser via the `hook_ckeditor5_entity_browser_definitions_alter()` hook.
- Pass extra widget context to a browser through the same alter hook.
- Keep the picker working with asset-upload widgets (e.g. DropzoneJS) because the browser loads as a full page in an iframe.
- Give content teams a consistent link-picking workflow across content types.
- Avoid building a bespoke reference-autocomplete for internal linking when an Entity Browser already exists.
- Support any entity type that has a canonical URL (nodes, media, terms, users, …) as a link target.
- Configure the picker without writing code — enable it on the format and choose which browsers appear.
- Document the module's link-insertion behaviour for an editorial team.
- Review its configuration during a content-authoring or accessibility audit.
- Re-verify its behaviour after a CKEditor 5 or Entity Browser upgrade.
