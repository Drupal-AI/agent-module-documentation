# Configuration

Dynamic Library Loader is configured from a single admin form where you add "library
entries" — each entry pairs a declared asset library with the entity type it should
load on.

## Open the settings form

1. Log in as a user with the appropriate administration permission.
2. Go to **Configuration → System** and open the **Dynamic Library Loader** form.

## Add a library entry

For each library you want conditionally attached, add an entry:

- **Entity type** — choose from the drop‑down. The module currently supports
  **content types**, **taxonomy vocabularies**, **views**, and **paragraphs**.
- **Library and remaining fields** — enter the **machine names** here. This is the
  one thing to get right: while the entity type is a drop‑down, the other fields
  expect machine names, not human‑readable labels. Use the declared library's machine
  name (in the form `module_or_theme/library_name`) and the machine name of the
  specific bundle/view you're targeting.

Add as many entries as you need — one per library‑to‑entity mapping.

## Save

Save the form. From then on, whenever a matching entity is rendered, its library is
attached during global library aggregation — so the CSS/JS loads reliably on those
pages and stays off the pages that don't need it.

## Verify it worked

View a page for an entity you targeted and inspect the page source (or your browser's
dev tools) to confirm the library's assets are present. Then check a page that
*shouldn't* have it and confirm the assets are absent — that's the conditional
loading working as intended.

> **Tip:** if a library doesn't appear, double‑check you used the correct **machine
> name** for both the library (`module/library`) and the target bundle/view — a
> human‑readable label in those fields is the most common mistake.
