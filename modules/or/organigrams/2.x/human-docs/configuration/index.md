# Configuration

Organigrams has **no global settings form**. An organigram is a taxonomy vocabulary
that has been flagged as a chart, and its terms are the chart's boxes. "Configuring"
one means creating the vocabulary, adding terms, and choosing how to display it.

## Create an organigram vocabulary

1. Go to **Structure → Taxonomy** (`/admin/structure/taxonomy`).
2. Click the **Add organigram** action (this requires the **Create organigrams**
   permission).
3. Fill in the normal "add vocabulary" form and save.

On save the module does two things automatically: it marks the vocabulary as an
organigram, and it creates a set of helper term fields (below). That flag is what
tells the module to treat the vocabulary as a chart.

## The term fields it adds

Every organigram vocabulary gets these fields on its terms:

- **Position** (`field_o_position`) — controls the box's place in the chart. A value
  of `s` marks the term as a **staff** function; staff boxes are labelled "Staff:" in
  the term overview and drawn to the side of the reporting line.
- **Image** (`field_o_image`) — a picture shown inside the box (e.g. a photo).
- **URL** (`field_o_url`) — a link the box points to (a profile or page).
- **CSS classes** (`field_o_css_classes`) — extra CSS classes applied to that box for
  custom theming.

## Build the chart

Add **terms** to the vocabulary. Each term is one box. Use the term's **parent** to
nest it under another box, and drag terms in the overview to set their **order**,
which is the order boxes appear in the chart. Editing the chart is therefore just
editing taxonomy terms — which means core taxonomy permissions apply (see below).

## Three ways to display an organigram

1. **Dedicated page** — visit `/organigram/{vocabulary}` (the vocabulary's machine
   name). Viewing requires the **View organigrams** permission.
2. **Block** — the module generates one block per organigram vocabulary. Place it in
   any region from **Structure → Block layout**. Viewing the block also requires
   **View organigrams**.
3. **Token** — embed `[organigrams:{vid}]` inside a text field (for example a WYSIWYG
   body). This needs the **Token** and **Token Filter** modules and a text format
   that runs the token filter.

## Styling

The v2 chart is pure CSS. Override `css/orgchart-layout.css` (structure/spacing) and
`css/orgchart-theme.css` (colours/borders) in your own theme to restyle the whole
chart. You can also target individual boxes with the per‑term **CSS classes** field.

## Import and export

Organigram term data can be moved as JSON:

- **Export** — `/admin/structure/taxonomy/manage/{vocabulary}/export` dumps all the
  terms as JSON.
- **Import items** — `/admin/structure/taxonomy/manage/{vocabulary}/import` loads
  JSON into a vocabulary.
- **Import a Drupal 7 organigram** — `/admin/structure/taxonomy/import/d7-organigram`
  accepts both 7.x and 8.x JSON (this requires the **Import organigrams**
  permission).

The vocabulary itself is configuration, so it moves through normal config sync; the
terms are content, so use the import/export forms to move them between environments.

## Permissions

The module defines three permissions:

- **Create organigrams** — use the **Add organigram** action to create an organigram
  vocabulary.
- **Import organigrams** — use the Drupal 7 organigram import form.
- **View organigrams** — view the organigram page and block.

Because an organigram **is** a taxonomy vocabulary, core **taxonomy** permissions
apply on top of these — editing the chart means editing terms, so the relevant
"edit terms in <vocabulary>" access is also required. The import‑ and export‑items
forms additionally require permission to create terms in that vocabulary.
