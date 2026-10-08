# Configuration

Setting up Color Scheme Switcher is a two‑part job: tell it how your theme
represents the active scheme, then place the switcher block.

## 1. Configure the per‑theme settings

1. Go to **Configuration → Color Scheme Switcher**
   (`/admin/config/cosesi/theme-settings`).
2. For each active **frontend theme**, configure:
   - The **CSS variable name** the module uses to express the active scheme.
   - The **HTML classes** applied to the `<html>` element for each scheme
     (for example `color-scheme-dark`), which your theme's CSS can target.
   - Optionally, a **"hide class"** (for example `color-scheme-only-dark`) so
     elements carrying it are hidden when the opposite scheme is active — handy for
     scheme‑specific images or banners.
3. Save.

These names must match what your theme's CSS actually expects. The module writes
the class/variable; your theme is responsible for styling in response to it.

> **Tip:** after configuring, export the new `cosesi.theme_settings` configuration
> along with the rest of your site config (`drush cex`) so it travels with your
> deployment.

## 2. Place the switcher block

1. Go to **Structure → Block layout** (`/admin/structure/block`).
2. Place the **Color Scheme Switcher** block in a region of your active theme.
3. In the block settings, choose:
   - The **widget type** — **Buttons** (one button per state) or **Dropdown**.
   - The **per‑state labels** (Light / System / Dark) and the **icon sizes**.
4. Save the block.

## How visitors experience it

Once placed, visitors can switch between Light, System (Auto), and Dark with no
page reload. Their choice is remembered in the browser's `localStorage`, so it
persists across page loads and refreshes. In **Auto** mode the site follows the
operating system's color‑scheme preference.

> **Note:** the block does not appear on batch‑process pages such as `/batch`,
> because those use a minimal page that bypasses the normal block layer. This is
> expected behavior.
