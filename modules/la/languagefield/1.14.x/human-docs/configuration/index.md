# Configuration

Language Field has no single settings form. You configure it in two places: on
each Language field you add, and on the Custom languages admin page. This guide
covers both.

## Add a Language field to a bundle

1. Go to the bundle you want to extend — for example **Structure → Content types
   → Article → Manage fields** — and click **Add field**.
2. Choose the **Language** field type.
3. Give it a label (e.g. "Spoken languages") and, if editors should be able to
   store more than one language, set the field's **Allowed number of values** to
   *Unlimited* (or a fixed count).

### Choose which languages the field offers

On the field's **storage settings** you control the pool of selectable
languages. The key setting is the **language range**, which can combine any of
these sets:

- **Configurable languages** — only the languages the site has configured (for
  example English and German).
- **Locked languages** — Drupal's special codes `und` ("not applicable") and
  `zxx` ("no linguistic content"), useful as "multiple languages" or "not
  applicable" choices.
- **All core languages** — configurable plus locked.
- **Site default language** only.
- **All predefined languages** — every ISO 639 predefined language, regardless of
  what the site has installed. This is the default.
- **Custom languages** — the languages you register on the Custom languages page
  (see below).

You can combine ranges, for example *all predefined* plus *custom*. Two further
lists refine the result: an **included languages** allow‑list restricts the field
to just those codes, and an **excluded languages** deny‑list hides specific codes.
There is also a **maximum code length** (`maxlength`, default 12) for unusually
long custom codes.

### Choose the editor widget

On the bundle's **Manage form display** page, pick how editors enter languages:

- **Select list** (`languagefield_select`) — the default drop‑down.
- **Autocomplete** (`languagefield_autocomplete`) — a single type‑ahead field.
- **Autocomplete (tags)** (`languagefield_autocomplete_tags`) — a tags‑style
  field for entering several languages at once.

### Choose how stored languages display

On the bundle's **Manage display** page, the **Language** formatter lets you
render each stored code as one or more of: an ISO 639 code, the English name, the
native name (e.g. "Nederlands"), or a flag icon (when the Language Icons module
is installed). It tries these formats in order, and an optional **link to entity**
setting wraps the output in a link back to the host content.

## Register custom languages

When you need a language Drupal doesn't ship, register it as a **Custom
Language**:

1. Go to **Configuration → Regional and language → Custom languages**
   (`/admin/config/regional/custom_language`). This page needs the **Administer
   language field** permission.
2. Click **Add custom language** and fill in:
   - **Id** — the language code (for example `tlh`).
   - **Label** — the English name (for example "Klingon").
   - **Native name** — how the language names itself (for example "tlhIngan
     Hol").
   - **Direction** — left‑to‑right or right‑to‑left, so the language displays
     correctly.
   - **Weight** — where it sorts among the other languages.
3. Save. The custom language now appears in any Language field whose range
   includes **Custom languages**.

You can edit or delete a custom language later from the same page.

## Permissions

The module adds one permission, **Administer language field**, which controls
access to the Custom languages admin page. Grant it under **People →
Permissions** to any role that should manage the custom‑language list.
