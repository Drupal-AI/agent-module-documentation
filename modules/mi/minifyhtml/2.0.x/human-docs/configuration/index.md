# Configuration

Minify Source HTML has no settings page of its own. Instead it adds its options
to Drupal's core **Performance** form. Nothing is minified until you turn it on
here — the module ships with minification switched off.

## Open the settings

1. Log in as a user with the **Administer minify HTML** (`administer minifyhtml`)
   permission. Users without it don't see the minify options.
2. Go to **Configuration → Development → Performance**, or navigate directly to
   `/admin/config/development/performance`.
3. Scroll to the **Bandwidth optimization** section — the module's fields appear
   there, alongside Drupal's CSS/JS aggregation options.

## The fields

### Minify Source HTML's HTML *(the master switch)*

The main on/off checkbox. It is **unchecked by default**, which is why enabling
the module alone changes nothing. Tick it to start collapsing whitespace in the
rendered page markup. Everything else on this page only matters once this is on.

*(Config key: `minify`, default `false`.)*

### Strip HTML comments

When ticked, the module also removes ordinary HTML comments (`<!-- … -->`) from
the page, plus multi-line `/* … */` comments inside inline `<script>` and
`<style>` blocks. IE conditional comments (`<!--[if …]>`) are always kept, so
this won't break conditional-comment tricks. This option is **on by default**,
but only takes effect when the master switch above is enabled.

*(Config key: `strip_comments`, default `true`.)*

### Exclude pages

A textarea of path patterns, one per line, listing pages where minification
should be skipped. Rules match the syntax you already know from Drupal's block
visibility settings:

- Start each path with a leading slash, e.g. `/admin`.
- Use `*` as a wildcard, e.g. `/admin*` matches the whole admin area.
- Use the `<front>` token to mean the site's front page.

The default is `/admin*`, which keeps the admin theme untouched. This field is
always visible on the form, but its value is only saved for users who have the
*Administer minify HTML* permission.

*(Config key: `exclude_pages`, default `/admin*`.)*

## Save

Click **Save configuration**. Changes take effect immediately for new page
builds. If you have a page cache warmed with old (unminified) content, clear
caches or let the cache expire so visitors receive the minified versions.

## Doing it from the command line

Because these are all configuration values, you can set them with Drush or ship
them between environments as exported config:

```bash
drush cset minifyhtml.config minify true            # turn minification on
drush cset minifyhtml.config minify false           # turn it off
drush cset minifyhtml.config strip_comments true    # also strip comments
drush cset minifyhtml.config exclude_pages '/admin*'
```

`drush config:export` will pick up your `minifyhtml.config` settings like any
other configuration.

## A note on the page cache

The module minifies each page just before Drupal's internal page cache stores
it, so the cached copy is already small and there is essentially no minification
cost on a cache hit. Keeping the core **Internal Page Cache** module enabled for
anonymous visitors is the best way to benefit. If a minification pass ever
misbehaves, the module logs a warning to the `minifyhtml` log channel and serves
the original page unchanged — so your site never breaks, you simply get an
un-minified response for that request.
