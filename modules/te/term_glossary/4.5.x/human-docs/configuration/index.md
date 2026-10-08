# Configuration

Taxonomy Term Glossary does nothing until you tell it which vocabularies act as
your glossary and which text fields to scan. There are three parts: the settings
form, the per‑field display option, and (optionally) the glossary block.

## Step 1 — Open the settings form

1. Log in as a user with the *Administer site configuration* permission.
2. Go to **Configuration → Glossary**, or navigate directly to
   `/admin/config/glossary`.

On this form you choose:

- **Which vocabularies** act as glossaries. From version 4.2 onward you can
  select **multiple** vocabularies, and multilingual vocabularies are handled
  better.
- **The integration / presentation type** — for example the default jQuery UI
  dialog (which shows the term name and description in a modal when a reader clicks
  a highlighted term), or another handler if you enabled a submodule. From 4.4+
  the module can generate a plain HTML link as well as a modal popup.
- Matching behaviour options such as **case‑sensitive matching**, **single
  occurrence** matching (highlight a term only once across the whole content
  rather than on every appearance), the use of **term synonyms**, characters that
  should not count as word boundaries (for example `-`), and the ability to
  **exclude self‑references** so a term is not linked inside its own definition.
- Optionally, a **Taxonomy Term display view mode** to use when rendering the
  popup content, giving you full control over how the definition looks.

Save the form once you have made your choices.

## Step 2 — Enable scanning on your text fields

Highlighting only happens on the fields you opt in:

1. Go to the content type (or other entity) whose content you want scanned, and
   open its **Manage display** settings.
2. For each text field you want parsed, open the field's display options (the
   gear/settings) and tick **Enable term glossary**.
3. Save the display.

Now, when that content is rendered, matching terms are highlighted and the reader
can click (or hover, with Tippy) to see the definition. Note that the field
content in the database is **not** modified — the highlighting happens on render.

You can also keep specific markup out of the glossary: any HTML element carrying
the `glossary-exclude` class is skipped, and you can exclude particular HTML tags
from parsing entirely.

## Step 3 (optional) — Add the glossary browsing block

To give readers a glossary page they can browse:

1. Go to **Structure → Block layout** (`/admin/structure/block`).
2. Place the **Glossary alphabetical block** in a region.
3. In the block settings, choose what to show — the A–Z letters, a search box, or
   both.

## A note on privacy of terms

The front‑end JavaScript fetches definitions from JSON endpoints that are open to
anyone who can *access content*. As covered in the [main guide](../index.md), on
current versions these endpoints can return unpublished terms and, for the
fetch‑by‑ID endpoint, terms from vocabularies you did not configure as
glossaries. If your taxonomy holds anything that is not meant to be public, do not
rely on this module to keep it hidden — patch the endpoints or keep sensitive
terms out of the site's taxonomy.
