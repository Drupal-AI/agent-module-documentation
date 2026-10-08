# Time Diff — manual setup guide

**Time Diff** (`time_diff`) adds a single Twig filter, `time_diff`, that turns a
date or timestamp into a human-friendly relative phrase such as "3 hours ago",
"2 days ago", or "in 2 days". It is a small developer/theming utility: instead of
computing relative times in a preprocess function or in PHP, you apply the filter
right in your template and let the module format the output.

The problem it solves is a familiar one — you have a publish date or a created
timestamp and you want to show "5 minutes ago" rather than a full calendar date.
Time Diff handles the arithmetic and the wording (including friendly edges like
"just now"), accepts a variety of date inputs, and defaults the end of the
comparison to *now* when you only give it a start value.

The module works the moment you enable it — there is nothing to configure and it
has no settings form, no permissions, and no dependencies beyond Drupal core. It
does not affect content, access, or storage in any way; it only formats output in
templates. It is in the "Custom" package on drupal.org.

This guide is written for a **human** working through templates and the admin UI.
If you want terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

## How to use it

Once the module is enabled, the `time_diff` filter is available in any Twig
template. Apply it to a date string or to an entity's date value:

```twig
{% set start_date = '2023-01-01' %}
Time Difference: {{ start_date|time_diff }}
```

Or straight from a node's created timestamp:

```twig
{{ node.created.value|time_diff }}
```

If you do not pass an end date, the filter compares against the current time, so
the phrase updates as time passes (subject to Drupal's render caching). There is
no admin page for this module — it lives entirely in your templates.
