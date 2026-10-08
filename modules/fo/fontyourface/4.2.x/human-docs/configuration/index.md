# Configuration

Configuring @font-your-face is a four-step flow: enter any provider credentials,
**import** fonts, **enable** the ones you want, and **apply** them either site-wide
or through Font display rules. All of the admin pages below require the **Administer
font entities** permission.

## 1. The settings form

Go to **Appearance → @font-your-face → Settings**, or navigate directly to
`/admin/appearance/font/settings`.

This page holds the global loading options plus a set of per-provider **Import**
buttons.

- **Load all enabled fonts** *(on by default)* — when on, every font you enable is
  attached to pages automatically. Turn it off if you want fonts to load *only*
  where a Font display rule references them (see step 4).
- **Load on themes** — the themes on which enabled fonts should load. Leave it empty
  to load on all themes, or pick specific ones (for example only your front-end
  theme) to avoid loading web fonts on the admin theme. This only applies when
  "Load all enabled fonts" is on.

Some providers need credentials entered here before you can import — for example a
Google API key for Google Fonts, or a token for Typekit and Fonts.com. Fill those in
first.

## 2. Import fonts

Still on the settings form, click the **Import** button for a provider (or **Import
all fonts**). This runs a batch that fetches that provider's fonts and stores each
one as a `font` entity on your site. You only need to re-import when you want to pick
up new fonts a provider has added.

## 3. Enable the fonts you want

Go to the **font manager** at **Appearance → @font-your-face**
(`/admin/appearance/font`). This listing shows every imported font, with AJAX
**enable** / **disable** links. Enabling a font marks it active; you can preview any
font on its own page first (`/admin/appearance/font/{font}`). You can also filter and
sort the list by provider, weight, or style.

If "Load all enabled fonts" is on, enabling a font is all you need — it will now load
on the selected themes.

## 4. Apply a font precisely with a Font display rule

For fine-grained control — a specific font on specific CSS selectors for a specific
theme — create a **Font display** rule. Go to
`/admin/appearance/font/font_display` and click **Add**. A rule binds one enabled
font to CSS and has these fields:

- **Label** — a name for the rule.
- **Font** — which enabled font to apply.
- **Selectors** — the CSS selectors the font applies to, for example `h1, h2`.
- **Fallback** — a fallback font stack (for example `sans-serif`) so text still
  renders while the web font loads.
- **Style / Weight** — the font style and weight to use.
- **Theme** — which theme the rule applies to.

On save, the module generates a small CSS file for the rule and attaches it to pages
that use the chosen theme.

## Setting options from Drush

The core settings can also be set from the command line (importing fonts, however, is
done from the settings form UI because it is batch-driven):

```bash
drush config:set fontyourface.settings load_all_enabled_fonts 1 -y
drush config:set fontyourface.settings load_on_themes.0 olivero -y
```
