# Configuration

Setting up Real-time SEO has two parts: the **site-wide settings page**, which
controls how the analysis behaves, and **enabling the analysis on the content types**
you want to score. This page covers both, then explains what the analysis looks like
once it appears on a node edit form.

## The settings page

1. Go to **Configuration → Search and metadata → Real-time SEO**
   (`/admin/config/yoast_seo`).

![The Real-time SEO settings page with the Sitemap, Metatag templates and Auto refresh sections](../images/settings.png)

The page is organised into three collapsible sections plus a **Save configuration**
button:

- **Sitemap** — an informational notice. If it detects that you have both the *XML
  Sitemap* and *Simple XML Sitemap* modules enabled, it warns you to uninstall one of
  them, because the two can interfere with each other. There is nothing to fill in
  here.
- **Configure Metatag default templates** — a reminder that Real-time SEO builds on
  Metatag. It links to the **Metatag configuration page**, where you set the default
  title and description templates that the analysis and snippet preview use as their
  starting point. See the
  [Metatag setup guide](../../../../metatag/2.2.x/human-docs/index.md) for how to edit
  those defaults.
- **Auto refresh** — a single checkbox, **Enable auto refresh of the Real Time SEO
  widget result**. When ticked, the analysis re-runs automatically after you change a
  form field and move focus away from it, instead of waiting for you to trigger a
  refresh manually. The page notes that this can cause slight UI delays, because it has
  to wait for values such as the Metatag fields to become available before it can
  recalculate the score. Leave it off if you prefer to refresh the analysis yourself.

2. Set the **Auto refresh** checkbox to your preference and click **Save
   configuration**.

## Enable the analysis on a content type

The settings page controls *how* the analysis behaves, but not *where* it appears.
Real-time SEO is turned on for a given entity type (a content type, media type, custom
block type, or taxonomy vocabulary) by adding its **Real-time SEO** field to that
bundle:

1. Go to **Structure → Content types** and click **Manage fields** for the content
   type you want to analyse (for example *Article*).
2. Click **Add field** and add a field of type **Real-time SEO** (`yoast_seo`).
3. Go to that content type's **Manage form display** tab and make sure three widgets
   are enabled together: the **Real-time SEO** widget, the **Meta tags** widget, and
   the **URL alias** widget. All three are required for the analysis to work — the
   analysis reads the meta tags and the URL alias to score the page.
4. Save the form display.

Repeat for any other content types (or media, block, or taxonomy bundles) you want to
score. The analysis works on any content entity type as well as on taxonomy term
pages.

## Reading the analysis on the edit form

Once the field is in place, open the **edit form** of a piece of content of that type
(for example *Content → Add content → Article*). A **Real-time SEO** section now
appears on the form with three things working together:

- **Focus keyword** — a text field where you enter the search term the page should
  target. The analysis measures the rest of the content against this keyword: whether
  it appears in the title, the URL, the headings and the body.
- **SEO score and analysis** — a live score with a coloured status of **Good**,
  **Okay**, **Bad** or **Not available**, alongside a bulleted list of concrete
  improvements to make (for example that the meta description is too short, or the
  keyword is missing from the title). The score and list update as you edit — either
  automatically if you enabled **Auto refresh** above, or when you refresh the widget
  otherwise.
- **Snippet preview** — a Google-style preview of how the page will appear in search
  results, showing the title, the URL (pulled from the URL alias via core's Path
  module) and the meta description. Tune these before publishing to improve how the
  result reads.

The custom title and description you enter through the Real-time SEO field **override**
the Metatag defaults for that page; pages you leave untouched still fall back to the
Metatag default templates. That is why configuring your Metatag defaults first (via the
link in the settings page) gives the analysis and the snippet preview sensible starting
values.
