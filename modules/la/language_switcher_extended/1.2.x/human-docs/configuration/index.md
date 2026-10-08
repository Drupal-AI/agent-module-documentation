# Configuration

Language Switcher Extended has one settings form and one configuration object. It
changes how core's **Language Switcher** block renders its links — you still place
and enable that block separately at **Structure → Block layout**.

## Open the settings form

1. Log in as a user with the **Administer language switcher extended** permission
   (`administer language_switcher_extended`).
2. Go to **Configuration → Regional and language → Language Switcher Extended**
   (`/admin/config/regional/language/language-switcher-extended`).

The form's fields appear and disappear depending on the mode you pick, so the
options below are described in that order.

## Mode — the top-level choice

- **Default** — leave the core switcher untouched. This is the installed default.
- **Always link to front** — point every switcher item at that language's front
  page, regardless of the current page. Turns the switcher into a "front pages of
  each language" menu.
- **Process untranslated** — inspect the content entity on the current page and
  act on the languages it *isn't* translated into. This is the main use case, and
  it reveals the options below.

## Options shown in "Process untranslated" mode

- **Untranslated handler** — what to do with a link whose language has no
  translation of the current content:
  - **Hide link** — remove the link entirely (good for SEO — no `<a>` to a
    missing translation).
  - **Link to front** — repoint the link to that language's front page instead of
    a broken link.
  - **No link** — render the language name as un-clickable text (a `<nolink>`)
    with the CSS class `language-link--untranslated`, so the switcher stays
    visually complete and you can style untranslated languages differently.
- **Translation detection** — how "translated" is decided:
  - **Default** — a translation counts when it exists and the current user has
    view access (so drafts a user can see still count).
  - **Published** — a translation counts only when it exists and is published (so
    unpublished translations are treated as missing).
- **Hide single link** — when hiding untranslated links would leave fewer than two
  links, drop the remaining link(s) too. When this is ticked, a further option
  appears:
  - **Hide single link block** — hide the whole switcher block, not just its link
    list, in that case.

## Options shown whenever the mode is not "Default"

- **Current language mode** — how the link to the language you're already viewing
  is shown:
  - **Default** — leave it as-is.
  - **Hide link** — remove it, so the switcher only offers *other* languages.
  - **No link** — render it as un-clickable text with an `is-active` class.
- **Show langcode** — replace each link's full language name with its language
  code (e.g. `en`, `de`), useful for a compact switcher.

Click **Save configuration** when done.

## Setting it from the command line

Because everything lives in the `language_switcher_extended.settings` config
object, you can script it. For example, to hide links for untranslated languages
on entity pages:

```bash
drush cset language_switcher_extended.settings mode process_untranslated -y
drush cset language_switcher_extended.settings untranslated_handler hide_link -y
```

Or to make every item link to its language front page:

```bash
drush cset language_switcher_extended.settings mode always_link_to_front -y
```

## Notes

- Nothing happens until the site is multilingual with translatable content **and**
  core's Language Switcher block is placed.
- The "process untranslated" logic only acts on **content entity** pages (nodes,
  terms, media, and so on). On admin pages, 404s, and non-entity routes it does
  nothing and the switcher falls back to core behaviour.
- "Always link to front" and "process untranslated" are mutually exclusive modes —
  you can't do both at once from this config.
