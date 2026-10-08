# Configuration

Inline Style Aggregation has one settings form. It is disabled until you turn the
master switch on, so this page is a required stop.

## Open the settings form

1. Log in as a user with the **Administer inline style aggregation** permission.
2. Go to **Configuration → Development → Performance → Inline Style Aggregation**,
   or navigate directly to
   `/admin/config/development/performance/inline-style-aggregation`.

## Settings, field by field

- **Enable** (`enabled`) — the master switch. When off, the module does nothing;
  when on, it merges inline `<style>` tags into one block in the `<head>`. It's
  common to enable this per environment (for example, on production only).
- **Minify CSS** (`minify_css`) — strips comments and collapses whitespace in the
  merged block for a smaller payload. Turn it **off** while you are debugging CSS,
  so the merged output stays readable.
- **Preserve media** (`preserve_media`) — keeps the behavior of a
  `<style media="…">` block by wrapping its CSS in the matching `@media` rule (for
  example, `<style media="print">` becomes an `@media print { }` block). Leave this
  on unless you have a specific reason not to.
- **Include `<head>` styles** (`include_head_styles`) — by default the module folds
  in inline styles from the `<body>`. Turn this on to also aggregate `<style>` tags
  that are already in the `<head>`. A cautious rollout enables body styles first,
  then adds head styles once you're confident.
- **Head style selectors** (`head_style_selectors`) — when you include head styles,
  this list of CSS selectors limits *which* head `<style>` tags are folded in, so
  you can target just the artifacts you care about — for example editor leftovers
  like `head style[data-cke]` or `head style[data-mce-bogus]`.

## Save

Click **Save configuration**. Changes apply to newly rendered pages.

## Setting values with Drush

The same settings can be scripted, which is handy for deployment:

```bash
drush cset inline_style_aggregation.settings enabled 1 -y
drush cset inline_style_aggregation.settings minify_css 1 -y
drush cset inline_style_aggregation.settings include_head_styles 0 -y
```

## Good to know

- The aggregation runs very late in the response cycle and only on standard
  main‑request HTML pages. **BigPipe streaming responses are skipped
  automatically** — you don't need to configure anything for that.
- If your site uses a Content Security Policy, the module **preserves the `nonce`**
  from the original style tags on the merged block, so CSP keeps working.
- To confirm it's active, view a page's source and look for the
  `<style data-generated-by="inline_style_aggregation">` tag in the `<head>`.
