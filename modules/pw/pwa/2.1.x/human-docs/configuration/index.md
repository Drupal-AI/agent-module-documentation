# Configuration

Everything the PWA module needs lives on one form. This page walks through it
field by field.

## Open the manifest form

1. Log in as a user with the **Administer PWA** permission (an administrator by
   default).
2. Go to **Configuration → Web services → Progressive Web App → Manifest**, or
   navigate directly to `/admin/config/services/pwa/manifest`.

## Basic fields

These are the core identity of the app:

- **Name** — the full application name (for example, "My Company Portal"). Shown
  on install prompts and app listings.
- **Short name** — a shorter label used under the home‑screen icon where space is
  tight.
- **App ID** — an optional stable identifier that keeps the app's identity
  consistent across installs and updates.
- **Start URL** *(default `/`)* — the page the app opens on when launched from the
  home screen.
- **Display** *(default `standalone`)* — how the installed app is framed. Choose
  **standalone** for an app‑like window with no browser chrome, **fullscreen** to
  fill the whole screen, **minimal-ui** for a minimal set of browser controls, or
  **browser** to open in a normal tab.

## Recommended fields

- **Theme color** *(default `#ffffff`)* — the browser/OS accent color for the
  app. This value is also emitted as a `theme-color` meta tag on your pages, so
  it colors the browser toolbar even before install.
- **Background color** *(default `#ffffff`)* — the color shown on the splash
  screen while the app loads.
- **Scope** *(default `/`)* — the section of the site the app is bound to.
  Navigation outside the scope is treated as leaving the app.
- **Orientation** *(default `any`)* — the preferred screen orientation
  (for example `portrait` or `landscape`).

## App icons

Upload up to three PNG icons — **512 px**, **192 px**, and **144 px**. These are
the icons shown on the home screen and in install prompts. If you leave any of
them empty, the module falls back to its own bundled default icons, so the
manifest always advertises a complete icon set.

## Optional fields

- **Description** — a short description of the app (added to the manifest only
  when filled in).
- **Categories** — app‑store‑style categories (added only when set).
- **Language / Direction** — a `lang` value and text direction (`dir`) for
  localizing the manifest; these are added only when set.
- **Cross‑origin credentials** — if your site sits behind HTTP authentication,
  enable this to add `crossorigin=use-credentials` to the manifest `<link>` so
  the browser can fetch the manifest with credentials.

## Which pages get the manifest link

Two settings control where the `<link rel="manifest">` tag is injected:

- **Path mode** *(default: all except listed)* — when set to "all except listed",
  the manifest link is added on every page **except** the patterns you list.
  Switch it to the include mode to add the link **only on** the listed patterns.
- **Paths** — a newline‑separated list of path patterns. The shipped default
  excludes `/admin`, `/admin/*`, `/batch`, `/node/add*`, and `/node/*/*`. Leave
  the list empty to add the manifest on all pages.

Remember that the link and the `theme-color` meta are only emitted for users who
hold the **Access PWA** permission, regardless of these path rules.

## Save

Click **Save configuration**. You can confirm the result by visiting
`/manifest.json` (or running `curl -s https://<your-site>/manifest.json`) and
checking that your name, colors, and icons appear.
