# Configuration

You manage everything at **Configuration → Content authoring → Custom Filter**
(`/admin/config/content/customfilter`). You need the **Administer customfilter**
permission (see the trust note below). The model is two levels: a **filter** is a
container; **rules** inside it do the actual regex transforms; **subrules** reprocess
the captured groups of a parent rule.

## Create a filter

A filter is the thing that shows up on your text formats. Add one at
`/admin/config/content/customfilter/add`. Its fields:

- **Name** — the label shown when enabling the filter on a text format.
- **Description** — internal notes.
- **Short tip / Long tip** — the filter tips shown to editors beneath text areas,
  describing what the filter does.
- **Cache** — whether the filter's output is render‑cached (turn off for rules whose
  output must always be recomputed).

Saving a filter makes it available as a selectable filter — named `customfilter_<id>`
— on **every** text format, switched off by default.

## Add rules

Open a filter to add its rules. Each rule has:

| Field | Meaning |
|---|---|
| **Name / Description** | Label and notes for the rule. |
| **Enabled** | Whether the rule runs. |
| **Pattern** | A PCRE regular expression **including delimiters**, e.g. `#(https?://[^\s<]+)#`. |
| **Replacement** | The replacement text — or PHP code, when the code box is ticked. |
| **PHP Code** | Off = a literal / backreference replacement; On = the replacement is run as PHP (see below). |
| **Weight** | Ordering; rules apply from lowest weight to highest. |

**When the PHP Code box is off**, the rule does a plain regex replace, and
backreferences `$1`…`$99` (and `${1}`…`${99}`) from the pattern are available, with
`$0` being the whole match. Example — wrap bare URLs in links:

```
pattern:     #(https?://[^\s<]+)#
replacement: <a href="$1">$1</a>
code:        off
```

**When the PHP Code box is on**, the replacement string is executed as PHP each time
matching content is rendered. Your code receives the regex captures as
`$matches[0..n]` and must assign a `$result` variable, whose value becomes the
replacement. A persistent `$vars` object (reset once per filter run) lets you share
state between the rules of one filter. Don't wrap the code in `<?php ?>`. Example —
uppercase every match:

```
pattern:     /\bhello\b/i
replacement: $result = strtoupper($matches[0]);
code:        on
```

## Subrules

A rule can have **subrules**: after the parent rule matches, each subrule runs against
just one chosen capture group of the parent (its **matches** index) before the parent
produces its final replacement. This lets you reprocess only part of a match.

## Turn the filter on for a text format

Defining a filter doesn't change any content by itself. Go to **Configuration →
Content authoring → Text formats and editors**
(`/admin/config/content/formats`), edit a format, and enable your
`customfilter_<id>` filter there. (Filter order on that page still matters, as with
any Drupal filter.)

## Migrating legacy rules

The module ships a migration source for importing Custom Filter rules from an old
Drupal 6 or 7 site, run through the core Migrate pipeline.

## Trust / security note (read this)

This is the same warning from the overview, because it matters:

- A rule with **PHP Code** on runs **arbitrary PHP** on your server every time a text
  format using the filter renders content.
- A rule with PHP Code off inserts its **replacement verbatim** into rendered content
  — with no escaping — so it can inject arbitrary HTML/JS (**stored XSS**).

Both are gated by the single **Administer customfilter** permission (correctly marked
*restrict access*). Treat it exactly like *Administer filters* or the ability to add a
PHP/Full‑HTML text format, and grant it only to fully trusted administrators.
