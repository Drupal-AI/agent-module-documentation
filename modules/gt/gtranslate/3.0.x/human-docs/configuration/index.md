# Configuration

Setting up GTranslate is two steps: place the block so the switcher appears on the
site, and tune its look and languages on the settings form.

## 1. Place the GTranslate block

1. Go to **Structure → Block layout** (`/admin/structure/block`).
2. Find the region where you want the switcher (a header or sidebar is common) and
   click **Place block**.
3. Choose the **GTranslate** block (listed under the *Accessibility* category) and
   configure the usual block visibility settings, then save.

The widget renders wherever you place the block — unless you point it at a specific
element using the *custom wrapper selector* setting (below). If you use Layout Builder,
you can add the block there instead.

## 2. Open the settings form

Go to **Configuration → Regional and language → GTranslate**
(`/admin/config/regional/gtranslate`). You'll need the **Configure GTranslate**
(`gtranslate settings`) permission. The settings save to the `gtranslate.settings`
configuration object and export/import with `drush config:export` like any other
config. Saving the form automatically refreshes the widget everywhere it appears.

The form is smart about what it shows: it hides the options that don't apply to the
widget style you've chosen, so you only see the relevant fields.

## Choosing the widget look

The **widget look** setting offers twelve styles:

- **Float** — a switcher that floats in a corner of the screen.
- **Nice dropdown with flags** — a styled dropdown showing flags (supports a light or
  dark color scheme).
- **Flags + dropdown** — flags alongside a dropdown.
- **Flags** — plain clickable flags.
- **Dropdown** — a plain language dropdown.
- **Flags with language name** / **Flags with language code** — flags plus a name or
  code.
- **Language names** / **Language codes** — text‑only lists.
- **Globe** — a globe icon that expands to a language list.
- **Popup** / **Popup with search** — a popup chooser, optionally with a search box
  (handy when you offer many languages).

## The main settings

- **Translate from (source language)** *(default: English)* — tells Google what
  language your site is written in. The source language is always included in the
  offered set.
- **Languages** — a table listing the ~103 available languages. Tick **Enabled** for
  each language you want to offer, and **drag the rows** to set the order they appear
  in the switcher, so priority markets can come first. The default set is English,
  Spanish, German, Italian, and French.
- **Native language names** *(on by default)* — show each language in its own alphabet
  (for example "Deutsch", "日本語") rather than the English name.
- **Detect browser language** *(off by default)* — automatically switch a first‑time
  visitor to their browser's language.

## Appearance options

Depending on the widget look, you may also see:

- **Flag size** — 16, 24, 32, or 48 px (flag‑based looks). **Flag style** — 2D SVG or
  3D PNG flags.
- **Globe size** — 20, 40, or 60 px (globe look only).
- **Color scheme** — light or dark (the nice dropdown‑with‑flags look).
- **Floating position** and **open direction** — which corner the floating switcher
  sits in and which way it opens.
- **Position** and **open direction** — placement for the non‑floating looks.
- **"Select Language" label** — the placeholder text shown in the dropdown looks.
- **Alternative flags** — offer alternative country flags for a language (for example
  USA/Canada for English, Mexico/Argentina/Colombia for Spanish, Brazil for
  Portuguese, Quebec for French).
- **Custom wrapper selector** *(default `.gtranslate_wrapper`)* — a CSS selector for
  the element the switcher should render into, if you don't want it rendered at the
  block's location.
- **Custom CSS** — extra CSS injected with the widget to brand or restyle it.

## Serving assets: CDN or local

- **Enable CDN** *(on by default)* — loads the widget's JavaScript and flag images from
  the GTranslate CDN. Turn it off to serve those files locally from the module instead,
  which is useful for privacy or offline environments.

## Free vs. paid, and SEO

- On the **free** plan, translation happens in‑place via JavaScript. It's quick to set
  up, but every language shares the original page URL, so translated pages are **not
  crawlable or indexable** by search engines.
- A **paid GTranslate subscription** unlocks **sub‑directory** (`example.com/fr`) or
  **sub‑domain** (`fr.example.com`) URL structures that *are* indexable — better for
  multilingual SEO — plus optional custom per‑language domains configured in the
  GTranslate dashboard and synced into the module. These options appear as the URL
  structure and custom‑domain settings on the form.

## Save

Click **Save configuration**. The switcher updates immediately wherever the block is
placed.
