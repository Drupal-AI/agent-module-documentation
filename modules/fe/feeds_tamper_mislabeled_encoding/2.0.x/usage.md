<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Feeds Tamper Mislabeled Encoding is a Tamper plugin that repairs the common mojibake where Windows-1252 punctuation (bytes 0x80-0x9f), labeled as ISO-8859-1 and then UTF-8-encoded, appears as wrong characters in imported strings.
---
The module provides a single Tamper plugin (`@Tamper id = "mislabeled_encoding"`, category "Text") for use in Feeds Tamper. Its `tamper()` method takes a string and does a fixed `str_replace()` over a lookup table mapping each two-byte sequence `"\xc2\x80"`…`"\xc2\x9f"` (a Windows-1252 control-range char that got mis-encoded) to the correct Unicode character — e.g. `\xc2\x80` → € (U+20AC), `\xc2\x92` → ' (U+2019 right single quote), `\xc2\x97` → — (U+2014 em dash). Non-string input throws a `TamperException`.

There is no configuration, no routes, services, forms, or permissions — it is a pure data-transformation plugin that plugs into the Feeds Tamper pipeline and runs during feed import. Add it to a source field in a Feeds tamper configuration to clean up smart quotes, dashes, ellipses, and the euro sign that would otherwise import as garbled sequences.
---
- Fix smart quotes that import as garbled characters from a mislabeled feed.
- Correct em/en dashes mangled by Windows-1252 vs ISO-8859-1 confusion.
- Repair the euro sign appearing as mojibake in imported text.
- Clean up ellipsis and bullet characters during feed import.
- Add the Tamper plugin to a text/source field in a Feeds tamper config.
- Normalize titles pulled from a CSV exported with the wrong encoding.
- Sanitize body text from an RSS/Atom feed with mislabeled charset.
- Chain with other Tamper plugins in the import pipeline.
- Apply per-field to only the source columns that need encoding repair.
- Run automatically on each Feeds import without manual intervention.
- Convert Windows-1252 punctuation to proper Unicode equivalents.
- Avoid double-encoding artifacts in migrated content.
- Handle Latin capital/small letters with caron (Š, š, Ž, ž) correctly.
- Fix the trademark and per-mille signs in imported strings.
- Standardize quotation marks before saving to nodes.
- Use in data-cleanup workflows for legacy content migration.
- Reject non-string input safely via a TamperException.
- Improve search and display quality of imported feed content.