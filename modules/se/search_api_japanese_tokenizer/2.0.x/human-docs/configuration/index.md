# Configuration

There is no site-wide settings page for this module. You configure it per search
index, on the index's **Processors** tab — with one extra step in `settings.php`
if you use the MeCab or Sudachi engines.

## Set up the server and index

If you have not already, go to **Configuration → Search and metadata → Search
API** (`/admin/config/search/search-api`) and set up a search server and a search
index in the normal Search API way.

## Choose the tokenizer

1. Edit your index and open the **Processors** tab.
2. Enable the tokenizer that matches the submodule you turned on. In the processor
   settings you can choose from:
   - **TinySegmenter tokenizer**
   - **Igo-php tokenizer**
   - **MeCab tokenizer**
   - **Sudachi tokenizer**

   Only the tokenizers whose analyzer is actually available on the server are
   shown. Enable **only one** Japanese tokenizer per index.

Depending on the engine, the processor exposes options such as excluding index
entries by character type (TinySegmenter only) or excluding tokens by part of
speech and reducing words to their base form (the morphological analyzers —
Igo-php, MeCab, and Sudachi).

## Turn off the conflicting core processors

For Japanese tokenization to work correctly you must **disable** two of Drupal's
default processors on the same index:

- **Tokenizer** — leaving the core Tokenizer processor enabled can cause incorrect
  indexing, so switch it off.
- **Transliteration** — this converts Japanese characters into their alphabetic
  representations, which prevents indexed tokens from ever matching Japanese
  search keywords. Switch it off too.

## Analyzer paths for MeCab and Sudachi

If you chose the **MeCab** or **Sudachi** tokenizer, the path to the analyzer is
set in your site's `settings.php` rather than in the processor form. (In the 1.x
series these lived in the processor settings; they moved to `settings.php` in
2.x.) The pure-PHP tokenizers, TinySegmenter and Igo-php, need no such path.

## Save and re-index

Save the Processors form, then queue your content for re-indexing so the new
tokenization is applied. Once re-indexed, Japanese searches match at the word
level — including single-character words — rather than by fixed-length N-grams.
