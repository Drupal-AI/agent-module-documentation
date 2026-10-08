# Configuration

DROWL Trademark has a single setting: the list of words that should receive a
superscript ® on the rendered page.

## Open the settings form

1. Log in as a user with the permission to administer DROWL Trademark (an
   administrator by default).
2. Go to the **Extend** page (`/admin/modules`), find **DROWL Trademark**, and use
   its **Configure** link — or look for its entry under **Configuration**.

## Set the words to mark

The form provides one field:

- **Words** — a **comma‑separated list** of the words (typically brand or product
  names) you want a registered‑trademark sign appended to. For example:
  `Acme, Widgetify, ExampleBrand`. At runtime the module scans rendered pages and
  adds a superscript ® immediately after each listed word — including occurrences
  in menus and other areas that normally bypass input filtering.

Keep the list to the exact terms you are entitled to mark, and mind
capitalisation and spelling so only the intended words are matched.

## Save

Save the form. Reload a front‑end page containing one of your words to confirm the
® now appears after it. Because the symbol is added by JavaScript in the browser,
it shows on the rendered output rather than being written into your stored content.
