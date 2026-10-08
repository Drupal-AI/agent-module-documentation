# Estimated Read Time — manual setup guide

**Estimated Read Time** (`estimated_read_time`) adds a field that automatically
works out how long an entity takes to read and stores the result (minutes and
seconds) whenever the entity is saved. Add the field to a content type, and your
articles and blog posts can display a friendly "5 min read" badge without anyone
calculating anything by hand.

The module ships three pieces that work together: a **field type** that stores the
estimate and holds two settings (which view mode to measure, and the reading speed
in words per minute — 230 by default); a **widget** with an "Automatically estimate
read time" checkbox plus manual minutes/seconds inputs for when you want to override
the estimate; and a **formatter** that renders a customizable string like
`@minutes min read`. The estimate is calculated from the entity rendered in your
chosen view mode, using the site's front-end theme, so it reflects what readers
actually see.

There is **no admin settings page** — you configure everything through the field,
its widget, and its formatter on an entity bundle (the same three "Manage fields /
form display / display" screens you use for any field). It works on any fieldable
entity type, not just nodes, and re-estimates each translation of multilingual
content on save.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module (and its required
   library) with Composer and enable it.

## How to use it

There is no central settings page; you add the field to a bundle and tune it in the
usual three places.

### 1. Add the field

1. Go to **Structure → Content types → [type] → Manage fields → Add field**.
2. Choose the **Read Time** field type (`estimated_read_time`) and give it a label.
3. On the **field settings** screen, set:
   - **View mode** — which view mode of the entity is rendered to measure the text
     (for example *Full content* rather than *Teaser*).
   - **Words per minute** — your audience's reading speed (default **230**; tune it,
     e.g. 200 for technical content, 260 for casual).

### 2. Configure the edit form (widget)

On **Manage form display**, the field uses the **Minutes and seconds** widget. Its
one setting, **Sidebar**, moves the field into the entity form's advanced/sidebar
group. In the form, editors see an **Automatically estimate read time** checkbox
(leave it on for automatic estimates); unchecking it lets them type a manual
minutes/seconds value that is then kept on save.

### 3. Configure the display (formatter)

On **Manage display**, use the **Estimated read time text** formatter. Its
**Tokenized string** setting controls the output — default `@minutes min read`,
where `@minutes` and `@seconds` are replaced with the stored values. Show just
minutes (`@minutes min read`) or include seconds (`@minutes min @seconds sec`). If
the referenced value is empty, the formatter prints nothing, so you never get an
awkward "0 minutes read".

The estimate is recomputed automatically each time the entity is saved (with the
auto checkbox on) — there is no cron or queue. To refresh it, resave the entity.
