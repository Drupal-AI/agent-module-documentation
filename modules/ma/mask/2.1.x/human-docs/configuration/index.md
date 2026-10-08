# Configuration

There are two things to configure: the **mask on an individual field** (the part
you'll do most often) and the **module-wide settings** (the library source and
the pattern-symbol table). Start with the field masks — the module works with the
default settings, so you only need to touch the settings form if you want to serve
the library locally or invent new pattern symbols.

## Mask an individual field

Masks are applied per field, per form mode, on a bundle's **Manage form display**
screen — and only on widgets that Mask supports.

**Supported widgets out of the box:**

- **Text field** widget (`string_textfield`) — used by plain text (`string`) fields.
- **Telephone** widget (`telephone_default`) — used by Telephone fields.

If a field uses a widget Mask doesn't support, no Mask settings appear on its cog.
(Other modules can register additional widgets — that developer topic is in the
[`agent/`](../agent/start.md) docs.)

**To add a mask:**

1. Go to the form display for your bundle, for example **Structure → Content types
   → Article → Manage form display**
   (`/admin/structure/types/manage/article/form-display`).
2. Click the **cog / gear** icon on a Text field or Telephone field row.
3. In **Mask settings**, fill in the options below.
4. Click **Update**, then **Save**. The field row's summary then shows
   `Mask: <your pattern>`.

**The options:**

- **Mask** — the pattern itself, written with the symbols from the table below.
  Examples: `00/00/0000` for a date, `(00) 0000-0000` for a phone number,
  `AAA-000` for three letters-or-digits, a dash, then three digits. Leave it empty
  to turn masking off for that field.
- **Reverse** — apply the mask from right to left. Useful for money or decimal
  amounts, where digits should fill in from the end.
- **Clear if not match** — when the visitor leaves the field, empty it if what they
  typed does not fully satisfy the mask. Keeps partial, invalid entries out.
- **Select on focus** — automatically select the whole value when the field gains
  focus, so the next keystroke replaces it.

An **Available patterns** section on the same settings panel lists the symbols you
can use in the Mask, for quick reference while you type the pattern.

## The mask alphabet (pattern symbols)

Every character in a mask is either a literal (like `-`, `/`, `(`, `)`, a space)
or one of these placeholder symbols. Mask ships five, and they cannot be changed
or removed:

| Symbol | Matches | Notes |
|--------|---------|-------|
| `0` | a digit | required |
| `9` | a digit | optional |
| `#` | digits | repeating |
| `A` | a letter or a number | |
| `S` | a letter | |

So `00/00/0000` accepts a date, `(00) 0000-0000` a phone number, and `AAA-000`
three alphanumerics followed by three digits.

## Module-wide settings

Go to **Configuration → Content authoring → Mask Field settings**
(`/admin/config/content/mask`). You need the **Administer Mask Field module**
permission (a restricted, site-builder-level permission). Two things live here.

### How the library is loaded

- **Use CDN** *(default, on)* — the jQuery Mask Plugin is loaded from a public CDN
  (cdnjs). Nothing to download; the simplest option and fine for most sites.
- **Use CDN off** — the module serves the library from your own site instead. When
  you save the form with the CDN turned off, it tries to download the library into
  your public files directory (`public://jquery.mask.min.js`). Alternatively you
  can set a **plugin path** pointing at a copy of the minified library you placed
  under your public files directory yourself. Choose this if your site must avoid
  external CDNs (for privacy, offline, or content-security-policy reasons).

### Add your own pattern symbol

Below the library setting is the **translation** table — the mask alphabet. The
five shipped symbols are locked, but you can add your own:

1. Click **Add another** to get a new row.
2. Set the **Symbol** (a single character you'll use in masks), the **Pattern**
   (a small regular-expression character class such as `[a-z]`), an optional
   fallback and description, and the **Optional** / **Recursive** flags if needed.
3. **Save configuration**.

Your new symbol is then available in every field's Mask and appears in the
Available patterns list. For example, adding symbol `Z` with pattern `[a-z]` lets
you write masks that only accept lowercase letters.

## Save

Click **Save configuration** (settings form) or **Save** (Manage form display).
Changes take effect on the next page load of the affected form.
