# Configuration

Auto Block Translation is configured through the `auto_node_translate.settings`
configuration, where you tell it which translator to use and which blocks it may
translate.

## Choose the translator

Point the module at the translation service you want it to use. If that service
is an external machine-translation API, it will need credentials — **treat those
as secrets:**

- Store the key in an **environment variable** (or a **Key** entity that reads
  from one), never in exported/committed configuration.
- With DDEV, set the variable with `ddev dotenv set .ddev/.env
  --your-api-key=<value>` and `ddev restart`, keeping `.ddev/.env` out of version
  control.

## Choose which blocks are translated

Decide which custom blocks the module should translate automatically. Keep this
scoped to blocks you actually want machine-translated, since translation is
triggered without a per-item confirmation step.

## Things to be deliberate about

- **Block content is sent to the translator.** For an external service that means
  the text leaves your site — a data-handling decision for anything sensitive.
- **Auto-translation removes the human "should this be sent?" gate.** Turn it on
  knowingly, for the blocks where automatic translation is genuinely wanted.
- **Review the results.** Machine-created translations are a strong starting
  point, but check them before depending on them for published content.
