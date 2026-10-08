# CKEditor Read More — agent index

CKEditor 5 plugin + text filter that wraps selected rich-text content in a collapsible
"Read more" region. No config page (`configure` null), no permissions, no Drush. Provides a
config schema. Enable involves TWO steps on a text format: add the toolbar button AND enable
the `filter_readmore` filter.

- **Set up on a text format, plugin settings (`type`, `classes`), filter settings
  (`more_text`/`less_text`), required allowed-HTML, markup & JS behavior, CKE4→5 upgrade** →
  [configure/readmore.md](configure/readmore.md)

Key facts:
- CKEditor5 plugin id `ckeditor_readmore_plugin` (JS `readMore.ReadMore`), toolbar item `readMore`,
  class `Drupal\ckeditor_readmore\Plugin\CKEditor5Plugin\ReadMore` (configurable: `type`, `classes`).
- Filter `filter_readmore` (`ReadMoreFilter`) injects `data-readmore-more-text`/`-less-text` from
  its `more_text`/`less_text` settings and attaches `ckeditor_readmore/ckeditor_readmore` JS.
- Output wrapper: `<div class="ckeditor-readmore" data-readmore-type="text|button" …>`.
