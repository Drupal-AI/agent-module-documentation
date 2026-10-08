# Configuration

Collapse Text has no settings page of its own. Instead you enable and tune the
**Collapsible text blocks** filter separately on each **text format** where you
want the `[collapse]` syntax to work.

## Enable the filter on a text format

1. Log in as a user who can administer filters (an administrator by default).
2. Go to **Configuration → Content authoring → Text formats and editors**
   (`/admin/config/content/formats`) and click **Configure** next to the format
   you want, for example **Full HTML**
   (`/admin/config/content/formats/manage/full_html`).
3. Under **Enabled filters**, tick **Collapsible text blocks**.
4. Scroll to **Filter processing order** — this is the important part (see
   below).
5. Click **Save configuration**.

## Get the filter order right

Collapse Text transforms your text into `<details>`/`<summary>` markup, so it
must run **after** the filters that restrict and tidy HTML. In the **Filter
processing order** list, drag *Collapsible text blocks* **below (after)**:

- **Limit allowed HTML tags** (`filter_html`) — required. If Collapse Text runs
  before this, a section's body can slip past the allowed‑HTML restriction.
- **Convert line breaks into HTML** (`filter_autop`) — recommended, so line
  breaks inside sections render correctly.
- Any HTML corrector (`filter_htmlcorrector`), and filters such as **Media** or
  **Entity Embed**, which are known to conflict — run Collapse Text after them
  too, otherwise the generated tags get mangled.

This is standard Drupal filter‑ordering hygiene. A practical rule: only enable
Collapse Text on formats that already restrict HTML (or that are limited to
trusted roles), and always keep it ordered after *Limit allowed HTML tags*.

## The two settings

When you enable the filter, it shows a small settings area with two options:

- **Default title** — the title shown on a section that has no `title="…"`
  attribute and no heading to borrow. It defaults to *"Click here to expand or
  collapse this section"* and may not be left empty. Authors can override it for
  a single field with `[collapse options default_title="Click me!"]`.
- **Surround text with an empty form tag** — on by default. It wraps each
  generated group of sections in an empty `<form>` element so that the
  `<details>` markup validates as HTML. Turn it off to emit a plain `<div>`
  wrapper instead. Authors can override this per field with
  `[collapse options form="noform"]`.

## A note on sanitization

Collapse Text hardens section **titles** (they are HTML‑escaped), but it passes
section **body** content through as already‑safe markup — it does **not**
re‑filter the body. This is by design and is exactly why the filter must run
*after* your format's sanitizing filters (*Limit allowed HTML tags*). As long as
you keep the ordering above and only enable it on suitably restricted formats,
authors cannot inject unfiltered markup. This is normal text‑format behaviour,
not a module weakness.
