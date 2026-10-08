# Raw Field Formatter — manual setup guide

**Raw Field Formatter** (`raw_formatter`) is a field formatter that takes a
field's stored value (expected to be JSON), decodes it, runs Drupal token
replacement over it, and renders the result through a theme template. Its
original purpose was to expose the *raw* underlying value of a field —
particularly for use in **Services / REST Export views** — rather than a
fully themed render. This is the older **1.x** (development) branch of the
project.

The key thing to understand before you enable it is right there in the name:
this formatter prints values **raw**, i.e. *unescaped*. Its template outputs the
value with Twig's `raw` filter, so whatever the field contains is written into
the page as-is. The only cleanup it does is a simple regular expression that
strips HTML tags — which is not a robust sanitizer.

> **Important — this module is unsupported.** On drupal.org the project is marked
> *Unsupported* with its security advisory coverage **revoked**, because a
> security issue was reported and not fixed by the maintainer. Because output is
> unescaped, applying this formatter to a field whose value can be set by
> untrusted users is a stored cross-site-scripting (XSS) risk: a crafted value
> can carry markup or script into the page. Only ever point it at fields whose
> values are controlled entirely by trusted editors, and prefer an actively
> maintained alternative for new projects. The 2.0.x branch of the same project
> narrows the formatter to Metatag fields but carries the same raw-output
> caveat.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

There is **no configuration page** for this module — it adds no settings form.
You simply select the formatter on a field's *Manage display*, as described
below.

## Where it lives in the admin menu

Raw Field Formatter adds no admin page of its own. You use it from **Structure →
Content types → *(bundle)* → Manage display** (or the equivalent *Manage
display* for any fieldable entity), where you choose it as the display format for
a field.

## How to use it

1. Go to the **Manage display** tab of the entity/bundle whose field you want to
   output raw.
2. Find the field, and in its **Format** column choose the raw formatter.
3. Save the display. The field will now render its decoded, token-replaced value
   through the module's template — unescaped.

Reserve this for values you fully trust (see the security note above), and test
the output before relying on it in production.
