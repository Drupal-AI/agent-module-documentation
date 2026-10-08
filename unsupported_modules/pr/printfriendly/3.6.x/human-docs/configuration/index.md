# Configuration

All of printfriendly's options live on one settings form, and two permissions
control who can administer it and who sees the button.

## Open the settings form

1. Log in as a user with the **Administer printfriendly** permission.
2. Navigate to `/admin/config/printfriendly/config`.

Values are saved to the `printfriendly.settings` config object.

## The settings

### Where the button appears

- **Display** — tick the content types that should show the button. You can also
  enable the button on **teaser** listings (in that case it links to the node
  page).

### The button image

- **Button image** — choose one of the bundled button/icon images, or select the
  custom option.
- **Custom button image URL** — the URL of your own button image, used when the
  custom option is selected.

### PrintFriendly widget options

These map to PrintFriendly's own widget features and are applied via the inline
script the module injects:

- **Page header** — use PrintFriendly's default logo or a custom one.
- **Custom header image URL** — the logo image for the printout when using a
  custom header.
- **Tagline** — a header tagline shown in the printout.
- **Click to delete** — allow or forbid the visitor to click‑to‑remove elements
  before printing.
- **Include images** — include or exclude images in the printable version.
- **Image alignment** — how images are aligned in the printout: right, left, none,
  or block/center.
- **PDF** — allow or forbid the PDF download action.
- **Email** — allow or forbid the email action.
- **Print** — allow or forbid the print action.
- **Custom CSS URL** — a stylesheet URL applied to the printable output.

## Setting values with Drush

Each option is a key on `printfriendly.settings`, so you can script them:

```bash
ddev drush cset printfriendly.settings printfriendly_pdf 1 -y
```

## Permissions

| Permission | Grant to | Controls |
|---|---|---|
| **Administer printfriendly** | Trusted admins only (restricted permission) | The settings form. The header URL, tagline, and custom CSS URL entered here are placed into an inline script, so this is an admin‑only trust boundary. |
| **Access printfriendly** | Roles that should see the button (restricted permission) | Whether the Print Friendly button is rendered on nodes/teasers. The button only appears when the node's type is enabled **and** the user has this permission. |

## A note on the third‑party service

The printable version is produced by PrintFriendly.com, and the current page's URL
is sent to `printfriendly.com/print?url=…`. The widget's JavaScript, button
images, and printable rendering all come from `cdn.printfriendly.com`, loaded on
every page. Factor this into your site's privacy and consent handling. Printing
password‑protected or JavaScript‑rendered content requires a PrintFriendly Pro
subscription.
