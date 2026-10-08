# Configuration

The settings form is where you tell SCSS Compiler which theme to build and where
its files live.

## Open the settings form

1. Log in as a user with the **Administer site configuration** permission.
2. Go to **Configuration → Development → SCSS**, or navigate directly to
   `/admin/config/development/scss`.

## The settings

- **Theme** — which theme's Sass sources to compile. Switch this to compile a
  different theme.
- **SCSS/SASS source directory** — the folder containing your `.scss`/`.sass`
  sources, relative to the theme root (typically `sass` or `scss`).
- **Destination CSS directory** — where the compiled CSS is written, relative to
  the theme root (typically `css`).
- **Additional import paths** — extra directories to search when your Sass files
  `@import` shared libraries.
- **Additional paths to watch** — extra directories to monitor for changes so a
  rebuild is triggered when files in them change.
- **Files to ignore** — an ignore list to exclude partials or vendor files from
  compilation.
- **Active** — the master on/off switch for whether the module compiles at all.
- **Compile for logged-out users** — whether anonymous (logged-out) requests may
  trigger a rebuild. Leave this **off** and only authenticated traffic triggers
  recompiles; that is a reasonable production setting, but it means a change
  deployed without an authenticated page view will not compile until someone logs
  in — so use the `drush scss` command in your deployment instead.
- **Output formatting** — choose the CSS output style (for example compressed for
  production or expanded for readability while developing).
- **Source maps** — generate source maps so browser dev tools can map compiled CSS
  back to your Sass source lines.

## How recompilation is triggered

The module watches your source files and, on a page request, compiles if any
watched file is newer than the last compile (it tracks the last-compile time
internally, per theme). This is why the **Compile for logged-out users** setting
matters, and why on production it is usually best to keep compilation driven by the
Drush command rather than by live page requests — compiling on request means a slow
first hit after each change, and any error in a Sass file surfaces during a page
render.

## Save

Click **Save configuration**. On the next qualifying request (or the next `drush
scss` run) your Sass will compile to the destination directory, ready to be served
through Drupal's normal CSS libraries.
