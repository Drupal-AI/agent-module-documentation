# Configuration

Unlike most modules, String Plural Form does have a required step after you
enable it: telling it which plural-form rule to use for each of your languages.

## Open the settings form

1. Log in as a user with permission to administer the module (an administrator by
   default).
2. Go to **Configuration → Regional and language → Languages**, then **String
   Plural Form**, or navigate directly to
   `/admin/config/regional/language/string-plural-form`.

## Choose a plural form per language

The page lists every language enabled on your site. For each one, pick the
appropriate plural-form rule from the available options. This is the same choice
core would otherwise derive from a `.po` file's plural header — for example, a
two-form rule for English, or one of the multi-category rules for languages such
as Russian, Polish, or Arabic that distinguish several plural forms depending on
the number.

Once you save, translations and `format_plural()` output for that language use
the rule you selected, so counts render with the correct wording.

## Extending with custom rules

The module includes a small plugin system, so another module can define a custom
plural-form rule that then appears as an option here. If none of the built-in
rules fit a language you support, this is the supported way to add one — it is a
developer task rather than something configured on this form.

## Save

Save the form to apply your choices. Review the wording of a few plural strings
in each language afterward to confirm the counts read correctly.
