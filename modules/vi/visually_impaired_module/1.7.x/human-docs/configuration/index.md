# Configuration

Setup has two parts: choose which theme is the low-vision version, and place the two
switch buttons where visitors can reach them.

## Step 1 — Choose the low-vision theme

Go to **Configuration → User interface → Visually Impaired module**
(`/admin/config/user-interface/visually_impaired_module`), behind the **Administer site
configuration** permission. The form has a single field:

- **Select Visually Impaired Theme** — a dropdown of every *enabled* theme. Pick the theme
  to show when a visitor turns on the low-vision version (for example
  `visually_impaired_theme`, or any high-contrast theme you have enabled). Save the form.

You can also set it from the command line:

```bash
ddev drush config:set visually_impaired_module.visually_impaired_module.settings visually_impaired_theme visually_impaired_theme -y
```

(The doubled segment in the config name — `visually_impaired_module.visually_impaired_module.settings`
— is intentional; that is the object the module uses.)

## Step 2 — Place the switch buttons

Both switches are blocks, placed via **Structure → Block layout**
(`/admin/structure/block`). Put them somewhere consistent, such as the header:

| Block | What its button does | Cookie it sets |
|-------|----------------------|----------------|
| **Visually Impaired block** | Turns the low-vision version **on** | `visually_impaired=on` |
| **Normal block** | Turns the low-vision version **off** | `visually_impaired=off` |

Each block has one setting, **Block style**, a radio choice of **Text** or **Image**
(default Image). It only changes a CSS class on the rendered button so you can style a text
link or an icon — it does not change what the button does.

## How the switch behaves

- Clicking a button sets the `visually_impaired` cookie (a host-wide session cookie with no
  expiry) and reloads.
- While the cookie is **on**, a theme negotiator serves your chosen low-vision theme on all
  **non-admin** pages. Admin pages always keep the normal/admin theme, so editors are not
  affected.
- Because the version is stored in a cookie, the module varies Drupal's anonymous page
  cache by the cookie value — the normal and low-vision renderings of the same URL are
  cached separately and stay correct for both kinds of visitor.

## Notes

- No account is required — anonymous visitors can toggle the version freely.
- There is no separate permission; the settings form uses **Administer site configuration**.
