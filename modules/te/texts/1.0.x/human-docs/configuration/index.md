# Configuration

Texts is managed from a single screen where you add, edit, translate, import and
export your reusable snippets.

## Open the management screen

1. Log in as a user who may administer the module.
2. Go to **Configuration → Regional and language → Texts**, or navigate directly
   to `/admin/config/regional/texts`.

## Managing snippets

Each snippet is identified by a **key** (for example `login.button`). You edit the
wording for that key, and its translation in each enabled language, from the
overview. Because the wording is tied to a stable key rather than to an English
base string, you can change the displayed text without breaking the reference used
in code or templates.

The snippets behave like Drupal's own translation functions:

- **Placeholders** — insert dynamic values such as `@name` into a string, exactly
  as you would with `t()`.
- **Pluralization** — provide separate singular and plural forms, as you would
  with `formatPlural()`.

## Hide unwanted languages

The overview can list a column for every enabled language, which gets wide on a
multilingual site. Texts lets you **hide languages you don't need** from the
overview so you can focus on the ones you actively translate.

## CSV import / export

Texts includes CSV **import and export**. Export all your strings to a CSV file,
translate them in an external tool or hand them to a translator, then import the
file back in. This is the quickest way to work through a large batch of strings
outside the Drupal UI.

## Using snippets in code and templates

Once your strings are defined, developers can pull them into output:

- In PHP: `getTexts('login.button', …)` and `getTextsPlural(…)` — these mirror
  `t()` and `formatPlural()`, and will create a string from the given key if it
  does not yet exist.
- In Twig: the `|getTexts(key)` and `|getTextsPlural(key)` filters.

If you enabled the **Texts GraphQL** submodule, the same snippets are also
readable by a decoupled front end over GraphQL.
