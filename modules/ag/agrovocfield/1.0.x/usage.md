<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
AGROVOC Field auto-suggests AGROVOC concept tags for a taxonomy reference field from the text of another field on the same content, by calling a self-hosted AgroTagger service on save.

---

AGROVOC is FAO's multilingual agricultural thesaurus. This module (a Drupal 11 port of the legacy D7 `agrovocfield_automatic` sub-module) turns an ordinary taxonomy reference field into an auto-tagging field: you enable "AGROVOC automatic indexing" on the field's widget, choose a **source field** (e.g. the body) to read text from, and a maximum number of tags. When content is saved through the edit form, an `#element_validate` callback reads the just-submitted source text, POSTs it to an admin-configured **AgroTagger** HTTP service (`POST /tag`), and for each returned AGROVOC concept looks up or creates a matching taxonomy term in the field's target vocabulary, then fills the field — but only when the editor left it empty, so it never overwrites a manual or existing selection. Newly created terms get their canonical AGROVOC URI stored in a `field_agrovoc_uri` link field when the vocabulary has one (the legacy `http://aims.fao.org/...` URI is normalised to today's canonical `https://aims.fao.org/....html`). Because the work happens in a form-validation callback, it fires only during interactive submission — never on programmatic saves, migrations or imports. It supports exactly two "tags style" widgets — core's `entity_reference_autocomplete_tags` and the Tagify contrib widget — because each submits its value in a different shape. Configuration is a single settings form (`/admin/config/content/agrovocfield`, permission `administer site configuration`) for the service URL and request timeout. The AgroTagger service itself (a self-hosted wrapper around the MAUI keyphrase-extraction library) is deployed and maintained separately; this module only consumes its JSON API. Requires core `taxonomy` and `field`, Drupal 10.3+/11.

---

- Auto-tag agricultural articles with standardized AGROVOC concepts on save.
- Suggest taxonomy terms for a reference field from the body text.
- Fill a tags field only when an editor leaves it empty, never overwriting manual choices.
- Auto-create missing taxonomy terms for returned AGROVOC concepts.
- Store each term's canonical AGROVOC URI in a `field_agrovoc_uri` link field.
- Add AGROVOC indexing to core's Autocomplete (Tags style) widget.
- Add AGROVOC indexing to the Tagify contrib widget's tag pills.
- Cap the number of suggested tags per field (1–50).
- Point the module at a self-hosted AgroTagger service by URL.
- Set an HTTP request timeout so long content does not hang node save indefinitely.
- Improve classification and interoperability of an agricultural research/data site.
- Standardise vocabulary across many editors using an authoritative thesaurus.
- Keep tagging out of programmatic imports (only interactive form saves trigger it).
- Reuse existing terms by matching AGROVOC concept labels by name.
- Normalise legacy AIMS concept URIs to their canonical `.html` form.
- Choose which text field on a bundle drives the suggestions.
- Show the AGROVOC URI inside a Tagify pill via the `[term:field_agrovoc_uri]` info-label token.
- Backfill URIs on pre-existing terms via the service's `GET /lookup?label=` endpoint (manual script).
- Tag multilingual agricultural content with AGROVOC concepts.
- Support FAO/AGROVOC-aligned metadata on Drupal 10.3+/11.
