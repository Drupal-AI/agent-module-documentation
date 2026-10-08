# Configuration

All setup happens on one screen: **Configuration → Media → Custom Bootstrap Icon
Font** (`/admin/config/media/bootstrap-icon-font`), the module's *generate* form.
You need the **administer custom bootstrap icon font** permission to reach it — the
whole surface is restricted to that permission.

Before you start, make sure the prerequisites from
[Installation](../installation/index.md) are in place: the source SVGs under
`web/libraries/…`, a writable `public://`, and Fantasticon installed.

## 1. Select your icons

The form keeps **Bootstrap Icons** and **Font Awesome** in separate lists. You can
add icons in whichever form is handiest:

- **Bootstrap** accepts lines like `arrow-right-circle-fill`,
  `bi-arrow-right-circle-fill`, `bi bi-arrow-right-circle-fill`, or a pasted
  `<i class="bi bi-arrow-right-circle-fill"></i>` snippet.
- **Font Awesome** accepts lines like `fa-arrow-down`, `fa-solid-arrow-down`, or a
  pasted `<i class="fa-solid fa-arrow-down"></i>` snippet.

The form also lets you **preview available icons** with pagination, and (for Font
Awesome) upload SVGs directly if your host allows writing to `libraries/`.

## 2. Tune the settings (optional)

The form is backed by the `custom_bootstrap_icon_font.settings` config, which
holds:

- **Font name** (`font_name`) — the output font‑family, default
  `custom-bootstrap-icons`.
- **Source directories** — where the SVGs live, default
  `libraries/bootstrap-icons/icons` and `libraries/fontawesome/icons`. Point these
  at custom locations if yours differ.
- **Generator command** (`generator_command`) — default `npx fantasticon`. Change
  it only if you need a specific path or a different runner (e.g. Yarn/pnpm). It's
  run as an argument array via Symfony `Process`, so no shell string is built.
- **Codepoints** — a persisted glyph→Unicode map the module manages for you, so
  previously‑used icons keep the same value across rebuilds. You don't normally
  edit this.
- **Version** — an integer the build increments; it's used as the `?v=`
  cache‑buster on the attached CSS.

## 3. Build the font

You have two ways to generate the assets:

- **From the UI** — use the form's **Save and build now** button. This is
  convenient for local/dev, but the same Node tooling must be available to the
  PHP/web user, and the request must be allowed to run long enough.
- **Via Drush** — the recommended path for CI/deploy. Run `drush cim` first (so the
  selected‑icon config is present), then run the module's Drush build command. The
  builder checks Fantasticon is available (`npx --no-install fantasticon
  --version`) before building and reports actionable errors if it's missing. Run
  `drush list` to find the exact command name.

Either way, output is written to `public://custom_bootstrap_icon_font/font/`
(`*.woff2` + CSS) and the `version` value is bumped.

## 4. Use the icons

The generated CSS maps each icon to a `.di-<icon>` class, and the module attaches
that CSS on the front end automatically (only when the file exists) — no theme edit
needed. In content or templates:

```html
<span class="di-arrow-right-circle-fill"></span>
```

A **Twig helper** is also provided for rendering icon markup in templates.

## Rebuilding

After adding new icons, build again to extend the existing font. Because codepoints
are stable across rebuilds, previously‑used icons keep their glyph values, and the
incremented `version` busts browser caches so the new CSS is picked up.
