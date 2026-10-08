<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Using the Newspaper Playwright process plugin

```yaml
process:
  _scraped:
    - plugin: get
      source: link
    - plugin: migrate_process_newspaper_playwright
      debug: false          # default false; true dumps JSON to /tmp
      command: python3       # optional interpreter path
      cwd: '../python'       # optional script working dir (relative to docroot)
  _title:
    - plugin: get
      source: '@_scraped'
    - plugin: extract
      index: [ _title ]
```

Returns an array with keys such as `_title`, `_text`, `_top_img`, `_imgs`, `_images`, `_authors`, `_publish_date`, `_summary`, `_html`, `_article_html`, `_meta_data`, `_meta_description`, `_keywords`, `_tags`.

Requirements: install the Python wrapper (`pip3 install playwright`, browsers) per the upstream README; older distros may need Playwright ≤1.30. `transform()` only runs for absolute http(s) URLs; exceptions log a notice and return `''`.
