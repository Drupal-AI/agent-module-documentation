<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Micon Vocabulary adds an "Icon" picker to the taxonomy vocabulary add/edit form so each vocabulary can carry a Micon icon, stored on the vocabulary config entity and exposed for reuse through Micon's string-matching system.

---

The submodule implements `hook_form_taxonomy_vocabulary_form_alter()` to add a `#type => 'micon'` element to the vocabulary form. An entity builder stores the chosen icon id as a **third-party setting** on the `taxonomy_vocabulary` config entity: `third_party_settings.micon_vocabulary.icon` (e.g. `fa-tags`). Through `hook_micon_icons_alter()` it registers a dynamic `micon_icons` definition `vocabulary.<lowercased label>` (id `vocabulary.<vid>`) pointing at the vocabulary's icon, so `micon('vocabulary.tags')` resolves anywhere. Changing an icon invalidates the `micon.discovery` cache tag. There is no settings form, no `configure` route, and no list-builder override — the icon is available programmatically and via string match. Helper `micon_vocabulary_icon($vocabulary)` returns the stored id.

---

- Give each taxonomy vocabulary (Tags, Categories…) a recognisable icon.
- Store a vocabulary's icon in config so it deploys with `config export`.
- Read a vocabulary's icon in code with `micon_vocabulary_icon($vocabulary)`.
- Render a vocabulary's icon anywhere via `micon('vocabulary.tags')` (lowercased label).
- Decorate a term-reference or faceted-navigation heading with the vocabulary's icon.
- Show a vocabulary icon in a custom taxonomy admin dashboard.
- Drive a themed vocabulary switcher/menu with per-vocabulary icons.
- Keep a consistent icon vocabulary across taxonomies using one Font Awesome package.
- Pick the icon from a curated package via the searchable fonticonpicker element.
- Set an icon on a newly created vocabulary at creation time.
- Update a vocabulary's icon and have its `vocabulary.*` match follow after a cache clear.
- Expose vocabulary icons to other Micon-aware features by string match.
- Remove a vocabulary's icon by clearing the picker (empties the third-party setting).
- Use the icon as a section marker in taxonomy term listings.
- Integrate vocabulary icons into breadcrumb or menu theming.
- Standardise iconography across a site's classification system.
- Label term-management screens with the vocabulary's icon in custom code.
- Avoid custom preprocessing just to show a per-vocabulary icon.
- Provide icons for a tag-cloud or category-index landing page keyed by vocabulary.
