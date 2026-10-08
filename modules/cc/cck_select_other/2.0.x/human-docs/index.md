# Select Other — manual setup guide

**Select Other** (`cck_select_other`) is a form widget for **List** fields that
shows the configured options plus an extra **"Other"** choice — and when the user
picks "Other", a free-text box appears so they can type an answer that isn't on
the list. It's the combined widget for the pattern every form eventually needs:
"How did you hear about us?" with six options and a seventh that is whatever the
person actually did; a job title, a country of study, a referral source. Forcing
that tail into a bare "Other" with no text box throws the information away, and a
separate always-visible "Other, please specify" field clutters the form for
everyone. Drupal core has no widget for this, which is why Select Other exists —
it's a direct port of the classic Drupal 6/7 CCK feature (the `cck_` prefix gives
it away).

It works on native core **List** fields, so you can swap the widget in or out at
any time; it also provides a matching field formatter, supports a Views filter,
and lets you set a custom "Other" label. It depends on core's **Options** module.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

Two things to decide before you rely on it:

- **Where the "other" value is stored is the real design decision.** Writing the
  typed value back into the *same* List field means the field's allowed-values
  constraint is being bypassed — the stored value is no longer one of the list's
  options, which affects facets, Views filters, and anything else that assumes the
  list is a closed set. Storing it in a *second* field keeps the list clean at the
  cost of an extra field. Establish which behavior you want before you design any
  reporting on that data.
- **Free text collected this way is user input on display.** It needs the same
  escaping as any other user input, and it will accumulate near-duplicates
  ("LinkedIn", "Linked In", "linkedin") that need periodic reconciliation if
  anyone intends to analyze it.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

There is **no configuration page** for this module. You set it up per field on the
form display, described below.

## Version and compatibility

This is version **2.0.0-alpha3** — an alpha release. Note the **very tight** core
requirement: `^11.3 || ^12`, meaning Drupal 11.3 or later only (and reaching into
a major version that does not exist yet). If you're on an earlier Drupal, you'll
need the `8.x-1.x` branch instead (Drupal 10).

## How to use it

Select Other is a widget, so you enable it on a field's **Manage form display**:

1. Create (or reuse) a **List (text)** or **List (integer)** field on your content
   type — set its allowed values as usual.
2. Go to the bundle's **Manage form display** (**Structure → Content types →
   *(your type)* → Manage form display**).
3. For that field, choose the **Select Other** widget.
4. Open the widget's settings (the cog icon) to set options such as a custom
   **"Other" label**.

When editing content, the field now shows your list plus an "Other" option; choose
it and a text box appears for the free-text answer. To control how the stored
value is displayed, pick the module's matching formatter on **Manage display**.
