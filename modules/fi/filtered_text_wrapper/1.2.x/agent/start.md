<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Filtered Text Wrapper (filtered_text_wrapper) — agent index

**A text-format filter that wraps processed WYSIWYG output in an admin-configured prefix/suffix (default `<div class="wysiwyg">`…`</div>`).**

- **Version:** 1.2.x
- **Core:** ^10.1 || ^11 (PHP 7.4+)
- **Dependencies:** filter
- **Configure:** text format settings via `filter.admin_overview` (Configuration > Content authoring > Text formats and editors)
- **Surface:** one filter plugin, id `wrapper` (`Drupal\filtered_text_wrapper\Plugin\Filter\WrappingFilter`); settings `prefix`, `suffix`. `process()` returns `prefix . text . suffix`.

**Security:** prefix/suffix are set only by users with `administer filters` (trusted admin) and are emitted unescaped by design; there is no untrusted-user input path. Because wrapper markup is not re-sanitised, order this filter after any allowed-HTML filter. No anonymous or mutating endpoints; no findings.
