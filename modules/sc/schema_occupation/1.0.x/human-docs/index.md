# Schema.org/Occupation — manual setup guide

**Schema.org/Occupation** (`schema_occupation`) adds the Schema.org
[`Occupation`](https://schema.org/Occupation) type to the JSON‑LD structured
data that your site outputs. It is a small add‑on for the **Schema.org Metatag**
framework: on its own it does nothing visible, but once Schema.org Metatag is in
place it lets you describe pages about occupations or jobs so that search engines
can read that information and, where they support it, show richer results.

Structured data is invisible markup that states plainly "this page is about an
occupation, here is its name, here is what it involves." Search engines and AI
assistants understand a page far better when it carries that markup. This module
simply supplies the `Occupation` vocabulary to the Schema.org Metatag system —
you then map your fields onto it through Metatag's normal settings screens.

The module has no configuration screen of its own and no content or access role.
It becomes useful the moment you enable it alongside Schema.org Metatag; the
actual field mapping happens on the Metatag settings page. It depends only on
`schema_metatag` and works on Drupal 9, 10, and 11.

This guide is written for a **human** setting the module up through the admin UI.
If you are an AI coding agent, read the sibling [`agent/`](../agent/start.md) docs
instead — they are terser and token‑cheap.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module and its Schema.org Metatag dependency.
2. [Configuration](configuration/index.md) — where the Occupation fields appear
   and how to map your content onto them.

## How to use it

Once enabled, the `Occupation` type becomes available inside Schema.org Metatag.
You configure it on the Metatag settings page under **Configuration → Search and
metadata → Metatag** (`/admin/config/search/metatag`), by choosing the content
type you want to describe and filling in the **Schema.org: Occupation** fields.
See the [Configuration](configuration/index.md) page for the step‑by‑step.
