# Experience — manual setup guide

**Experience** (`experience`) adds a custom field type for capturing a duration of
work experience in **years and months**, and displaying it neatly as something
like "02 Year(s) 07 Month(s)". It's aimed at job portals, application forms, and
user registration — anywhere you need to record a candidate's total or
role‑relevant experience in a structured, consistent way rather than as free text.

The field's widget presents two select lists — one for years, one for months — so
editors and applicants pick values instead of typing them. The year list range is
configurable (you set a start and end year), and there's a **"Fresher"** option for
people with zero experience. You can also choose where the "Year"/"Month" labels
appear: above the selects, or inserted within each select as its first option. A
small bundled JavaScript library supports the widget's behaviour.

For display, the module ships two formatters — a default one that shows both years
and months, and a month‑only formatter for a more compact presentation. It also
integrates with **Views**, providing an Experience filter so you can filter or
build listings by experience (for example, sorting candidates by how much they
have). It's purely a field‑type provider — no routes, permissions, or settings
pages of its own — and depends only on core's **Field** module, supporting Drupal
8 through 11.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable it.

There is **no central settings form** — you add and configure the field on your
content type (or user, paragraph, etc.) through the Field UI, described below.

## Where it lives in the admin menu

Experience adds no admin page of its own. You add and configure the field under
**Structure → Content types → *(your type)* → Manage fields** (and its **Manage
form display** / **Manage display** tabs). The field can equally be added to users,
taxonomy terms, or paragraphs.

## How to use it

1. Go to the bundle you want the field on — for example **Structure → Content types
   → Job Application → Manage fields** — and **Add field**.
2. Choose the **Experience** field type, give it a label, and save.
3. In the field settings, configure the **year range** (start and end year) and the
   **label position** (above the selects, or within them as the first option). Turn
   on the **"Fresher"** option if applicants might have no experience.
4. On the bundle's **Manage form display**, the Experience widget (year + month
   select lists) is used for data entry.
5. On the bundle's **Manage display**, pick a formatter: the **default** formatter
   shows "X Year(s) Y Month(s)", or the **month‑only** formatter for a compact
   figure.
6. To filter or sort listings by experience, add the module's **Experience** filter
   to a View.
