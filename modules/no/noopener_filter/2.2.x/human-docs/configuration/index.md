# Configuration

Noopener Filter has two separate switches. They are independent — turn on either
or both. Most sites want at least the text-format filter.

## 1. Enable the filter on your text formats (editor content)

This is the main mechanism, and it covers links your editors write in CKEditor.

1. Log in as an administrator and go to **Configuration → Content authoring →
   Text formats and editors** (`/admin/config/content/formats`).
2. Click **Configure** next to the format you want to protect — commonly **Full
   HTML** and **Basic HTML**, but you can do the same for comment or webform
   text formats too.
3. Under **Enabled filters**, tick **Add noopener to all links**.
4. Click **Save configuration**.

From then on, any link in that format with `target="_blank"` gets `noopener`
added to its `rel` attribute when the content is rendered. Existing content is
covered automatically the next time it renders — you do not need to re-save old
nodes. Links without `target="_blank"` are left untouched, and only `noopener`
is added (never `noreferrer`). Repeat for each format whose content you want
hardened.

## 2. Turn on the global link-alter option (Drupal-generated links)

Independently, the module can add `noopener` to links Drupal itself builds — menu
links, link-generator output, `#type => 'link'` render elements — that carry
`target="_blank"`. This is **off by default**.

1. Go to **Configuration → Content** and open the Noopener Filter settings at
   `/admin/config/noopener-filter/settings`. (This form is gated by the
   **Administer noopener filter** permission, so grant that permission to the
   roles that should manage it.)
2. Tick the single **Filter links** checkbox.
3. Save.

You can also toggle it from the command line:

```bash
drush cset noopener_filter.settings filter_links 1 -y   # enable
drush cset noopener_filter.settings filter_links 0 -y   # disable
drush cget noopener_filter.settings filter_links        # read current value
```

The setting is stored in the `noopener_filter.settings` config object under the
`filter_links` key, so it exports and deploys like any other configuration. Note
that the module ships no config schema for this object, so `drush cset` may print
a "missing schema" warning — the value is still written and read correctly.

## Which one do I need?

- **Editor/WYSIWYG content only** — enable the filter on your text formats
  (step 1). This is the most common setup.
- **Menu links and other Drupal-generated links** — also turn on the global
  **Filter links** option (step 2).
- Enabling the filter on a format does **not** require the global flag, and the
  global flag does **not** require any filter — they work entirely separately.
