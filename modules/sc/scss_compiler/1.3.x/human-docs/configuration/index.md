# Configuration

SCSS/Less Compiler has no page of its own — it adds its options to the core
**Performance** form. Open **Configuration → Development → Performance**
(`/admin/config/development/performance`) as a user who can administer site
configuration.

## The settings, one by one

- **Cache compiled CSS** *(default off)* — when on, compiled CSS is cached and not
  rebuilt on every page. Leave it **off during development** so your Sass edits
  show immediately; turn it **on for production**.
- **Source maps** *(default on)* — emit a `.css.map` next to each compiled file so
  browser dev tools map the CSS back to your original `.scss` source. Handy while
  developing; you may disable it in production.
- **Output format** *(default Compressed)* — how the CSS is written:
  - **Compressed** — minified, smallest output (best for production).
  - **Expanded**, **Nested**, **Compact** — progressively more readable output
    (useful while developing).
  - **Crunched** — an aggressive minification.
  (Anything unrecognized falls back to Compressed.)
- **Flush cache type** *(default Default)* — what a cache flush purges. **Default**
  keeps compiled CSS on a system cache flush if caching is on; **System** always
  deletes the compiled-CSS directory whenever the cache is flushed.
- **Check modify time** *(default on)* — only recompile a source whose file
  modification time has changed, which keeps page builds fast. Leave it on unless
  you have a reason to force recompilation.
- **node_modules path** *(optional, empty by default)* — a path to a
  `node_modules` directory if your Sass `@import`s pull from packages installed
  there.
- **Compiler plugins (extension → backend map)** — maps a file extension to the
  backend that compiles it. Out of the box `.scss` is handled by the default
  scssphp backend. To compile `.less` too, add a mapping for the `less` extension
  to the Less backend (the module ships Less and libsass backends alongside the
  default).

Click **Save configuration**.

## How files actually get compiled

There is no manual build step. The flow is:

1. You declare a Sass source in a `*.libraries.yml`, for example:

   ```yaml
   global:
     css:
       theme:
         css/style.scss: {}
   ```

2. When that library is used, the module swaps the `.scss` source for a freshly
   compiled CSS file under `public://scss_compiler/…`, compiling it whenever the
   output is missing or the source changed.
3. With **caching off**, it also re-checks all sources on each request (gated by
   modification time), so edits appear right away.

You can also import from another module or theme's Sass using `@namespace/path`
tokens in your libraries file, add extra `@import` search paths in code, and
override Sass variables (like a brand color) globally or per file — those last two
are done through developer alter hooks documented in the sibling
[`agent/`](../agent/start.md) docs.

## Recompiling and flushing

When you change Sass sources or the output format, force a rebuild any of these
ways:

- **Drush:** `drush compiler:cr` (alias **`drush ccr`**) — recompiles everything.
- **Menu action:** the **Flush compiler cache** link added under the admin
  toolbar (route `/admin/flush/scss_compiler`), which needs the *Administer site
  configuration* permission.
- **Any full cache rebuild** (`drush cr`) also triggers a recompile.

Flushing deletes the compiled-CSS directory, recompiles all registered sources,
and clears CSS aggregation.
