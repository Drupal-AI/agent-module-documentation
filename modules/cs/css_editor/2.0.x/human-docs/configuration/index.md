# Configuration

CSS Editor has no settings page of its own. Instead it adds a **Custom CSS**
section to each theme's settings form, and you configure the CSS **per theme**.

## Open the Custom CSS editor

1. Log in as a user with the **Administer themes** permission (an administrator by
   default).
2. Go to **Appearance → Settings** (`/admin/appearance/settings`) and click
   **Settings** for the theme you want to style, or go straight to
   `/admin/appearance/settings/<theme>` (for example
   `/admin/appearance/settings/olivero`).
3. Find the **Custom CSS** section — it is open by default.

Remember that CSS is applied only while that theme is active. To style the admin
UI, edit the settings of your admin theme (usually **Claro**); to style the public
site, edit your front-end/default theme.

## The fields

### Enable or disable custom CSS

A master switch. When unticked, nothing is injected even if you have CSS saved —
handy for temporarily removing a banner or "under maintenance" style without
deleting it. Tick it to make your CSS live.

### The CSS editor (textarea)

Where you write your CSS. By default this is a CodeMirror editor with syntax
highlighting, loaded from a CDN. Anything valid in a stylesheet works — plain
rules, `@media print { … }` blocks, `:root { --color-primary: … }` custom-property
overrides, and so on. Your rules are injected *after* the theme's own stylesheets,
so they generally override them without needing `!important`.

### Use plain text editor

Turns off CodeMirror and gives you an ordinary textarea. Use this on locked-down
sites with no outbound internet access (where the CDN-hosted editor can't load), or
if you simply prefer a plain box.

### Enable auto preview

When ticked, the live-preview iframe updates as you type so you can see your
changes immediately. Untick it on slow connections if the constant re-rendering
feels sluggish; you can still save and reload to see the result.

### Preview

The section includes a live-preview iframe showing your site's front page rendered
with the theme you are editing, so you can check changes before they reach real
visitors. (The preview is only for your own editing session — it doesn't change
what anyone else sees until you save.)

## Save

Click **Save configuration**. On save the module writes your CSS out to a generated
file and rebuilds caches, so the change takes effect right away — reload a page
rendered with that theme to see it.

## Good to know

- **It's stored as configuration.** Each theme's custom CSS lives in a config
  object (`css_editor.theme.<theme>`), so it exports and imports with your normal
  configuration workflow and moves between environments. To roll back a bad change,
  revert that one config object.
- **The generated file is self-healing.** The CSS is rebuilt from config on every
  cache clear, so if you deploy the config to another environment, the next cache
  flush there regenerates the file automatically.
- **Per theme, per active theme.** CSS only loads while its theme is the active
  one. If a rule doesn't appear, check you edited the right theme (front-end vs.
  admin).
