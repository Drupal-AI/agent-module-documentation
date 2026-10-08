# Typogrify — manual setup guide

**Typogrify** (`typogrify`) applies automatic typographic polish to your text:
curly "smart" quotes and apostrophes, proper en and em dashes, prevention of ugly
single-word "widows" at the end of headings, wrapped ampersands and runs of
capitals you can style, plus optional ligatures, fractions, arrows, and French-
style spacing. It's the kind of refinement a careful typesetter would do by hand —
done for you on every page, without changing what's stored in the database.

It works two ways. As a **text-format filter**, you enable it on a format (say
Full HTML) and it refines all content published in that format on output. As a
**Twig filter** (`|typogrify`), themers can apply the same refinements to any
string in a template — even computed values that never pass through a text format
— and can scope it to just the options they want, like smart quotes only or widow
removal only.

Everything is configurable per text format: each refinement is an individual
toggle, so you decide exactly which ones apply. Typogrify also attaches a small
CSS library that styles the wrapper spans it adds (showy ampersand, small caps,
hanging quotes), which you can restyle or replace. It has no global settings page,
no permissions, and no Drush commands, and depends only on core's **Filter**
module.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — enable and tune the filter on a text
   format, refinement by refinement.

## Where it lives in the admin menu

There's no dedicated settings page. You enable and configure Typogrify per text
format at **Configuration → Content authoring → Text formats and editors**
(`/admin/config/content/formats`).

## How to use it

1. Edit a text format (for example Full HTML) and tick **Typogrify** in its
   enabled filters.
2. Set the per-filter options — which refinements to apply — and mind the filter
   order relative to other filters. See [Configuration](configuration/index.md).
3. **Save.** Content in that format is now refined on output, while the raw source
   in the database stays untouched.
4. Optionally, in a Twig template, apply the same polish to a specific string with
   `{{ text|typogrify }}` — or scope it, e.g. `{{ title|typogrify(['widont']) }}`
   to only prevent widows on a heading.
