<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Tamper Convert Encoding adds one Tamper plugin (`convert_encoding`) that converts a value from one character encoding to another during an import — the fix for a feed arriving as ISO-8859-1 or Windows-1252 and landing in Drupal as mojibake.

---

Feeds and Tamper handle the fetch-and-transform half of an import, and Tamper's built-in plugin set covers most of what a row needs on its way in — trimming, exploding, rewriting, defaults — but not character-encoding conversion. This module supplies that missing plugin. It is essentially the whole module: four files (the plugin class, `.info.yml`, `README.txt`, `LICENSE.txt`), with no routes, no permissions, and no config of its own. The plugin (`Drupal\feeds_tamper_convert_encoding\Plugin\Tamper\ConvertEncoding`, id `convert_encoding`, category "Text") extends Tamper's `TamperBase` and exposes three settings: **Input encoding**, **Output encoding**, and a **Mode** for handling characters that cannot be represented in the target (`//IGNORE`, `//TRANSLIT`, or none). Despite the code comments referring to `mb_convert_encoding`, the actual transform calls PHP's **`iconv($input_encoding, $output_encoding . $mode, $data)`** — the `mb_list_encodings()` list is only used to populate the two encoding select fields. Defaults are output `UTF-8` and mode `//IGNORE`. Dependencies are `tamper` and core `system (>=8.5.0)`, with a wide `^8 || ^9 || ^10 || ^11` range; note that despite the project name it depends on **Tamper**, not on Feeds directly, so it works anywhere Tamper plugins are consumed. The practical guidance is to convert at import rather than after: fixing encoding once mangled text is in the database means guessing the original bytes, which is not always recoverable.

---

- Convert an ISO-8859-1 feed to UTF-8 on import.
- Fix mojibake from a Windows-1252 source feed.
- Normalise encoding to UTF-8 across several importers.
- Handle a legacy system exporting non-UTF-8 CSV.
- Convert encoding on a specific field within a Tamper pipeline.
- Avoid storing mangled accented characters in Drupal.
- Import European-language content with correct diacritics.
- Repair a supplier's product feed that broke after an export-format change.
- Normalise encoding before deduplication or matching.
- Convert encoding for a Feeds-based content migration source.
- Chain encoding conversion with other Tamper plugins (trim, explode, etc.).
- Handle mixed-encoding data sources by mapping each to a per-field plugin.
- Keep search indexing accurate for imported non-ASCII text.
- Transliterate characters absent from the target encoding via `//TRANSLIT`.
- Silently drop untranslatable characters via `//IGNORE` (the default).
- Convert down to a restricted encoding (e.g. ASCII) for a downstream system.
- Clean text at the point of entry rather than after storage.
- Reuse the plugin across any Tamper consumer, not only Feeds.
- Convert encoding without writing a custom Tamper plugin.
- Support a long-lived import across Drupal 8–11.
