# Configuration

All of the module's behaviour is set from one form. Before you open it, confirm
the two prerequisites are met: at least two languages configured, and the **URL**
language detection method enabled and prioritised (see
[Installation](../installation/index.md)).

## Open the settings form

1. Log in as a user who can administer the module (an administrator by default).
2. Go to **Configuration → Regional and language → Language Links On Menu**, or
   navigate directly to `/admin/config/regional/llom`.

## The settings

- **Menus** — select the menu (or menus) where the language switcher should
  appear. You can place it in more than one menu, such as both the main menu and
  the footer.
- **Language type** — choose which kind of language switching the links perform,
  matching the *Detection and selection* setup on your language configuration. If
  both *Interface text* and *Content* suit your site, the module gives priority to
  *Interface text*.
- **Weight** — set the switcher's weight within the menu. This is mainly how you
  push it to the beginning or the end of the menu's items.
- **Text format** — choose how each language is labelled: **full** (for example
  "English") or **short**, the two‑character ISO code (for example "EN").
- **Flags** — choose whether to show a flag image, and where it sits relative to
  the text: before it, after it, or the flag on its own with no text.

## About flags — your responsibility

If you enable flags, the flag image files must be placed in the site's
`public://` folder, named as the language's ISO code plus `.png` (for example
`en.png`). The module does **not** check that a flag file exists, that its
filename is correct, or that its dimensions are right — supplying and maintaining
correct flag files is up to you or your theme developer. The small jQuery script
that inserts the flags may also add its own CSS classes/styles or HTML around
them.

## Save and fine-tune

Click **Save configuration**. If you then want finer control over exactly where
the switcher sits within a menu, use **Menu UI** (**Structure → Menus**) to move
it — the module preserves almost all of your UI settings. Remember: if you have
manually positioned the switcher via Menu UI and later want to remove it, do a
**menu reset** from Menu UI *before* un-selecting that menu here, or the switcher
may keep showing.
