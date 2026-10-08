# Configuration

Dropdown Language Switcher has two layers of configuration: a single **global
settings form** that controls how *every* dropdown labels its languages, and
**per‑block instance settings** you set when you place the block (including the
per‑language custom labels, if you chose that label style).

## Open the global settings form

1. Log in as a user with the **Administer site configuration** permission (an
   administrator by default).
2. Go to **Configuration → Regional and language → Dropdown Language Switcher**,
   or navigate directly to `/admin/config/regional/dropdown-language-switcher`.

These settings are saved to the exportable `dropdown_language.setting` config
object, so they deploy cleanly between environments.

### Language label style

Choose how each language is labelled in every dropdown:

- **Language Name** *(default)* — the full name, e.g. "English", "French".
- **Language ID** — the language code, uppercased, e.g. "EN", "FR", "DE". Good
  for saving horizontal space.
- **Native Name** — each language in its own tongue, e.g. "Deutsch",
  "Français" (falls back to the regular name where a native name is missing).
- **Custom Labels** — you supply the wording yourself, per language, on each
  placed block instance (see below).

### Show block with fieldset wrapping

When ticked, the dropdown is wrapped in a `<fieldset>` titled "Switch Language",
which groups it visually and gives it a heading. Leave it unticked for a bare
dropdown.

### SEO: remove links to untranslated content

When enabled, on entity pages the switcher drops links to translations that do
not exist, or that the current user's role is not allowed to view. This keeps the
switcher from pointing visitors (and crawlers) at missing or forbidden pages.

### Always show the block

Normally the switcher renders nothing when fewer than two language links are
available on the current page. Turn this on to keep the block on the page anyway.

Click **Save configuration** to apply. Changes take effect immediately across
every placed dropdown.

## Place the switcher block

1. Go to **Structure → Block layout** (`/admin/structure/block`).
2. Click **Place block** in the region you want (header, sidebar, footer…).
3. Find the block under the **Dropdown Language** category. If your site has more
   than one configurable language type you will see a separate entry per type —
   for example "Dropdown Language (Interface text)" or "Dropdown Language
   (Content)". Pick the negotiation type this dropdown should switch.
4. Configure the block as usual (title, visibility conditions) and save.

The block hides itself automatically on monolingual sites and on 403/404 pages,
and it is intentionally uncacheable so the active language is always current.

## Per‑block custom labels

If you set the global label style to **Custom Labels**, each placed block
instance's configuration form shows a required text field for every language,
under "Custom Labels for Language Names". Fill in the wording you want for that
instance; the values are stored with the block itself, not in the global
settings. Because custom labels bypass Drupal's translatable interface strings,
the module suggests creating one block instance per language and using core's
Block **Language visibility** to target each — or, if you simply want the labels
to follow the interface language, use one of the non‑custom styles and translate
the strings under **User interface translation** instead.
