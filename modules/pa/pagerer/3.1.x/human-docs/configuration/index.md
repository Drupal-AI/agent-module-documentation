# Configuration

Pagerer configuration happens at **Configuration → User interface → Pagerer**
(`/admin/config/user-interface/pagerer`), which needs the **Administer site
configuration** permission. Everything you create is stored as configuration, so
it exports and deploys cleanly between environments.

There are three things you can do: build **presets**, replace the **core pager**
site‑wide, and tune the **URL querystring**. You can also apply a preset per View.

## Building a preset

A preset is a named, reusable pager made of three panes — **left**, **center** and
**right** — and each pane holds one style (or nothing).

1. On the Pagerer listing, click **Add pager**, give it a label, and save.
2. On the preset's edit form, choose a **style** for each pane:
   - **Standard** — a full pager like core's (First / Previous / page numbers /
     Next / Last).
   - **Basic** — a compact mini pager (current/total with prev/next), like Views'
     mini pager.
   - **Progressive** — links that jump to progressively more distant pages
     (for example +10, +20, +100).
   - **Adaptive** — a smart, context‑sensitive set of page links.
   - **Multipane** — a composite style that combines the others.
   - **None** — leave the pane empty.
3. Each pane has an **action** control to open that style's own options — things
   like how many page links to show (**quantity**), what to display (page numbers,
   item counts, or item ranges such as "Items 1–10 of 240"), the labels for
   First/Previous/Next/Last, and the separators between links.
4. Save the preset.

A fresh preset starts with the **center** pane set to **Standard** and the left
and right panes empty, which you can change freely. A common rich layout is: item
range on the left, page links in the center, and First/Last links on the right.

## Replacing the core pager site‑wide

By default Pagerer changes nothing until you tell it to take over. To make **every**
core pager on the site use one of your presets, set it as the core override. In
the UI this is on the Pagerer settings; from the command line:

```bash
drush cset pagerer.settings core_override_preset my_pager -y
```

Set the value back to `core` to restore Drupal's default pager:

```bash
drush cset pagerer.settings core_override_preset core -y
```

## URL querystring settings

At **Configuration → User interface → Pagerer → URL settings**
(`/admin/config/user-interface/pagerer/url_settings`) you can control how page
information appears in the URL:

- **Override core's query key** — replace core's `page` query parameter with
  Pagerer's own key. Off by default.
- **Querystring key** — the replacement key when the override is on (default
  `pg`), so a URL reads `?pg=…` instead of `?page=…`.
- **Index base** — whether page numbers in URLs start at `0` (core's default) or
  `1` (one‑based, friendlier links).
- **Encode method** — how the querystring is encoded, which matters when multiple
  pagers appear on one page.

For example, to turn `?page=0` into `?pg=1`:

```bash
drush cset pagerer.settings url_querystring.core_override 1 -y
drush cset pagerer.settings url_querystring.index_base 1 -y
drush cset pagerer.settings url_querystring.querystring_key pg -y
```

## Using a preset on a single View

You do not have to override the core pager globally to use Pagerer on a View. In
the View's **Pager** settings, choose **"Paged output, Pagerer"** as the pager
type, then pick which preset to use. This lets one View use a Pagerer preset
independently of whatever the site‑wide setting is — so you can mix a rich pager
on a search results View with the default pager elsewhere.
