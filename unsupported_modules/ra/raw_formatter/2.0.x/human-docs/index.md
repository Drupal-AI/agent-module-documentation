# Raw formatter — manual setup guide

**Raw formatter** (`raw_formatter`) adds a single field formatter called
**Raw Value** (plugin id `raw`) that is registered **only for Metatag fields**.
When a Metatag field is displayed with it, the formatter reads each item's value,
`json_decode`s it into key/value pairs, runs Drupal token replacement over each
value (with the host entity as context so tokens like `[node:…]` resolve),
re-encodes the map as JSON, and prints it through a theme template. This is the
**2.0.x** branch (release 2.0.2) of the project.

Its purpose is to surface a Metatag field's underlying *raw* value — most usefully
in **Services / REST Export views** or a decoupled/headless API response — rather
than a fully rendered set of meta tags. If you are feeding metatag data to a
front-end that does its own rendering and escaping, this is what gets you the
plain value.

The important detail: the template outputs the value with Twig's `raw` filter,
i.e. **unescaped**. The formatter's only cleanup is a regular expression that
strips HTML tags, which is not a robust sanitizer. Treat the displayed value as
trusted content.

> **Important — this module is unsupported.** On drupal.org the project is marked
> *Unsupported* with its security advisory coverage **revoked**. Because output
> is emitted unescaped, only apply this formatter to Metatag fields whose value
> is set by trusted editors; a value authored by an untrusted user could carry
> markup or script into the page (a cross-site-scripting risk). This is by design
> — it is the module's stated "raw value" behavior, gated by the site builder
> choosing this formatter — but it means the choice of *where* you apply it
> matters. Prefer an actively maintained alternative for new projects. (This
> differs from the older **1.x** branch, which applied the same raw rendering to
> fields more generally rather than only Metatag fields.)

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

There is **no configuration page** for this module — it has no settings form, no
config UI, and no permissions. You select the formatter on a Metatag field's
*Manage display*, as described below.

## Where it lives in the admin menu

Raw formatter adds no admin page of its own. You use it from **Structure →
Content types → *(bundle)* → Manage display** (or the equivalent *Manage
display* for any entity that has a Metatag field).

## How to use it

1. Make sure the entity/bundle has a **Metatag** field (the `metatag` field
   type).
2. Go to that bundle's **Manage display** tab and, per view mode, set the Metatag
   field's **Format** to **Raw Value**.
3. Save the display. The field now renders its decoded, token-replaced JSON
   payload unescaped — ready to be consumed by a REST Export view or an API
   client.

If you need to change how the raw value is wrapped in markup, you can override
the module's `raw-formatter.html.twig` template in your own theme; dropping the
`|raw` filter there will make the output escaped instead. See the sibling
[`agent/theming/raw_formatter.md`](../agent/theming/raw_formatter.md) notes for
the theme hook and variable name.
