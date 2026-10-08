<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Zookeeper (zookeeper) — agent index

**A text-format filter that replaces animal words with the matching emoji.**

- **Version:** 1.0.x (1.0.0-beta2) — core `>= 8`.
- **Filter:** `@Filter('filter_zookeeper')` (`FilterZookeeper extends FilterBase`, type `TYPE_MARKUP_LANGUAGE`); `process()` does a case-insensitive `str_ireplace()` of ~70 animal words → emoji.
- **Setup:** enable the "Zookeeper Filter" on a text format at `/admin/config/content/formats` and order it in the pipeline.
- **Caveats:** `str_ireplace` is not word-boundary aware (substrings match); no settings/routes/services; purely presentational, no sanitisation.
- **Security:** no external calls, no user config beyond the format UI (`administer filters`), no mutating endpoints.
