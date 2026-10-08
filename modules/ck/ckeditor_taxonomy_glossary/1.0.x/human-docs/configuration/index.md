# Configuration

Getting glossary tooltips working takes four short steps: enable the filter, add
the toolbar button, grant permissions, and add some terms.

## 1. Enable the Glossary link filter

1. Go to **Configuration → Content authoring → Text formats and editors**
   (`/admin/config/content/formats`).
2. **Configure** the format you want glossary links in — for example *Full HTML*
   or *Basic HTML*.
3. Under **Enabled filters**, tick **"Glossary link filter"**. This is what turns
   the saved glossary links into hoverable, tooltip-bearing markup on the front
   end.

## 2. Add the Glossary Link button

In the same format's configuration form:

1. Under **CKEditor 5 plugin settings** / toolbar configuration, drag the
   **Glossary Link** button from *Available buttons* into the *Active toolbar*.
2. Click **Save configuration**.

## 3. Grant permissions

Go to **People → Permissions** (`/admin/people/permissions`) and grant these to
the appropriate roles:

- **Administer glossary terms** — allows managing the Glossary vocabulary and its
  terms. Give this to editors or administrators who maintain the glossary.
- **Link to glossary terms** — allows using the CKEditor plugin to create glossary
  links (and, where enabled, to create new terms on the fly). Give this to your
  content editors.

## 4. Manage glossary terms

1. Go to **Structure → Taxonomy → Glossary**.
2. Add a term for each word you want to define:
   - **Name** — the term itself (the word that will be linked).
   - **Description** — the definition that appears in the tooltip.

Editors can also create terms directly from the editor: after clicking **Glossary
Link**, if a term does not yet exist they can choose *Create New Term* and fill in
the name and description without leaving the content form.

## How editors use it

1. In CKEditor 5, highlight the text to link.
2. Click the **Glossary Link** button in the toolbar.
3. Start typing to search existing terms — the autocomplete shows matches, with a
   language badge (for example `[EN]`) next to each on multilingual sites.
4. Pick a term, or choose *Create New Term* to add one on the spot.

The selected text becomes a glossary link; on the published page, hovering,
focusing, or clicking it (depending on your theme's styling) shows the term's
description in an accessible tooltip.

## Theming (optional)

The module ships default tooltip CSS. To restyle, target `.glossary-link` (the
linked word) and `.glossary-tooltip` (the popup container) in your theme.

## Troubleshooting

- **Tooltips not appearing** — clear Drupal caches and confirm JavaScript
  aggregation is working.
- **The button is missing** — recheck the format's toolbar configuration and that
  the editor uses CKEditor 5, and confirm the editing role has *Link to glossary
  terms*.
- **Terms not found in autocomplete** — make sure the terms exist in the
  **Glossary** vocabulary.
