# Configuration

Name Field has two things you configure globally: the **name formats** (how names
are rendered) and a small **settings form** (the separators and required marker).
The per-field choices — which components are shown, required, and so on — are set
on each field itself and are covered in the [main guide](../index.md#how-to-use-it-adding-a-name-field).

## Name formats

A name format is a reusable pattern that turns the six stored components into a
rendered name. Manage them at **Configuration → Regional and language → Name
formats** (`/admin/config/regional/name`).

The module ships several ready-made formats:

- **Default** — e.g. "Mr. John Peter Smith Jr., PhD".
- **Full** — the full name without the extras.
- **Formal** — e.g. "Dr. John Smith".
- **Family** — just the family name.
- **Given** — just the given name.
- **Short full** — a compact full name.

You pick which format a field uses in that field's **formatter settings** on
*Manage display*, so the same data can appear differently in a teaser and on the
full page.

### Building your own format

Add a format at `/admin/config/regional/name/add`. Each format is a **pattern**
made of single-letter tokens for the components, plus separators and modifiers. The
main component letters are:

| Letter | Component |
|--------|-----------|
| `t` | title |
| `g` | given |
| `m` | middle |
| `f` | family |
| `s` | generational suffix |
| `c` | credentials |

Separators are `i`, `j`, `k` (the three separators from the settings form, below),
and there are extra tokens for initials (`I`, `J`, `K`, `M`) and case modifiers
(`U` uppercase, `L` lowercase, `F` capitalise, `G` capitalise each word). A `+`
between pieces is a **conditional join**: the separator only appears when the
components on either side actually have a value, so a name missing (say) a middle
name or a title doesn't end up with stray or doubled separators.

Some examples:

- `f, g` → "Smith, John" (family first).
- `f` → just the family name.
- The default's pattern `((((t+ig)+im)+if)+is)+jc` gracefully degrades for names
  that lack a title, middle name, suffix, or credentials.

The `default` format is locked and can't be deleted through the UI. The full token
reference lives in the [`agent/`](../start.md) docs.

### Author-list formats

At **Configuration → Regional and language → Name formats → List formats**
(`/admin/config/regional/name/list`) you manage how *multiple* names are joined
into a list — the delimiter between names, the word before the last name ("and"),
and an "et al." threshold that collapses a long list (e.g. "Smith et al." once
there are more than N authors). You pick a list format in a multi-value name
field's formatter settings.

## Global settings

At **Configuration → Regional and language → Name settings**
(`/admin/config/regional/name/settings`) you set values shared by every name
format:

- **Separator 1, 2, and 3** — the three separator strings referenced by the `i`,
  `j`, and `k` tokens in format patterns. The defaults are a single space, a
  comma-and-space, and an empty string, respectively.
- **Component required marker** — the marker shown next to required components on
  the widget (default `*`).

There is also a **preferred name** setting used when a Name field overrides a
user's login/display name — but that is configured from the field's own settings on
a User name field, not from this form.

Click **Save configuration** when done.

## Good to know

- Because output is driven by shared format entities, editing one format re-styles
  every field that uses it — no need to revisit each display.
- Name formats and settings are stored as configuration, so they export and import
  with your normal config workflow.
